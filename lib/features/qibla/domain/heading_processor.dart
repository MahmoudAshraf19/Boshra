import 'dart:math' as math;

class HeadingProcessor {
  double? _lastHeading;

  // Smoothing factor (0.0 to 1.0). Lower is smoother but slower.
  final double alpha = 0.15;
  // Dead zone in degrees
  final double deadZone = 1.0;

  /// Smooths the new heading using a circular low-pass filter
  double smoothHeading(double newHeading) {
    if (_lastHeading == null) {
      _lastHeading = newHeading;
      return newHeading;
    }

    // Handle 360 wrap-around for interpolation
    double diff = newHeading - _lastHeading!;
    if (diff > 180) {
      diff -= 360;
    } else if (diff < -180) {
      diff += 360;
    }

    // Dead zone filter
    if (diff.abs() < deadZone) {
      return _lastHeading!;
    }

    // Apply smoothing
    double smoothed = _lastHeading! + (alpha * diff);
    
    // Normalize back to 0-360
    smoothed = (smoothed + 360) % 360;
    _lastHeading = smoothed;
    
    return smoothed;
  }

  /// Calculates the relative angle needed to rotate the compass arrow
  /// relativeBearing: 0 means device is pointing directly at Qibla
  double calculateRelativeBearing(double qiblaBearing, double trueHeading) {
    double relative = qiblaBearing - trueHeading;
    return (relative + 360) % 360;
  }
}
