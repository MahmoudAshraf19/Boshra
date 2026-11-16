import 'dart:convert';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/maps_config.dart';
import '../data/known_cities.dart';
import '../utils/app_logger.dart';

/// A place chosen by the user (search result or map pin).
class PickedPlace {
  final double lat;
  final double lng;
  final String name;
  final String? address;
  const PickedPlace(this.lat, this.lng, this.name, {this.address});

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng, 'name': name, 'addr': address};

  factory PickedPlace.fromJson(Map<String, dynamic> j) => PickedPlace(
        (j['lat'] as num).toDouble(),
        (j['lng'] as num).toDouble(),
        j['name'] as String,
        address: j['addr'] as String?,
      );
}

class PlaceSuggestion {
  final String? placeId; // null when the suggestion already carries coordinates (geocode fallback)
  final String primary;
  final String secondary;
  final PickedPlace? resolved;
  const PlaceSuggestion({this.placeId, required this.primary, required this.secondary, this.resolved});
}

/// Search for places and reverse-geocode map points with Google Places (New) and the Geocoding API,
/// degrading gracefully: Places autocomplete → Geocoding search → the built-in city list.
///
/// Cost control: debounce is done by the caller, one session token per search (autocomplete +
/// details are billed together as one session), minimum 2 characters.
class PlacesService {
  PlacesService._();
  static final PlacesService instance = PlacesService._();

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
    validateStatus: (s) => s != null && s < 500,
  ));

  static const _recentKey = 'recent_places_v1';

  String newSessionToken() {
    final r = math.Random.secure();
    String h(int n) => List.generate(n, (_) => r.nextInt(16).toRadixString(16)).join();
    return '${h(8)}-${h(4)}-4${h(3)}-a${h(3)}-${h(12)}';
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': MapsConfig.restKey,
        if (MapsConfig.androidCertSha1.isNotEmpty) ...{
          'X-Android-Package': MapsConfig.androidPackage,
          'X-Android-Cert': MapsConfig.androidCertSha1,
        },
      };

  // ---------------------------------------------------------------- autocomplete
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    required String lang,
    required String sessionToken,
    double? biasLat,
    double? biasLng,
  }) async {
    final q = input.trim();
    if (q.length < 2) return const [];
    if (MapsConfig.enabled) {
      try {
        final r = await _dio.post(
          'https://places.googleapis.com/v1/places:autocomplete',
          options: Options(headers: _headers),
          data: {
            'input': q,
            'languageCode': lang,
            'sessionToken': sessionToken,
            if (biasLat != null && biasLng != null)
              'locationBias': {
                'circle': {
                  'center': {'latitude': biasLat, 'longitude': biasLng},
                  'radius': 50000.0,
                },
              },
          },
        );
        if (r.statusCode == 200 && r.data is Map) {
          final out = <PlaceSuggestion>[];
          for (final s in (r.data['suggestions'] as List? ?? const [])) {
            final p = (s as Map)['placePrediction'] as Map?;
            if (p == null) continue;
            final sf = p['structuredFormat'] as Map?;
            final main = (sf?['mainText'] as Map?)?['text']?.toString() ?? (p['text'] as Map?)?['text']?.toString() ?? '';
            final sec = (sf?['secondaryText'] as Map?)?['text']?.toString() ?? '';
            if (main.isEmpty) continue;
            out.add(PlaceSuggestion(placeId: p['placeId']?.toString(), primary: main, secondary: sec));
          }
          if (out.isNotEmpty) return out;
        } else {
          appLog('Places autocomplete ${r.statusCode}: ${_errMsg(r.data)}');
        }
      } catch (e) {
        appLog('Places autocomplete failed: $e');
      }
      // Places not enabled / quota → plain geocoding search
      final g = await _geocodeSearch(q, lang);
      if (g.isNotEmpty) return g;
    }
    return _localSearch(q, lang);
  }

  Future<PickedPlace?> details(PlaceSuggestion s, {required String lang, required String sessionToken}) async {
    if (s.resolved != null) return s.resolved;
    final id = s.placeId;
    if (id == null) return null;
    try {
      final r = await _dio.get(
        'https://places.googleapis.com/v1/places/$id',
        queryParameters: {'languageCode': lang, 'sessionToken': sessionToken},
        options: Options(headers: {
          ..._headers,
          'X-Goog-FieldMask': 'id,displayName,formattedAddress,location',
        }),
      );
      if (r.statusCode == 200 && r.data is Map) {
        final loc = r.data['location'] as Map?;
        if (loc != null) {
          final name = ((r.data['displayName'] as Map?)?['text'] ?? s.primary).toString();
          return PickedPlace(
            (loc['latitude'] as num).toDouble(),
            (loc['longitude'] as num).toDouble(),
            s.secondary.isEmpty ? name : '$name، ${s.secondary}',
            address: r.data['formattedAddress']?.toString(),
          );
        }
      }
      appLog('Place details ${r.statusCode}: ${_errMsg(r.data)}');
    } catch (e) {
      appLog('Place details failed: $e');
    }
    // fall back: geocode the text we have
    final g = await _geocodeSearch('${s.primary} ${s.secondary}', lang);
    return g.isNotEmpty ? g.first.resolved : null;
  }

  // ------------------------------------------------------------------- geocoding
  Future<List<PlaceSuggestion>> _geocodeSearch(String q, String lang) async {
    try {
      final r = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {'address': q, 'language': lang, 'key': MapsConfig.restKey},
        options: Options(headers: {
          if (MapsConfig.androidCertSha1.isNotEmpty) ...{
            'X-Android-Package': MapsConfig.androidPackage,
            'X-Android-Cert': MapsConfig.androidCertSha1,
          },
        }),
      );
      if (r.statusCode == 200 && r.data is Map && r.data['status'] == 'OK') {
        final out = <PlaceSuggestion>[];
        for (final res in (r.data['results'] as List).take(5)) {
          final loc = (res['geometry'] as Map)['location'] as Map;
          final addr = res['formatted_address'].toString();
          final parts = addr.split(RegExp(r'[،,]')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
          out.add(PlaceSuggestion(
            primary: parts.isEmpty ? addr : parts.first,
            secondary: parts.length > 1 ? parts.sublist(1).join('، ') : '',
            resolved: PickedPlace((loc['lat'] as num).toDouble(), (loc['lng'] as num).toDouble(), addr, address: addr),
          ));
        }
        return out;
      }
      appLog('Geocode search: ${r.data is Map ? r.data['status'] : r.statusCode}');
    } catch (e) {
      appLog('Geocode search failed: $e');
    }
    return const [];
  }

  /// Name for a map point ("Nasr City, Cairo, Egypt"), or null offline.
  Future<String?> reverse(double lat, double lng, {required String lang}) async {
    if (!MapsConfig.enabled) return null;
    try {
      final r = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '$lat,$lng',
          'language': lang,
          'result_type': 'locality|sublocality|administrative_area_level_2|administrative_area_level_1|country',
          'key': MapsConfig.restKey,
        },
        options: Options(headers: {
          if (MapsConfig.androidCertSha1.isNotEmpty) ...{
            'X-Android-Package': MapsConfig.androidPackage,
            'X-Android-Cert': MapsConfig.androidCertSha1,
          },
        }),
      );
      if (r.statusCode == 200 && r.data is Map && r.data['status'] == 'OK') {
        final res = (r.data['results'] as List).first as Map;
        final comps = (res['address_components'] as List).cast<Map>();
        String? pick(String type) {
          for (final c in comps) {
            if ((c['types'] as List).contains(type)) return c['long_name']?.toString();
          }
          return null;
        }
        final local = pick('sublocality') ?? pick('locality') ?? pick('administrative_area_level_2') ?? pick('administrative_area_level_1');
        final country = pick('country');
        final name = [local, country].whereType<String>().where((e) => e.isNotEmpty).join('، ');
        if (name.isNotEmpty) return name;
        return res['formatted_address']?.toString();
      }
    } catch (e) {
      appLog('Reverse geocode failed: $e');
    }
    return null;
  }

  // ---------------------------------------------------------------- offline list
  List<PlaceSuggestion> _localSearch(String q, String lang) {
    final ql = q.toLowerCase();
    final ar = lang == 'ar';
    return [
      for (final c in KnownCities.all)
        if (c.nameAr.contains(q) || c.nameEn.toLowerCase().contains(ql))
          PlaceSuggestion(
            primary: c.name(ar).split(RegExp(r'[،,]')).first.trim(),
            secondary: c.name(ar).contains('،') || c.name(ar).contains(',') ? c.name(ar).split(RegExp(r'[،,]')).skip(1).join('، ').trim() : '',
            resolved: PickedPlace(c.lat, c.lng, c.name(ar)),
          ),
    ].take(8).toList();
  }

  String _errMsg(dynamic d) {
    try {
      if (d is Map && d['error'] is Map) return '${d['error']['status']}: ${d['error']['message']}';
    } catch (_) {}
    return '$d';
  }

  // ---------------------------------------------------------------------- recents
  Future<List<PickedPlace>> recents() async {
    try {
      final p = await SharedPreferences.getInstance();
      final l = (jsonDecode(p.getString(_recentKey) ?? '[]') as List)
          .map((e) => PickedPlace.fromJson((e as Map).cast<String, dynamic>()))
          .toList();
      return l;
    } catch (_) {
      return const [];
    }
  }

  Future<void> addRecent(PickedPlace place) async {
    final p = await SharedPreferences.getInstance();
    final cur = await recents();
    cur.removeWhere((e) => (e.lat - place.lat).abs() < 0.01 && (e.lng - place.lng).abs() < 0.01);
    cur.insert(0, place);
    await p.setString(_recentKey, jsonEncode(cur.take(8).map((e) => e.toJson()).toList()));
  }
}
