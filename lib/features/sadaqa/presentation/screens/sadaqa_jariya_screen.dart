import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/telemetry.dart';

/// "صدقة جارية": share the app with a personal invite code. The reward is spiritual
/// («من دلّ على خير فله مثل أجر فاعله»), so people share it for its own sake.
///
/// NOTE: the code is generated and stored on the device; counting how many people used
/// it needs a backend (see report). The Play link carries it in `referrer`, so Play Console
/// / the Install Referrer API can attribute installs later without changing this screen.
class SadaqaJariyaScreen extends StatefulWidget {
  const SadaqaJariyaScreen({super.key});

  static const packageId = 'com.app.boshra';

  /// Shared with the "Share app" tile so every share carries the code.
  static Future<String> inviteCode() async {
    final prefs = await SharedPreferences.getInstance();
    var c = prefs.getString('invite_code');
    if (c == null) {
      const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no 0/O/1/I confusion
      final r = Random.secure();
      c = 'BSH-${List.generate(5, (_) => alphabet[r.nextInt(alphabet.length)]).join()}';
      await prefs.setString('invite_code', c);
    }
    return c;
  }

  static String link(String code) =>
      'https://play.google.com/store/apps/details?id=$packageId&referrer=${Uri.encodeComponent('utm_source=invite&utm_content=$code')}';

  static String message(String code, bool ar) => ar
      ? 'حمّلت تطبيق «بُشرى» للأذان والقرآن والأذكار وأنصحك به 🌙\n'
          'انشره صدقة جارية — «مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»\n\n'
          '${link(code)}\n'
          'كود الدعوة: $code'
      : 'I use "Boshra" for Adhan, Quran and Azkar — I recommend it 🌙\n'
          'Share it as an ongoing charity.\n\n'
          '${link(code)}\n'
          'Invite code: $code';

  @override
  State<SadaqaJariyaScreen> createState() => _SadaqaJariyaScreenState();
}

class _SadaqaJariyaScreenState extends State<SadaqaJariyaScreen> {
  String _code = '';
  int _shares = 0;
  String? _invitedBy;
  final _friend = TextEditingController();
  String? _err;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _friend.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final c = await SadaqaJariyaScreen.inviteCode();
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _code = c;
      _shares = p.getInt('invite_shares') ?? 0;
      _invitedBy = p.getString('invited_by');
    });
  }

  Future<void> _countShare(String via) async {
    final p = await SharedPreferences.getInstance();
    final n = (p.getInt('invite_shares') ?? 0) + 1;
    await p.setInt('invite_shares', n);
    Telemetry.log('invite_share', {'via': via});
    if (mounted) setState(() => _shares = n);
  }

  Future<void> _share() async {
    await Share.share(SadaqaJariyaScreen.message(_code, _ar));
    await _countShare('sheet');
  }

  Future<void> _whatsapp() async {
    final uri = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(SadaqaJariyaScreen.message(_code, _ar))}');
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (ok) {
      await _countShare('whatsapp');
    } else {
      await _share();
    }
  }

  Future<void> _saveFriend() async {
    final v = _friend.text.trim().toUpperCase();
    if (!RegExp(r'^BSH-[A-Z0-9]{5}$').hasMatch(v)) {
      setState(() => _err = t('الكود غير صحيح (مثال: BSH-AB3K9)', 'Invalid code (e.g. BSH-AB3K9)'));
      return;
    }
    if (v == _code) {
      setState(() => _err = t('ده كودك أنت 🙂', 'That is your own code'));
      return;
    }
    final p = await SharedPreferences.getInstance();
    await p.setString('invited_by', v);
    Telemetry.log('invite_code_entered', {'code': v});
    if (mounted) {
      setState(() {
        _invitedBy = v;
        _err = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(t('صدقة جارية', 'Ongoing charity'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(colors: [cs.primary, cs.primary.withValues(alpha: 0.75)]),
            ),
            child: Column(children: [
              const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 44),
              const SizedBox(height: 12),
              const Text('«مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold, height: 1.6)),
              const SizedBox(height: 6),
              Text(t('رواه مسلم', 'Narrated by Muslim'), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 20),
          Text(t('كود الدعوة الخاص بك', 'Your invite code'), style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
            ),
            child: Row(children: [
              Expanded(
                child: Text(_code.isEmpty ? '…' : _code,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 24, letterSpacing: 3, fontWeight: FontWeight.bold, color: cs.primary)),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: _code));
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('تم نسخ الكود', 'Code copied'))));
                },
              ),
            ]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: _code.isEmpty ? null : _share,
              icon: const Icon(Icons.share_rounded),
              label: Text(t('شارك التطبيق', 'Share the app'), style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _code.isEmpty ? null : _whatsapp,
              icon: const Icon(Icons.chat_rounded),
              label: Text(t('مشاركة عبر واتساب', 'Share via WhatsApp')),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _shares == 0
                  ? t('ابدأ أول مشاركة لك 🌱', 'Make your first share 🌱')
                  : t('شاركت التطبيق $_shares مرة — تقبّل الله منك', 'You shared $_shares time(s) — may Allah accept it'),
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ),
          const Divider(height: 36),
          Text(t('عندك كود دعوة من صديق؟', 'Have a friend\'s invite code?'), style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_invitedBy != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.check_circle_rounded, color: Colors.green),
                const SizedBox(width: 10),
                Expanded(child: Text(t('تم تسجيل دعوة $_invitedBy — جزاه الله خيرًا', 'Recorded invite $_invitedBy — may Allah reward them'))),
              ]),
            )
          else ...[
            TextField(
              controller: _friend,
              textCapitalization: TextCapitalization.characters,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                hintText: 'BSH-XXXXX',
                errorText: _err,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                suffixIcon: IconButton(icon: const Icon(Icons.check_rounded), onPressed: _saveFriend),
              ),
              onSubmitted: (_) => _saveFriend(),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
