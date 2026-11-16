import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/services/location_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/presentation/widgets/city_picker_sheet.dart';
import '../../../prayer/presentation/widgets/location_help_sheet.dart';

/// Asks for location. Handles every case explicitly (nothing is left to chance):
///  * location service OFF        → opens the system switch, continues when the user returns;
///  * permission denied           → system dialog;
///  * permission denied FOREVER   → opens app settings (a dialog is impossible), continues on return;
///  * no fix (indoors/slow GPS)   → says so and offers retry / manual city instead of closing silently;
///  * user doesn't want GPS       → picks the city manually.
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
  String? _error;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';

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
      _waitingForSettings = false;
      _handleAllowPress();
    }
  }

  Future<void> _done() async {
    await CityPickerSheet.applyEverywhere();
    widget.onAllow();
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _handleAllowPress() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final svc = LocationService();
    await svc.clearManualCity();
    var st = await svc.status();

    if (!st.serviceOn) {
      _waitingForSettings = true;
      await Geolocator.openLocationSettings();
      return; // continues in didChangeAppLifecycleState
    }
    if (st.permission == LocationPermission.deniedForever) {
      _waitingForSettings = true;
      await Geolocator.openAppSettings();
      return;
    }
    if (st.permission == LocationPermission.denied) {
      final p = await Geolocator.requestPermission();
      if (p == LocationPermission.denied || p == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _error = _ar
                ? 'لم يتم السماح بالموقع. يمكنك اختيار مدينتك يدويًا.'
                : 'Location was not allowed. You can choose your city manually.';
          });
        }
        return;
      }
    }

    final r = await svc.resolve(requestPermission: false, timeout: const Duration(seconds: 20));
    if (r.isReal) {
      await _done();
      return;
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
        _error = _ar
            ? 'تعذّر تحديد موقعك الآن. اتبع خطوات المساعدة أو اختر مدينتك يدويًا.'
            : 'Could not get your position now. Follow the help steps or choose your city manually.';
      });
      final retry = await LocationHelpSheet.show(context, issue: await svc.lastIssue());
      if (retry && mounted) _handleAllowPress();
    }
  }

  Future<void> _pickCity() async {
    final changed = await CityPickerSheet.show(context);
    if (changed) {
      widget.onAllow();
      if (mounted) Navigator.of(context).pop();
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/access_location.png', width: 110, height: 110, fit: BoxFit.contain),
            const SizedBox(height: 20),
            Text(l10n.startupLocationTitle,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(
              widget.savedLocationName != null
                  ? l10n.startupLocationDescSaved(widget.savedLocationName!)
                  : l10n.startupLocationDescDefault,
              style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant, height: 1.5),
              textAlign: TextAlign.center,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!,
                  style: TextStyle(fontSize: 13, color: colorScheme.error, height: 1.4),
                  textAlign: TextAlign.center),
            ],
            if (_isLoading) ...[
              const SizedBox(height: 24),
              CircularProgressIndicator(color: colorScheme.primary),
              const SizedBox(height: 14),
              Text(l10n.findingLocation,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: colorScheme.primary)),
              const SizedBox(height: 8),
            ] else ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleAllowPress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(_error == null ? l10n.allowLocationBtn : (_ar ? 'إعادة المحاولة' : 'Try again'),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _pickCity,
                  icon: const Icon(Icons.location_city_rounded),
                  label: Text(_ar ? 'اختيار المدينة يدويًا' : 'Choose city manually'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.notNow,
                    style: TextStyle(fontSize: 15, color: colorScheme.onSurfaceVariant)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
