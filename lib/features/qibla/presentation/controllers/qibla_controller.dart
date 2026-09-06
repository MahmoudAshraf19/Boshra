import 'dart:async';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/compass_service.dart';
import '../../domain/services/qibla_calculator.dart';
import '../../data/models/compass_data_model.dart';
import 'package:geolocator/geolocator.dart';

class QiblaState {
  final bool isLoading;
  final bool hasLocationPermission;
  final bool hasSensor;
  
  final double? qiblaBearing;
  final double? deviceHeading;
  final double? relativeAngle;
  final String? error;

  QiblaState({
    this.isLoading = true,
    this.hasLocationPermission = false,
    this.hasSensor = true,
    this.qiblaBearing,
    this.deviceHeading,
    this.relativeAngle,
    this.error,
  });

  bool get isFacingQibla => (relativeAngle != null && relativeAngle!.abs() <= 5);

  QiblaState copyWith({
    bool? isLoading,
    bool? hasLocationPermission,
    bool? hasSensor,
    double? qiblaBearing,
    double? deviceHeading,
    double? relativeAngle,
    String? error,
  }) {
    return QiblaState(
      isLoading: isLoading ?? this.isLoading,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
      hasSensor: hasSensor ?? this.hasSensor,
      qiblaBearing: qiblaBearing ?? this.qiblaBearing,
      deviceHeading: deviceHeading ?? this.deviceHeading,
      relativeAngle: relativeAngle ?? this.relativeAngle,
      error: error,
    );
  }
}

class QiblaController {
  final LocationService _locationService = LocationService();
  final CompassService _compassService = CompassService();
  final QiblaCalculator _qiblaCalculator = QiblaCalculator();

  StreamSubscription<Position>? _locationSub;
  StreamSubscription<CompassDataModel>? _compassSub;

  QiblaState _state = QiblaState();
  
  // Expose stream for UI
  final _stateController = StreamController<QiblaState>.broadcast();
  Stream<QiblaState> get stateStream => _stateController.stream;

  void init() async {
    _updateState(_state.copyWith(isLoading: true));

    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      _updateState(_state.copyWith(
        isLoading: false, 
        hasLocationPermission: false,
        error: "Location permission denied or GPS disabled.",
      ));
      return;
    }

    _updateState(_state.copyWith(hasLocationPermission: true));

    // Calculate initial bearing
    _updateQiblaBearing(position);

    // Start streaming location changes
    _locationSub = _locationService.getLocationStream(distanceFilter: 100)?.listen((Position p) {
      _updateQiblaBearing(p);
    });

    // Start streaming compass heading
    _compassSub = _compassService.compassStream.listen((CompassDataModel data) {
      if (_state.qiblaBearing != null) {
        double deviceHeading = data.heading;
        double relative = _state.qiblaBearing! - deviceHeading;

        // Normalize to -180 to 180
        if (relative > 180) relative -= 360;
        if (relative < -180) relative += 360;

        _updateState(_state.copyWith(
          isLoading: false,
          deviceHeading: deviceHeading,
          relativeAngle: relative,
        ));
      }
    });
  }

  void _updateQiblaBearing(Position p) {
    double bearing = _qiblaCalculator.calculateBearing(
      latitude: p.latitude,
      longitude: p.longitude,
    );
    _updateState(_state.copyWith(qiblaBearing: bearing));
  }

  void _updateState(QiblaState newState) {
    _state = newState;
    _stateController.add(_state);
  }

  void pause() {
    _compassSub?.pause();
    _locationSub?.pause();
  }

  void resume() {
    _compassSub?.resume();
    _locationSub?.resume();
  }

  void dispose() {
    _compassSub?.cancel();
    _locationSub?.cancel();
    _stateController.close();
  }
}
