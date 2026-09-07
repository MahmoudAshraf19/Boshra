import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentLocation({double desiredAccuracy = 50.0}) async {
    final hasPermission = await checkPermissions();
    if (!hasPermission) return null;

    try {
      // First try to get last known location quickly if it's accurate enough
      final lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null && lastPosition.accuracy <= desiredAccuracy) {
        return lastPosition;
      }

      // Otherwise get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Location error: $e");
      return null;
    }
  }
}
