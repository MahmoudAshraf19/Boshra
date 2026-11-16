import 'dart:async';
import 'dart:math' as math;

import 'package:android_intent_plus/android_intent.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/known_cities.dart';
import '../utils/app_logger.dart';

/// Where the coordinates used for prayer times really came from.
enum LocationSource {
  /// Fresh GPS/network fix.
  gps,
  /// OS "last known" fix (fast, usually minutes old).
  lastKnown,
  /// Last coordinates this app saved earlier.
  cached,
  /// City picked by the user.
  manual,
  /// Approximate (city-level) position from the network/IP, used only when the device
  /// cannot give a real fix (no GPS, no Google services, permission denied, wrong fix).
  network,
  /// Nothing available → default city (NOT a real location; the UI warns about it).
  defaultCity,
}

class ResolvedLocation {
  final double lat;
  final double lng;
  final LocationSource source;
  final String? name;
  final double? accuracyM;
  const ResolvedLocation(this.lat, this.lng, this.source, {this.name, this.accuracyM});

  /// false only for the default city.
  bool get isReal => source != LocationSource.defaultCity;

  /// city-level only (IP based): good for prayer times (±1-2 min) but the UI invites the
  /// user to confirm the city.
  bool get isApproximate => source == LocationSource.network;
}

/// Single owner of "where is the user" for prayer times.
///
/// Fixes vs. the old version:
///  * Never silently falls back to Makkah any more (default = the city of the device's
///    time-zone, Cairo for Egypt) and always tells the UI when it is using a default.
///  * 5 s / high-accuracy GPS timeout (fails indoors → permanent "wrong location") replaced by
///    last-known → medium accuracy 15 s → cache chain.
///  * Manual city selection (works with no permission / no GPS at all).
///  * Distinguishes "permission denied" from "no fix yet".
class LocationService {
  static const _kLat = 'last_latitude';
  static const _kLng = 'last_longitude';
  static const _kTime = 'last_location_time';
  static const _kSource = 'location_source';
  static const _kAcc = 'last_location_accuracy';
  static const _kIssue = 'location_last_issue';
  static const _kIpTry = 'location_ip_try_ms';
  static const _kManual = 'manual_loc_enabled';
  static const _kManualLat = 'manual_loc_lat';
  static const _kManualLng = 'manual_loc_lng';
  static const _kManualName = 'manual_loc_name';

  /// A new fix farther than this from the saved one = the user really moved.
  static const movedKm = 15.0;

  // ---------------------------------------------------------------- manual city
  Future<bool> isManual() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kManual) ?? false;
  }

  Future<void> setManualCity(KnownCity c, {required bool arabic}) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kManual, true);
    await p.setDouble(_kManualLat, c.lat);
    await p.setDouble(_kManualLng, c.lng);
    await p.setString(_kManualName, c.name(arabic));
    await p.setString(_kSource, LocationSource.manual.name);
    await p.setBool('prayer_location_fallback', false);
    // The location changed → the name cache of the Home screen is stale too.
    await p.setString('cached_location_name', c.name(arabic));
  }

  /// Any place the user searched or pinned on the map (Google Places / map picker).
  Future<void> setManualPlace(double lat, double lng, String name) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kManual, true);
    await p.setDouble(_kManualLat, lat);
    await p.setDouble(_kManualLng, lng);
    await p.setString(_kManualName, name);
    await p.setString(_kSource, LocationSource.manual.name);
    await p.setBool('prayer_location_fallback', false);
    await p.setString('cached_location_name', name);
    await p.setDouble(_kLat, lat); // also the "last known", so every consumer agrees
    await p.setDouble(_kLng, lng);
    await p.setInt(_kTime, DateTime.now().millisecondsSinceEpoch);
  }

  /// Back to automatic (GPS) mode.
  Future<void> clearManualCity() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kManual, false);
  }

  // ------------------------------------------------------------------ defaults
  Future<KnownCity> defaultCity() async {
    try {
      final dynamic r = await FlutterTimezone.getLocalTimezone();
      final name = r is String ? r : (r.identifier as String);
      return KnownCities.byTimeZone(name);
    } catch (_) {
      return KnownCities.cairo;
    }
  }

  /// Aladhan method that matches the region (Egypt → Egyptian authority). -1 = let the API decide.
  static int suggestMethod(double lat, double lng) {
    final inEgypt = lat >= 21.9 && lat <= 31.9 && lng >= 24.6 && lng <= 36.0;
    return inEgypt ? 5 : -1;
  }

  static double distanceKm(double lat1, double lng1, double lat2, double lng2) {
    const r = 6371.0;
    double rad(double d) => d * math.pi / 180;
    final a = math.pow(math.sin(rad(lat2 - lat1) / 2), 2) +
        math.cos(rad(lat1)) * math.cos(rad(lat2)) * math.pow(math.sin(rad(lng2 - lng1) / 2), 2);
    return 2 * r * math.asin(math.sqrt(a));
  }

  // -------------------------------------------------------------- permissions
  /// Current state without prompting.
  Future<({bool serviceOn, LocationPermission permission})> status() async {
    bool on = false;
    LocationPermission perm = LocationPermission.denied;
    try {
      on = await Geolocator.isLocationServiceEnabled();
      perm = await Geolocator.checkPermission();
    } catch (e) {
      appLog('Location status error: $e');
    }
    return (serviceOn: on, permission: perm);
  }

  bool _granted(LocationPermission p) =>
      p == LocationPermission.whileInUse || p == LocationPermission.always;

  // ---------------------------------------------------------------- resolution
  Future<ResolvedLocation?> _saved(SharedPreferences prefs) async {
    final lat = prefs.getDouble(_kLat);
    final lng = prefs.getDouble(_kLng);
    if (lat == null || lng == null) return null;
    return ResolvedLocation(lat, lng, LocationSource.cached);
  }

  Future<void> _save(SharedPreferences prefs, double lat, double lng, LocationSource s) async {
    await prefs.setDouble(_kLat, lat);
    await prefs.setDouble(_kLng, lng);
    await prefs.setInt(_kTime, DateTime.now().millisecondsSinceEpoch);
    await prefs.setString(_kSource, s.name);
  }

  // ----------------------------------------------------------- validation helpers
  static bool _validCoord(double lat, double lng) {
    if (lat.isNaN || lng.isNaN || lat.isInfinite || lng.isInfinite) return false;
    if (lat < -90 || lat > 90 || lng < -180 || lng > 180) return false;
    // "Null island" (0,0) = the classic wrong value some ROMs/emulators return.
    if (lat.abs() < 0.5 && lng.abs() < 0.5) return false;
    return true;
  }

  static bool _validPosition(Position p) {
    if (!_validCoord(p.latitude, p.longitude)) return false;
    if (p.accuracy > 0 && p.accuracy > 50000) return false; // > 50 km = useless
    return true;
  }

  /// Longitude vs. the device's UTC offset. Real positions agree within a few hours; a fix
  /// that is 6+ hours off is a mock location, an emulator default or swapped coordinates.
  static bool tzConsistent(double lng) {
    final deviceH = DateTime.now().timeZoneOffset.inMinutes / 60.0;
    return (lng / 15.0 - deviceH).abs() <= 5.5;
  }

  Future<void> _issue(SharedPreferences prefs, String? why) async {
    if (why == null) {
      await prefs.remove(_kIssue);
    } else {
      await prefs.setString(_kIssue, why);
    }
  }

  /// Last problem found while trying to get a real fix (for the diagnostics screen).
  Future<String?> lastIssue() async =>
      (await SharedPreferences.getInstance()).getString(_kIssue);

  // ---------------------------------------------------------------- resolution
  /// Best available coordinates, NEVER null.
  ///  [allowGps] false → background / cache-only (never touches GPS or network).
  ///  [requestPermission] true → may show the system permission dialog.
  ///
  /// Chain: manual city → device fix (Fused → Android LocationManager → low accuracy →
  /// last known) → recent saved fix → IP position (approximate) → older saved fix → default.
  Future<ResolvedLocation> resolve({
    bool allowGps = true,
    bool requestPermission = false,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.reload(); // the background isolate writes here too
    } catch (_) {}

    // 1) the user's own choice always wins
    if (prefs.getBool(_kManual) ?? false) {
      final lat = prefs.getDouble(_kManualLat);
      final lng = prefs.getDouble(_kManualLng);
      if (lat != null && lng != null) {
        return ResolvedLocation(lat, lng, LocationSource.manual, name: prefs.getString(_kManualName));
      }
    }

    // 2) a real device fix
    if (allowGps && !kIsWeb) {
      final fix = await _tryDevice(prefs, requestPermission: requestPermission, timeout: timeout);
      if (fix != null) return fix;
    }

    // 3) recently saved fix (< 3 days) is better than a coarse IP guess
    final saved = await _saved(prefs);
    final savedAt = prefs.getInt(_kTime);
    final savedAgeOk = saved != null &&
        (savedAt == null ||
            DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(savedAt)) <
                const Duration(days: 3));
    if (saved != null && (savedAgeOk || !allowGps)) return saved;

    // 4) approximate position from the network (works with no permission / no GPS / no GMS)
    if (allowGps && !kIsWeb) {
      final ip = await _tryIp(prefs);
      if (ip != null) return ip;
    }

    // 5) any saved fix, however old
    if (saved != null) return saved;

    // 6) default city of the device's region (flagged so the UI can warn)
    final c = await defaultCity();
    final arabic = (prefs.getString('language_code') ?? 'ar') == 'ar';
    return ResolvedLocation(c.lat, c.lng, LocationSource.defaultCity, name: c.name(arabic));
  }

  Future<ResolvedLocation?> _tryDevice(SharedPreferences prefs,
      {required bool requestPermission, required Duration timeout}) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await _issue(prefs, 'service_off');
        return null;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied && requestPermission) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever) {
        await _issue(prefs, 'permission_forever');
        return null;
      }
      if (!_granted(perm)) {
        await _issue(prefs, 'permission_denied');
        return null;
      }

      final prevLat = prefs.getDouble(_kLat);
      final prevLng = prefs.getDouble(_kLng);
      bool sawMock = false;

      // A fix is only trusted fast when it is fresh, reasonably accurate AND consistent with
      // where we were before (a far-away "last known" is exactly the Samsung/Wi-Fi-cache bug).
      Position? best;
      final recent = await _lastKnown(maxAge: const Duration(minutes: 20));
      if (recent != null && recent.isMocked) {
        sawMock = true;
      } else if (recent != null && recent.accuracy <= 3000) {
        final near = prevLat == null ||
            distanceKm(prevLat, prevLng!, recent.latitude, recent.longitude) < 50;
        if (near) best = recent;
      }

      // 1) Live stream: collect readings and keep the MOST ACCURATE one (the first reading on
      //    many Samsung/Xiaomi phones is a coarse cached network fix).
      if (best == null) {
        final r = await _streamBest(
          maxWait: Duration(seconds: timeout.inSeconds.clamp(10, 30)),
          goodAccuracy: 150,
          okAccuracy: 1500,
        );
        sawMock = sawMock || r.sawMock;
        if (r.best != null) best = r.best;
      }
      // 2) Android's own LocationManager (no Play Services / outdated GMS / OEM quirks).
      if (best == null) {
        final p = await _currentFix(acc: LocationAccuracy.medium, legacy: true, timeout: const Duration(seconds: 12));
        if (p != null && _validPosition(p)) {
          if (p.isMocked) {
            sawMock = true;
          } else {
            best = p;
          }
        }
      }
      // 3) Network/low accuracy (works indoors).
      if (best == null) {
        final p = await _currentFix(acc: LocationAccuracy.low, legacy: false, timeout: const Duration(seconds: 8));
        if (p != null && _validPosition(p)) {
          if (p.isMocked) {
            sawMock = true;
          } else {
            best = p;
          }
        }
      }
      // 4) Stale last-known (up to 24 h) beats nothing.
      if (best == null) {
        final p = await _lastKnown(maxAge: const Duration(hours: 24));
        if (p != null && !p.isMocked) best = p;
      }

      if (best == null) {
        await _issue(prefs, sawMock ? 'mock_location' : 'no_fix');
        return null;
      }

      // Big jump from the previous position with a coarse fix → confirm with a 2nd sample.
      if (prevLat != null &&
          best.accuracy > 500 &&
          distanceKm(prevLat, prevLng!, best.latitude, best.longitude) > 50) {
        final again = await _streamBest(maxWait: const Duration(seconds: 8), goodAccuracy: 150, okAccuracy: 1500);
        final b2 = again.best;
        if (b2 != null) {
          final agree = distanceKm(best.latitude, best.longitude, b2.latitude, b2.longitude) < 15;
          if (!agree && b2.accuracy < best.accuracy) best = b2;
          appLog('Location jump confirmed (agree=$agree)');
        }
      }

      // Sanity: a fix that contradicts the phone's time zone is mock/emulator/bad data.
      if (!tzConsistent(best.longitude)) {
        appLog('Location fix contradicts device time zone → verifying with network');
        await _issue(prefs, 'tz_mismatch');
        final ip = await _tryIp(prefs, force: true);
        if (ip != null && tzConsistent(ip.lng)) return ip;
        if (best.isMocked) return null;
      } else {
        await _issue(prefs, sawMock ? 'mock_location_ignored' : null);
      }

      await _save(prefs, best.latitude, best.longitude, LocationSource.gps);
      await prefs.setDouble(_kAcc, best.accuracy);
      return ResolvedLocation(best.latitude, best.longitude, LocationSource.gps,
          accuracyM: best.accuracy);
    } catch (e, s) {
      AppLogger.e('LocationService', e, s, 'device location');
      await _issue(prefs, 'error');
    }
    return null;
  }

  /// Listens to the position stream and returns the most accurate valid, non-mock, recent
  /// reading. Finishes early at [goodAccuracy] metres, or at [okAccuracy] after 6 s.
  Future<({Position? best, bool sawMock})> _streamBest({
    required Duration maxWait,
    required double goodAccuracy,
    required double okAccuracy,
  }) async {
    Position? best;
    var sawMock = false;
    final done = Completer<void>();
    StreamSubscription<Position>? sub;
    final timers = <Timer>[];

    void finish() {
      if (!done.isCompleted) done.complete();
    }

    try {
      sub = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0),
      ).listen((p) {
        if (!_validPosition(p)) return;
        if (p.isMocked) {
          sawMock = true;
          return;
        }
        final DateTime? ts = p.timestamp;
        if (ts != null && DateTime.now().difference(ts).abs() > const Duration(minutes: 2)) return; // stale
        if (best == null || p.accuracy < best!.accuracy) best = p;
        if (best!.accuracy <= goodAccuracy) finish();
      }, onError: (_) => finish());
      timers.add(Timer(const Duration(seconds: 6), () {
        if (best != null && best!.accuracy <= okAccuracy) finish();
      }));
      timers.add(Timer(maxWait, finish));
      await done.future;
    } catch (e) {
      appLog('position stream: $e');
    } finally {
      for (final t in timers) {
        t.cancel();
      }
      await sub?.cancel();
    }
    return (best: best, sawMock: sawMock);
  }

  // ------------------------------------------------------------- health / UI helpers
  /// Opens the most relevant system page to improve accuracy (Google Location Accuracy →
  /// otherwise the main Location settings). On Samsung this is where "Improve accuracy"
  /// (Wi-Fi / Bluetooth scanning) lives.
  Future<void> openAccuracySettings() async {
    try {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        await const AndroidIntent(action: 'com.google.android.gms.location.settings.GOOGLE_LOCATION_SETTINGS')
            .launch();
        return;
      }
    } catch (_) {}
    try {
      await Geolocator.openLocationSettings();
    } catch (_) {}
  }

  /// Forces a brand-new reading (user pressed "Update my location").
  Future<ResolvedLocation> refreshNow() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kIpTry);
    return resolve(requestPermission: true, timeout: const Duration(seconds: 25));
  }

  /// Everything the diagnostics screen needs about the current position.
  Future<Map<String, Object?>> snapshot() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return {
      'lat': prefs.getDouble(_kLat),
      'lng': prefs.getDouble(_kLng),
      'time': prefs.getInt(_kTime),
      'acc': prefs.getDouble(_kAcc),
      'source': prefs.getString(_kSource),
      'issue': prefs.getString(_kIssue),
      'manual': prefs.getBool(_kManual) ?? false,
    };
  }

  Future<Position?> _lastKnown({required Duration maxAge}) async {
    for (final legacy in [false, true]) {
      try {
        final p = await Geolocator.getLastKnownPosition(forceAndroidLocationManager: legacy);
        if (p == null || !_validPosition(p)) continue;
        final DateTime? ts = p.timestamp;
        if (ts == null || DateTime.now().difference(ts).abs() <= maxAge) return p;
      } catch (_) {}
    }
    return null;
  }

  Future<Position?> _currentFix(
      {required LocationAccuracy acc, required bool legacy, required Duration timeout}) async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: acc,
        forceAndroidLocationManager: legacy,
        timeLimit: timeout,
      );
    } catch (e) {
      appLog('getCurrentPosition(${acc.name}, legacy=$legacy): $e');
      return null;
    }
  }

  // ------------------------------------------------------------ IP (approximate)
  Future<ResolvedLocation?> _tryIp(SharedPreferences prefs, {bool force = false}) async {
    try {
      final last = prefs.getInt(_kIpTry) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      if (!force && now - last < const Duration(minutes: 30).inMilliseconds) return null;
      await prefs.setInt(_kIpTry, now);

      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 6),
        receiveTimeout: const Duration(seconds: 6),
      ));
      String? deviceTz;
      try {
        final dynamic r = await FlutterTimezone.getLocalTimezone();
        deviceTz = r is String ? r : (r.identifier as String);
      } catch (_) {}

      double? lat, lng;
      String? city, country, tzId;
      try {
        final r = await dio.get('https://ipwho.is/');
        final d = r.data;
        if (d is Map && d['success'] == true) {
          lat = (d['latitude'] as num?)?.toDouble();
          lng = (d['longitude'] as num?)?.toDouble();
          city = d['city']?.toString();
          country = d['country']?.toString();
          tzId = (d['timezone'] is Map) ? d['timezone']['id']?.toString() : null;
        }
      } catch (_) {}
      if (lat == null || lng == null) {
        try {
          final r = await dio.get('https://ipapi.co/json/');
          final d = r.data;
          if (d is Map) {
            lat = (d['latitude'] as num?)?.toDouble();
            lng = (d['longitude'] as num?)?.toDouble();
            city = d['city']?.toString();
            country = d['country_name']?.toString();
            tzId = d['timezone']?.toString();
          }
        } catch (_) {}
      }
      if (lat == null || lng == null || !_validCoord(lat, lng)) return null;
      // VPN / proxy: the IP's country time zone differs from the phone's → not the user's place.
      if (tzId != null && deviceTz != null && tzId != deviceTz && !tzConsistent(lng)) return null;
      if (!tzConsistent(lng)) return null;

      await _save(prefs, lat, lng, LocationSource.network);
      final name = [city, country].where((e) => e != null && e.isNotEmpty).join(', ');
      return ResolvedLocation(lat, lng, LocationSource.network,
          name: name.isEmpty ? null : name, accuracyM: 25000);
    } catch (e) {
      appLog('IP location failed: $e');
      return null;
    }
  }

  // ------------------------------------------------------- backwards compatible
  /// Old API (Qibla, Home, dialogs): a real position or null — never a default city.
  Future<Position?> getCurrentLocation({bool requestPermission = true}) async {
    final r = await resolve(requestPermission: requestPermission);
    if (!r.isReal) return null;
    return Position(
      latitude: r.lat,
      longitude: r.lng,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );
  }

  Stream<Position>? getLocationStream({int distanceFilter = 50}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      ),
    );
  }

  /// "City, Country" via reverse geocoding (cached; works offline after the first time).
  Future<String?> getLocationName(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'location_name_${latitude.toStringAsFixed(2)}_${longitude.toStringAsFixed(2)}';
    final cachedName = prefs.getString(cacheKey);
    if (cachedName != null) return cachedName;
    if (kIsWeb) return 'Web User (No GPS)';
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String name = '';
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          name = '${place.administrativeArea}';
        } else if (place.locality != null && place.locality!.isNotEmpty) {
          name = '${place.locality}';
        }
        if (place.country != null && place.country!.isNotEmpty) {
          name = name.isNotEmpty ? '$name, ${place.country}' : place.country!;
        }
        if (name.isNotEmpty) {
          prefs.setString(cacheKey, name);
          return name;
        }
      }
    } catch (e) {
      appLog('Error reverse geocoding: $e');
    }
    // Devices without Google services often can't reverse-geocode: use the nearest known city.
    KnownCity? nearest;
    double nd = 80; // km
    for (final c in KnownCities.all) {
      final d = distanceKm(latitude, longitude, c.lat, c.lng);
      if (d < nd) {
        nd = d;
        nearest = c;
      }
    }
    if (nearest != null) {
      final arabic = (prefs.getString('language_code') ?? 'ar') == 'ar';
      return nearest.name(arabic);
    }
    return null;
  }
}
