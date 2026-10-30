import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/permissions/permission_center.dart';
import 'screens/permission_setup_screen.dart';

/// Decides when to show the setup screen:
///  * first launch → always (unless everything is already granted);
///  * later launches → whenever something CRITICAL is off (notifications blocked,
///    exact alarms off, a channel muted), once per app launch, skippable.
/// Battery / vendor auto-start alone only show the Home banner (not forced).
class PermissionGate {
  PermissionGate._();
  static bool _shownThisLaunch = false;

  static Future<void> maybeShow(BuildContext context) async {
    if (_shownThisLaunch) return;
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('perm_setup_done') ?? false;
    final s = await PermissionCenter.check();
    if (s.allGood) {
      await prefs.setBool('perm_setup_done', true);
      return;
    }
    if (done && !s.critical) return;
    if (!context.mounted) return;
    _shownThisLaunch = true;
    await PermissionSetupScreen.open(context);
  }
}
