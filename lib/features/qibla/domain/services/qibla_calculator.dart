import 'dart:math' as math;

class QiblaCalculator {
  // Kaaba coordinates
  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  /// Calculates the bearing (in degrees) to the Qibla from the given coordinates.
  double calculateBearing({
    required double latitude,
    required double longitude,
  }) {
    // Convert all coordinates to radians
    final double lat1 = _toRadians(latitude);
    final double lon1 = _toRadians(longitude);
    final double lat2 = _toRadians(kaabaLatitude);
    final double lon2 = _toRadians(kaabaLongitude);

    // Difference in longitude
    final double dLon = lon2 - lon1;

    // Calculate bearing
    final double y = math.sin(dLon) * math.cos(lat2);
    final double x = math.cos(lat1) * math.sin(lat2) - 
                     math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    double bearingRad = math.atan2(y, x);
    
    // Convert to degrees and normalize to 0-360
    double bearingDeg = _toDegrees(bearingRad);
    return (bearingDeg + 360) % 360;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  double _toDegrees(double radians) {
    return radians * (180.0 / math.pi);
  }
}
