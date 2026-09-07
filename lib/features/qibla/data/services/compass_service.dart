import 'dart:async';
import 'package:flutter_compass/flutter_compass.dart';

class CompassService {
  StreamSubscription<CompassEvent>? _subscription;
  final _headingController = StreamController<double>.broadcast();
  final _accuracyController = StreamController<double?>.broadcast();

  Stream<double> get headingStream => _headingController.stream;
  Stream<double?> get accuracyStream => _accuracyController.stream;

  void start() {
    print('🕋 [CompassService] Starting flutter_compass listener...');
    _subscription = FlutterCompass.events?.listen((event) {
      // Removed print event for cleaner logs
      if (event.heading != null) {
        final heading = event.heading!;
        _headingController.add(heading);
      }
      _accuracyController.add(event.accuracy);
    }, onError: (e) {
      print('🕋 [CompassService] ERROR: $e');
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() {
    stop();
    _headingController.close();
    _accuracyController.close();
  }
}
