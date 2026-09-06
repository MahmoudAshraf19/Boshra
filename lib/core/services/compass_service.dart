import 'package:flutter_compass/flutter_compass.dart';
import '../../features/qibla/data/models/compass_data_model.dart';

class CompassService {
  /// Stream that emits device compass heading updates.
  Stream<CompassDataModel> get compassStream {
    return FlutterCompass.events!.map((CompassEvent event) {
      return CompassDataModel(
        heading: event.heading ?? 0.0,
        accuracy: event.accuracy ?? 0.0,
      );
    });
  }
}
