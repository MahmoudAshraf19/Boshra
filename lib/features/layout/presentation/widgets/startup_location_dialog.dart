import 'package:flutter/material.dart';
import '../../../../core/services/location_service.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:boshra/features/home/presentation/controllers/home_controller.dart';

class StartupLocationDialog extends StatefulWidget {
  final VoidCallback onAllow;
  final String? savedLocationName;

  const StartupLocationDialog({
    super.key,
    required this.onAllow,
    this.savedLocationName,
  });

  @override
  State<StartupLocationDialog> createState() => _StartupLocationDialogState();
}

class _StartupLocationDialogState extends State<StartupLocationDialog> with WidgetsBindingObserver {
  bool _isLoading = false;
  bool _waitingForSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForSettings) {
      _checkStatusAfterSettings();
    }
  }

  Future<void> _checkStatusAfterSettings() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        await _fetchAndComplete();
        return;
      }
    }
    // If the user came back without turning on location
    if (mounted) {
      setState(() {
        _isLoading = false;
        _waitingForSettings = false;
      });
    }
  }

  Future<void> _fetchAndComplete() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final pos = await LocationService().getCurrentLocation();
      if (pos != null) {
        await HomeController.instance?.refreshData();
        widget.onAllow();
      }
    } catch (e) {
      debugPrint('Location fetch error: $e');
    } finally {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _handleAllowPress() async {
    setState(() => _isLoading = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _waitingForSettings = true;
      await Geolocator.openLocationSettings();
      // Keep loading on screen while user toggles setting and comes back
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      await _fetchAndComplete();
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _waitingForSettings = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: colorScheme.surface,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/access_location.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.startupLocationTitle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.savedLocationName != null
                  ? l10n.startupLocationDescSaved(widget.savedLocationName!)
                  : l10n.startupLocationDescDefault,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (_isLoading) ...[
              const SizedBox(height: 28),
              CircularProgressIndicator(color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                l10n.findingLocation,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
            ] else ...[
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleAllowPress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.allowLocationBtn,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.notNow,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
