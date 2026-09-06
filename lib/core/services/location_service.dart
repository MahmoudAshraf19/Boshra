import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class LocationService {
  Future<Position?> _getLastKnownPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('last_latitude');
    final lng = prefs.getDouble('last_longitude');
    if (lat != null && lng != null) {
      return Position(
        latitude: lat,
        longitude: lng,
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
    return null;
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Fallback to last known location
      return await _getLastKnownPosition();
    }

    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return await _getLastKnownPosition();
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return await _getLastKnownPosition();
      } 
    } catch (e) {
      print('Geolocator permission error: $e');
      return await _getLastKnownPosition();
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );
      
      // Save to cache
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('last_latitude', position.latitude);
      prefs.setDouble('last_longitude', position.longitude);
      
      return position;
    } catch (e) {
      return await _getLastKnownPosition();
    }
  }

  /// Stream location updates with a distance filter (e.g. 50 meters)
  /// to save battery as Qibla bearing doesn't change significantly in short distances.
  Stream<Position>? getLocationStream({int distanceFilter = 50}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      ),
    );
  }

  /// Gets the readable location name (City, Country) using reverse geocoding.
  /// Uses SharedPreferences to cache the result offline.
  Future<String?> getLocationName(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'location_name_${latitude.toStringAsFixed(2)}_${longitude.toStringAsFixed(2)}';

    // 1. Check cache first (offline support)
    final cachedName = prefs.getString(cacheKey);
    if (cachedName != null) {
      return cachedName;
    }

    if (kIsWeb) {
      return 'Web User (No GPS)';
    }

    // 2. Fetch from geocoding API
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

        // 3. Save to cache
        if (name.isNotEmpty) {
          prefs.setString(cacheKey, name);
          return name;
        }
      }
    } catch (e) {
      print('Error reverse geocoding: $e');
    }
    
    return null;
  }
}
