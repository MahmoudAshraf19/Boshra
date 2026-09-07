import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/services/location_service.dart';
import '../../data/services/compass_service.dart';
import '../../domain/services/qibla_calculator.dart';
import '../../domain/heading_processor.dart';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

enum QiblaStatus {
  init,
  requestLocation,
  locationReady,
  unsupported,
  calibration,
  active,
  qiblaLocked
}

class QiblaState {
  final QiblaStatus status;
  final Position? location;
  final double? qiblaBearing;
  final double? deviceHeading;
  final double? relativeBearing;
  final double? accuracy;
  final String? error;

  QiblaState({
    this.status = QiblaStatus.init,
    this.location,
    this.qiblaBearing,
    this.deviceHeading,
    this.relativeBearing,
    this.accuracy,
    this.error,
  });

  bool get isLocked => status == QiblaStatus.qiblaLocked;

  QiblaState copyWith({
    QiblaStatus? status,
    Position? location,
    double? qiblaBearing,
    double? deviceHeading,
    double? relativeBearing,
    double? accuracy,
    String? error,
  }) {
    return QiblaState(
      status: status ?? this.status,
      location: location ?? this.location,
      qiblaBearing: qiblaBearing ?? this.qiblaBearing,
      deviceHeading: deviceHeading ?? this.deviceHeading,
      relativeBearing: relativeBearing ?? this.relativeBearing,
      accuracy: accuracy ?? this.accuracy,
      error: error ?? this.error,
    );
  }
}

class QiblaController {
  final LocationService _locationService = LocationService();
  final CompassService _compassService = CompassService();
  final QiblaCalculator _qiblaCalculator = QiblaCalculator();
  final HeadingProcessor _headingProcessor = HeadingProcessor();

  StreamSubscription<double>? _headingSub;
  StreamSubscription<double?>? _accuracySub;

  QiblaState _state = QiblaState();
  
  final _stateController = StreamController<QiblaState>.broadcast();
  Stream<QiblaState> get stateStream => _stateController.stream;

  bool _hasTriggeredAlignment = false;
  final double _enterThreshold = 3.0;
  final double _exitThreshold = 6.0;

  void init() async {
    debugPrint('🕋 [Qibla] ⏳ Requesting Location Access...');
    _updateState(_state.copyWith(status: QiblaStatus.requestLocation));

    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      debugPrint('🕋 [Qibla] ❌ Location access denied or unavailable!');
      _updateState(_state.copyWith(
        status: QiblaStatus.init,
        error: "Location access denied or unavailable.",
      ));
      return;
    }

    final bearing = _qiblaCalculator.calculateBearing(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    debugPrint('🕋 [Qibla] 📍 Location Found: (${position.latitude}, ${position.longitude})');
    debugPrint('🕋 [Qibla] 🎯 Qibla Bearing Calculated: ${bearing.toStringAsFixed(2)}°');

    _updateState(_state.copyWith(
      status: QiblaStatus.locationReady,
      location: position,
      qiblaBearing: bearing,
    ));

    debugPrint('🕋 [Qibla] 🧭 Starting Compass Sensor...');
    _startCompass();
  }

  void _startCompass() {
    _compassService.start();

    _accuracySub = _compassService.accuracyStream.listen((accuracy) {
      // Accuracy is roughly the deviation in degrees. 
      // If accuracy > 30, it might need calibration.
      if (accuracy != null && accuracy > 30) {
        if (_state.status != QiblaStatus.calibration) {
          debugPrint('🕋 [Qibla] ⚠️ Low Compass Accuracy ($accuracy). Need Calibration (Figure-8)!');
          _updateState(_state.copyWith(status: QiblaStatus.calibration, accuracy: accuracy));
        }
      } else if (_state.status == QiblaStatus.calibration) {
        debugPrint('🕋 [Qibla] ✅ Compass Calibrated (Accuracy: $accuracy).');
        _updateState(_state.copyWith(status: QiblaStatus.active, accuracy: accuracy));
      } else {
        _updateState(_state.copyWith(accuracy: accuracy));
      }
    });

    _headingSub = _compassService.headingStream.listen((rawHeading) {
      // DEBUG:
      // Removed debugPrint for cleaner logs

      if (_state.qiblaBearing == null) return;
      if (_state.status == QiblaStatus.calibration) return;

      final smoothedHeading = _headingProcessor.smoothHeading(rawHeading);
      final relativeBearing = _headingProcessor.calculateRelativeBearing(_state.qiblaBearing!, smoothedHeading);

      // Hysteresis Logic for Alignment
      double diff = relativeBearing.abs();
      if (diff > 180) diff = 360 - diff; // Convert to absolute smallest difference (0-180)

      bool isAligned = false;
      if (!_hasTriggeredAlignment && diff <= _enterThreshold) {
        // Just entered alignment
        isAligned = true;
        _hasTriggeredAlignment = true;
        debugPrint('🕋 [Qibla] ✨ ALIGNED! You are facing the Qibla! Triggering Hardware Vibration!');
        HapticFeedback.vibrate(); // Fallback flutter haptic
        Vibration.vibrate(duration: 300, amplitude: 255); // Strong native hardware vibration
      } else if (_hasTriggeredAlignment && diff <= _exitThreshold) {
        // Still aligned (within hysteresis margin)
        isAligned = true;
      } else {
        // Outside alignment
        if (_hasTriggeredAlignment) {
           debugPrint('🕋 [Qibla] 🚶‍♂️ Lost Alignment (moved away by > $_exitThreshold°).');
        }
        _hasTriggeredAlignment = false;
      }

      QiblaStatus newStatus = isAligned ? QiblaStatus.qiblaLocked : QiblaStatus.active;

      _updateState(_state.copyWith(
        deviceHeading: smoothedHeading,
        relativeBearing: relativeBearing,
        status: newStatus,
      ));
    });
  }

  void _updateState(QiblaState newState) {
    _state = newState;
    _stateController.add(_state);
  }

  void dispose() {
    _headingSub?.cancel();
    _accuracySub?.cancel();
    _compassService.dispose();
    _stateController.close();
  }
}
