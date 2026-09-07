import 'package:flutter/material.dart';
import '../../../../core/services/notification_service.dart';
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
    
    // Check if the locale has the new keys, if not fallback safely (just in case)
    // The keys are generated, so we can access them directly.

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        children: [
          _buildSectionHeader((l10n as dynamic).prePrayerAlertTitle ?? 'Pre-Prayer Alerts', colorScheme.primary),
          _buildBeforePrayerSlider(l10n, colorScheme),
          
          const SizedBox(height: 32),
          
          _buildSectionHeader(l10n.enablePrayerAlertsTitle, colorScheme.primary),
          
          _buildPrayerCard(
            l10n.fajr,
            _settings!.enabledFajr,
            _settings!.fajrSound,
            colorScheme,
            l10n,
            (val) {
              setState(() => _settings = _settings!.copyWith(enabledFajr: val));
              _saveAndReschedule();
            },
            (val) {
              setState(() => _settings = _settings!.copyWith(fajrSound: val));
              _saveAndReschedule();
            },
          ),
          
          _buildPrayerCard(
            l10n.dhuhr,
            _settings!.enabledDhuhr,
            _settings!.dhuhrSound,
            colorScheme,
            l10n,
            (val) {
              setState(() => _settings = _settings!.copyWith(enabledDhuhr: val));
              _saveAndReschedule();
            },
            (val) {
              setState(() => _settings = _settings!.copyWith(dhuhrSound: val));
              _saveAndReschedule();
            },
          ),
          
          _buildPrayerCard(
            l10n.asr,
            _settings!.enabledAsr,
            _settings!.asrSound,
            colorScheme,
            l10n,
            (val) {
              setState(() => _settings = _settings!.copyWith(enabledAsr: val));
              _saveAndReschedule();
            },
            (val) {
              setState(() => _settings = _settings!.copyWith(asrSound: val));
              _saveAndReschedule();
            },
          ),
          
          _buildPrayerCard(
            l10n.maghrib,
            _settings!.enabledMaghrib,
            _settings!.maghribSound,
            colorScheme,
            l10n,
            (val) {
              setState(() => _settings = _settings!.copyWith(enabledMaghrib: val));
              _saveAndReschedule();
            },
            (val) {
              setState(() => _settings = _settings!.copyWith(maghribSound: val));
              _saveAndReschedule();
            },
          ),
          
          _buildPrayerCard(
            l10n.isha,
            _settings!.enabledIsha,
            _settings!.ishaSound,
            colorScheme,
            l10n,
            (val) {
              setState(() => _settings = _settings!.copyWith(enabledIsha: val));
              _saveAndReschedule();
            },
            (val) {
              setState(() => _settings = _settings!.copyWith(ishaSound: val));
              _saveAndReschedule();
            },
          ),
          
          const SizedBox(height: 32),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Ensure permissions are requested before testing
              await NotificationService().requestPermissions();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((l10n as dynamic).testNotificationNow ?? 'Test Notification Now'),
                    backgroundColor: colorScheme.primary,
                  ),
                );
              }
              await PrayerSchedulerService().scheduleTestNotification(
                Localizations.localeOf(context).languageCode,
              );
            },
            icon: const Icon(Icons.notifications_active),
            label: Text((l10n as dynamic).testNotificationNow ?? 'Test Notification Now'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: colorScheme.secondaryContainer,
              foregroundColor: colorScheme.onSecondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 40),
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
          fontSize: 18,
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
        borderRadius: BorderRadius.circular(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (l10n as dynamic).prePrayerAlertDesc ?? 'Alert me before Adhan by',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.minutesBeforeAdhan(_settings!.beforePrayerMinutes),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: colorScheme.primary,
              inactiveTrackColor: colorScheme.surfaceContainerHighest,
              thumbColor: colorScheme.primary,
              overlayColor: colorScheme.primary.withValues(alpha: 0.2),
              trackHeight: 6.0,
            ),
            child: Slider(
              value: _settings!.beforePrayerMinutes.toDouble(),
              min: 0,
              max: 60,
              divisions: 12, // 5 min increments
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

  Widget _buildPrayerCard(
    String prayerName,
    bool isEnabled,
    String soundType,
    ColorScheme colorScheme,
    AppLocalizations l10n,
    ValueChanged<bool> onToggle,
    ValueChanged<String> onSoundChanged,
  ) {
    final dynamic l10nDynamic = l10n;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isEnabled ? colorScheme.surface : colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isEnabled ? colorScheme.primary.withValues(alpha: 0.3) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          if (isEnabled)
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Toggle and Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                  ),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: onToggle,
                  activeColor: colorScheme.surface,
                  activeTrackColor: colorScheme.primary,
                  inactiveThumbColor: colorScheme.onSurfaceVariant,
                  inactiveTrackColor: colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
          ),
          
          // Bottom Row: Sound Selection (Only if enabled)
          if (isEnabled)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10nDynamic.soundType ?? 'Notification Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  _buildSoundDropdown(soundType, onSoundChanged, colorScheme, l10n),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSoundDropdown(
    String currentValue, 
    ValueChanged<String> onChanged, 
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    final dynamic l10nDynamic = l10n;
    
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary, size: 20),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: [
            DropdownMenuItem(
              value: 'silent',
              child: Text(l10nDynamic.soundSilent ?? 'Silent'),
            ),
            DropdownMenuItem(
              value: 'short',
              child: Text(l10nDynamic.soundShort ?? 'Short Beep'),
            ),
            DropdownMenuItem(
              value: 'adhan',
              child: Text(l10nDynamic.soundAdhan ?? 'Full Adhan'),
            ),
          ],
        ),
      ),
    );
  }
}
