import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../l10n/app_localizations.dart';

/// Guided, one-time (and re-openable) setup that makes notifications reliable —
/// the same approach used by the big prayer apps: notifications, exact alarms,
/// battery exemption, vendor auto-start and muted channels, all in one place.
class PermissionSetupScreen extends StatefulWidget {
  const PermissionSetupScreen({super.key});

  /// Opens the screen full-screen and re-schedules notifications when it closes.
  static Future<void> open(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const PermissionSetupScreen(),
    ));
    NotificationCoordinator.instance.rescheduleAll(force: true);
  }

  @override
  State<PermissionSetupScreen> createState() => _PermissionSetupScreenState();
}

enum _Kind { notifications, exact, channels, battery, autostart }

class _PermissionSetupScreenState extends State<PermissionSetupScreen> with WidgetsBindingObserver {
  ReliabilityStatus? _s;
  bool _busy = false;
  Completer<void>? _resumeWaiter;
  AppLifecycleState _life = AppLifecycleState.resumed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _life = state;
    if (state == AppLifecycleState.resumed) {
      _resumeWaiter?.complete();
      _resumeWaiter = null;
      _refresh();
    }
  }

  Future<void> _refresh() async {
    final s = await PermissionCenter.check();
    if (mounted) setState(() => _s = s);
  }

  bool _granted(_Kind k, ReliabilityStatus s) {
    switch (k) {
      case _Kind.notifications:
        return s.notifications;
      case _Kind.exact:
        return s.exactAlarm;
      case _Kind.channels:
        return s.channelsOk;
      case _Kind.battery:
        return s.battery;
      case _Kind.autostart:
        return !s.needsAutostart;
    }
  }

  List<_Kind> _visible(ReliabilityStatus s) => [
        _Kind.notifications,
        _Kind.exact,
        if (!s.channelsOk) _Kind.channels,
        _Kind.battery,
        if (s.brand.isNotEmpty && (s.needsAutostart)) _Kind.autostart,
      ];

  Future<void> _run(_Kind k) async {
    switch (k) {
      case _Kind.notifications:
        await PermissionCenter.requestNotifications();
        break;
      case _Kind.exact:
        await PermissionCenter.requestExactAlarm();
        break;
      case _Kind.channels:
        await PermissionCenter.openNotificationSettings();
        break;
      case _Kind.battery:
        await PermissionCenter.requestBatteryExemption();
        break;
      case _Kind.autostart:
        await PermissionCenter.openAutostart();
        break;
    }
  }

  /// Runs one step. If it sent the user to a Settings page, waits (max 3 min) until
  /// they come back, so "Allow all" never stacks several Settings screens.
  Future<void> _step(_Kind k) async {
    _resumeWaiter = Completer<void>();
    await _run(k);
    await Future.delayed(const Duration(milliseconds: 700));
    if (_life != AppLifecycleState.resumed) {
      await _resumeWaiter?.future.timeout(const Duration(minutes: 3), onTimeout: () {});
    }
    _resumeWaiter = null;
    await _refresh();
  }

  Future<void> _allowAll() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      for (final k in _Kind.values) {
        final s = _s;
        if (s == null || !_visible(s).contains(k) || _granted(k, s)) continue;
        await _step(k);
        if (!mounted) return;
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('perm_setup_done', true);
    if (mounted) Navigator.of(context).pop();
  }

  String _title(AppLocalizations l, _Kind k) {
    switch (k) {
      case _Kind.notifications:
        return l.permNotifTitle;
      case _Kind.exact:
        return l.permExactTitle;
      case _Kind.channels:
        return l.permChannelsTitle;
      case _Kind.battery:
        return l.permBatteryTitle;
      case _Kind.autostart:
        return l.permAutostartTitle;
    }
  }

  String _desc(AppLocalizations l, _Kind k, ReliabilityStatus s) {
    switch (k) {
      case _Kind.notifications:
        return l.permNotifDesc;
      case _Kind.exact:
        return l.permExactDesc;
      case _Kind.channels:
        return l.permChannelsDesc;
      case _Kind.battery:
        return l.permBatteryDesc;
      case _Kind.autostart:
        final b = s.brand.isEmpty ? '' : s.brand[0].toUpperCase() + s.brand.substring(1);
        return l.permAutostartDesc(b);
    }
  }

  IconData _icon(_Kind k) {
    switch (k) {
      case _Kind.notifications:
        return Icons.notifications_active_rounded;
      case _Kind.exact:
        return Icons.alarm_on_rounded;
      case _Kind.channels:
        return Icons.volume_up_rounded;
      case _Kind.battery:
        return Icons.battery_charging_full_rounded;
      case _Kind.autostart:
        return Icons.rocket_launch_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final s = _s;

    return PopScope(
      canPop: false, // always leave through the buttons so setup state is saved
      child: Scaffold(
        body: SafeArea(
          child: s == null
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                      children: [
                        Icon(Icons.mosque_rounded, size: 56, color: cs.primary),
                        const SizedBox(height: 16),
                        Text(l10n.permSetupTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(l10n.permSetupSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: cs.onSurfaceVariant, height: 1.5)),
                        const SizedBox(height: 24),
                        for (final k in _visible(s)) _card(l10n, cs, k, s),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      if (!s.allGood)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(s.critical ? l10n.permMissingNote : l10n.permSetupSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: s.critical ? cs.error : cs.onSurfaceVariant)),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(l10n.permAllSet,
                              style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
                        ),
                      if (!s.allGood)
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _busy ? null : _allowAll,
                            child: _busy
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                : Text(l10n.permAllowAll),
                          ),
                        ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: s.allGood
                            ? FilledButton(onPressed: _finish, child: Text(l10n.permContinue))
                            : TextButton(onPressed: _finish, child: Text(l10n.permLater)),
                      ),
                    ]),
                  ),
                ]),
        ),
      ),
    );
  }

  Widget _card(AppLocalizations l10n, ColorScheme cs, _Kind k, ReliabilityStatus s) {
    final ok = _granted(k, s);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: ok ? cs.primaryContainer.withValues(alpha: 0.35) : cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          CircleAvatar(
            backgroundColor: ok ? cs.primary : cs.secondaryContainer,
            child: Icon(ok ? Icons.check_rounded : _icon(k), color: ok ? cs.onPrimary : cs.onSecondaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_title(l10n, k), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(_desc(l10n, k, s), style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4)),
            ]),
          ),
          const SizedBox(width: 8),
          if (ok)
            Text(l10n.permGranted, style: TextStyle(color: cs.primary, fontSize: 12, fontWeight: FontWeight.bold))
          else
            FilledButton.tonal(
              onPressed: _busy ? null : () => _step(k),
              child: Text(l10n.permAllow),
            ),
        ]),
      ),
    );
  }
}
