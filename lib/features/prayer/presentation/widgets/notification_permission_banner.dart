import 'package:flutter/material.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../permissions/presentation/screens/permission_setup_screen.dart';

/// Warning card shown while something makes notifications unreliable.
/// One tap opens the guided setup. Re-checks when the user comes back from Settings.
class NotificationPermissionBanner extends StatefulWidget {
  const NotificationPermissionBanner({super.key});

  @override
  State<NotificationPermissionBanner> createState() => _State();
}

class _State extends State<NotificationPermissionBanner> with WidgetsBindingObserver {
  ReliabilityStatus? _s;

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
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    final s = await PermissionCenter.check();
    if (mounted) setState(() => _s = s);
  }

  @override
  Widget build(BuildContext context) {
    final s = _s;
    // Show for critical problems, or when the battery isn't exempt.
    if (s == null || (!s.critical && s.battery)) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.errorContainer,
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Icon(Icons.notifications_off_outlined, color: cs.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(l10n.permMissingNote,
                style: TextStyle(color: cs.onErrorContainer, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () async {
              await PermissionSetupScreen.open(context);
              _refresh();
            },
            child: Text(l10n.permFix),
          ),
        ]),
      ),
    );
  }
}
