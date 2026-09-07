import 'package:flutter/material.dart';
import '../controllers/qibla_controller.dart';
import '../widgets/qibla_compass_widget.dart';
import '../widgets/qibla_calibration_widget.dart';
import '../widgets/location_permission_widget.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../l10n/app_localizations.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  late QiblaController _controller;
  String _locationName = '';

  @override
  void initState() {
    super.initState();
    _controller = QiblaController();
    _controller.init();
    
    _controller.stateStream.listen((state) {
      if (state.location != null && _locationName.isEmpty) {
        _fetchLocationName(state.location!.latitude, state.location!.longitude);
      }
    });
  }

  Future<void> _fetchLocationName(double lat, double lon) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        if (mounted) {
          setState(() {
            _locationName = '${place.locality ?? place.subAdministrativeArea ?? place.administrativeArea}, ${place.country}';
          });
        }
      }
    } catch (e) {
      print('Error fetching placemark: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.qiblaDirection,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder<QiblaState>(
        stream: _controller.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data ?? QiblaState();

          if (state.status == QiblaStatus.requestLocation) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.status == QiblaStatus.init) {
            return LocationPermissionWidget(
              key: const ValueKey('location_permission'),
              onRetry: () => _controller.init(),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                // Location Header (only shown if not in calibration)
                if (state.status != QiblaStatus.calibration)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          _locationName.isNotEmpty ? _locationName : l10n.findingLocation,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (state.location != null)
                          Text(
                            '${state.location!.latitude.toStringAsFixed(4)}° N · ${state.location!.longitude.toStringAsFixed(4)}° E',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildBodyForState(state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBodyForState(QiblaState state) {

    switch (state.status) {
      case QiblaStatus.calibration:
        return const QiblaCalibrationWidget(key: ValueKey('calibration'));
      case QiblaStatus.qiblaLocked:
      case QiblaStatus.active:
      case QiblaStatus.locationReady:
        return QiblaCompassWidget(key: const ValueKey('compass'), state: state);
      case QiblaStatus.requestLocation:
      case QiblaStatus.init:
        return const Center(child: CircularProgressIndicator());
      default:
        return const SizedBox();
    }
  }
}
