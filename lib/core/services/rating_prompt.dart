import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../permissions/permission_center.dart';
import 'adhan_native_service.dart';
import 'telemetry.dart';

/// Asks for a Play Store rating at a GOOD moment — never on the first day, never while the
/// Adhan is playing, never if the app has had problems, and never nags:
///
///   ask when  ( ≥ 7 days since install AND ≥ 3 distinct days opened )
///        OR   ( an Adhan played and stopped correctly in the last 24 h AND ≥ 2 days since install
///               AND ≥ 2 days opened )
///   but only  if no Adhan problem (player_error / fgs_failed / last scheduling error) recently,
///             permissions are healthy, ≥ 60 days since the last ask (14 if "later"), max 3 asks,
///             and the user did not answer "rated" or "never".
class RatingPrompt {
  RatingPrompt._();

  static const _packageId = 'com.app.boshra';
  static bool _askedThisSession = false;

  static String _day(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// Call once per app start (any screen).
  static Future<void> recordOpen() async {
    final p = await SharedPreferences.getInstance();
    p.getInt('first_open_ms') ?? await p.setInt('first_open_ms', DateTime.now().millisecondsSinceEpoch);
    final days = p.getStringList('open_days') ?? <String>[];
    final today = _day(DateTime.now());
    if (!days.contains(today)) {
      days.add(today);
      await p.setStringList('open_days', days.length > 90 ? days.sublist(days.length - 90) : days);
    }
  }

  static Future<bool> _adhanWorkedRecently(SharedPreferences p) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    DateTime? playing, stopped;
    for (final l in (p.getString('native_events') ?? '').split('\n')) {
      final parts = l.split('|');
      if (parts.length < 2) continue;
      final ms = int.tryParse(parts[0]);
      if (ms == null) continue;
      final age = now - ms;
      if (parts[1] == 'player_error' || parts[1] == 'fgs_failed') {
        if (age < const Duration(days: 7).inMilliseconds) return false; // had a problem → don't ask
      }
      if (parts[1] == 'adhan_playing') playing = DateTime.fromMillisecondsSinceEpoch(ms);
      if (parts[1] == 'adhan_stopped') stopped = DateTime.fromMillisecondsSinceEpoch(ms);
    }
    if (playing == null || stopped == null) return false;
    if (stopped.isBefore(playing)) return false;
    return DateTime.now().difference(stopped) < const Duration(hours: 24);
  }

  static Future<bool> shouldAsk() async {
    final p = await SharedPreferences.getInstance();
    try {
      await p.reload();
    } catch (_) {}
    final state = p.getString('rating_state'); // null | rated | never
    if (state == 'rated' || state == 'never') return false;
    if ((p.getInt('rating_asks') ?? 0) >= 3) return false;

    final first = p.getInt('first_open_ms');
    if (first == null) return false;
    final since = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(first));
    final openDays = (p.getStringList('open_days') ?? const []).length;

    final last = p.getInt('rating_last_ms');
    if (last != null) {
      final cool = Duration(days: p.getString('rating_last_answer') == 'later' ? 14 : 60);
      if (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(last)) < cool) return false;
    }

    final byUsage = since >= const Duration(days: 7) && openDays >= 3;
    final byAdhan = since >= const Duration(days: 2) && openDays >= 2 && await _adhanWorkedRecently(p);
    if (!byUsage && !byAdhan) return false;

    // happy users only: no errors, healthy permissions
    if (p.getBool('diag_last_error') ?? false) return false;
    if (!byAdhan && !await _adhanWorkedRecently(p)) {
      // usage trigger: still make sure no recent adhan problem exists
      for (final l in (p.getString('native_events') ?? '').split('\n')) {
        final parts = l.split('|');
        if (parts.length > 1 && (parts[1] == 'player_error' || parts[1] == 'fgs_failed')) {
          final ms = int.tryParse(parts[0]) ?? 0;
          if (DateTime.now().millisecondsSinceEpoch - ms < const Duration(days: 7).inMilliseconds) return false;
        }
      }
    }
    try {
      final st = await PermissionCenter.check();
      if (st.critical) return false;
    } catch (_) {}
    if (await AdhanNativeService.instance.isAdhanPlaying()) return false;
    return true;
  }

  /// Safe to call often (resume, after startup). Shows at most once per app session.
  static Future<void> maybeAsk(BuildContext context) async {
    if (_askedThisSession) return;
    if (!await shouldAsk()) return;
    if (!context.mounted) return;
    if (ModalRoute.of(context)?.isCurrent != true) return; // never over another screen / dialog
    _askedThisSession = true;
    final p = await SharedPreferences.getInstance();
    await p.setInt('rating_asks', (p.getInt('rating_asks') ?? 0) + 1);
    await p.setInt('rating_last_ms', DateTime.now().millisecondsSinceEpoch);
    Telemetry.log('rating_shown');
    if (!context.mounted) return;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final answer = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => _RatingSheet(ar: ar),
    );
    await p.setString('rating_last_answer', answer ?? 'later');
    switch (answer) {
      case 'happy':
        await p.setString('rating_state', 'rated');
        Telemetry.log('rating_happy');
        await _openStore();
        break;
      case 'unhappy':
        Telemetry.log('rating_unhappy');
        await launchUrl(
          Uri.parse('https://wa.me/201150125129?text=${Uri.encodeComponent(ar ? 'عندي اقتراح لتحسين تطبيق بُشرى: ' : 'I have a suggestion for Boshra: ')}'),
          mode: LaunchMode.externalApplication,
        ).catchError((_) => false);
        break;
      case 'never':
        await p.setString('rating_state', 'never');
        Telemetry.log('rating_never');
        break;
      default:
        Telemetry.log('rating_later');
    }
  }

  static Future<void> _openStore() async {
    final market = Uri.parse('market://details?id=$_packageId');
    final web = Uri.parse('https://play.google.com/store/apps/details?id=$_packageId');
    try {
      if (await launchUrl(market, mode: LaunchMode.externalApplication)) return;
    } catch (_) {}
    try {
      await launchUrl(web, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}

class _RatingSheet extends StatelessWidget {
  final bool ar;
  const _RatingSheet({required this.ar});

  @override
  Widget build(BuildContext context) {
    String t(String a, String e) => ar ? a : e;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('🌙', style: TextStyle(fontSize: 40)),
        const SizedBox(height: 8),
        Text(t('هل «بُشرى» بتفيدك؟', 'Is Boshra helping you?'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(
          t('رأيك بيساعدنا نكمّل ونحسّن التطبيق، وتقييمك صدقة جارية بإذن الله.',
              'Your feedback helps us keep improving — and your rating helps others find it.'),
          textAlign: TextAlign.center,
          style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton(
            onPressed: () => Navigator.pop(context, 'happy'),
            child: Text(t('😍 نعم، تطبيق رائع — قيّمه', '😍 Yes, love it — rate it'), style: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context, 'unhappy'),
            child: Text(t('🙂 محتاج تحسينات — أرسل اقتراحي', '🙂 Could be better — send feedback')),
          ),
        ),
        const SizedBox(height: 4),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(onPressed: () => Navigator.pop(context, 'later'), child: Text(t('لاحقًا', 'Later'))),
          TextButton(onPressed: () => Navigator.pop(context, 'never'), child: Text(t('لا تسألني ثانية', "Don't ask again"))),
        ]),
      ]),
    );
  }
}
