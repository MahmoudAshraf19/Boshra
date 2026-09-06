import 'package:flutter/material.dart';
import '../../domain/prayer_settings.dart';
import '../../domain/prayer_scheduler_service.dart';
import '../../../../l10n/app_localizations.dart';

class PrayerSettingsScreen extends StatefulWidget {
  const PrayerSettingsScreen({super.key});

  @override
  State<PrayerSettingsScreen> createState() => _PrayerSettingsScreenState();
}

class _PrayerSettingsScreenState extends State<PrayerSettingsScreen> {
  PrayerSettings? _settings;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await PrayerSettings.load();
    setState(() {
      _settings = settings;
      _isLoading = false;
    });
  }

  Future<void> _saveAndReschedule() async {
    if (_settings != null) {
      await _settings!.save();
      // Reschedule prayers with new settings
      await PrayerSchedulerService().schedulePrayersForNextDays(3);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _settings == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.prayerSettingsTitle,
          style: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildSectionHeader(l10n.prePrayerAlertTitle, colorScheme.primary),
          _buildBeforePrayerSlider(l10n, colorScheme),
          
          const SizedBox(height: 32),
          
          _buildSectionHeader(l10n.enablePrayerAlertsTitle, colorScheme.primary),
          Material(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            elevation: 2,
            shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  _buildPrayerToggle(l10n.fajr, _settings!.enabledFajr, colorScheme, (v) {
                    setState(() => _settings = _settings!.copyWith(enabledFajr: v));
                    _saveAndReschedule();
                  }),
                  _buildDivider(),
                  _buildPrayerToggle(l10n.dhuhr, _settings!.enabledDhuhr, colorScheme, (v) {
                    setState(() => _settings = _settings!.copyWith(enabledDhuhr: v));
                    _saveAndReschedule();
                  }),
                  _buildDivider(),
                  _buildPrayerToggle(l10n.asr, _settings!.enabledAsr, colorScheme, (v) {
                    setState(() => _settings = _settings!.copyWith(enabledAsr: v));
                    _saveAndReschedule();
                  }),
                  _buildDivider(),
                  _buildPrayerToggle(l10n.maghrib, _settings!.enabledMaghrib, colorScheme, (v) {
                    setState(() => _settings = _settings!.copyWith(enabledMaghrib: v));
                    _saveAndReschedule();
                  }),
                  _buildDivider(),
                  _buildPrayerToggle(l10n.isha, _settings!.enabledIsha, colorScheme, (v) {
                    setState(() => _settings = _settings!.copyWith(enabledIsha: v));
                    _saveAndReschedule();
                  }),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton.icon(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? 'سيظهر الإشعار بعد 10 ثواني.. أغلق التطبيق الآن لتتأكد!'
                        : 'Notification will appear in 10 seconds.. Close the app to test!',
                  ),
                  backgroundColor: colorScheme.primary,
                  duration: const Duration(seconds: 4),
                ),
              );
              await PrayerSchedulerService().scheduleTestNotification(
                Localizations.localeOf(context).languageCode,
              );
            },
            icon: const Icon(Icons.notifications_active),
            label: Text(
              Localizations.localeOf(context).languageCode == 'ar' 
                  ? 'اختبار إشعار الصلاة (الآن)' 
                  : 'Test Prayer Notification (Now)'
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 4.0, left: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBeforePrayerSlider(AppLocalizations l10n, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            l10n.minutesBeforeAdhan(_settings!.beforePrayerMinutes),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: colorScheme.primary,
              inactiveTrackColor: colorScheme.primaryContainer,
              thumbColor: colorScheme.primary,
              overlayColor: colorScheme.primary.withValues(alpha: 0.2),
              trackHeight: 6.0,
            ),
            child: Slider(
              value: _settings!.beforePrayerMinutes.toDouble(),
              min: 0,
              max: 60,
              divisions: 60,
              onChanged: (val) {
                setState(() {
                  _settings = _settings!.copyWith(beforePrayerMinutes: val.toInt());
                });
              },
              onChangeEnd: (val) {
                _saveAndReschedule();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerToggle(String name, bool value, ColorScheme colorScheme, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: colorScheme.surface,
      activeTrackColor: colorScheme.primary,
      inactiveThumbColor: colorScheme.onSurfaceVariant,
      inactiveTrackColor: colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
      indent: 20,
      endIndent: 20,
    );
  }
}
