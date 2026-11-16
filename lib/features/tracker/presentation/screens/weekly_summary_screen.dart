import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/services/telemetry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../sadaqa/presentation/screens/sadaqa_jariya_screen.dart';
import '../../data/prayer_tracker.dart';
import '../../data/weekly_stats.dart';
import '../widgets/weekly_share_card.dart';

/// Weekly summary: "You prayed 31 of 35 — strongest Dhuhr, weakest Fajr" + the tree of the week,
/// shareable as an image. Opened from the Friday notification or from "More".
class WeeklySummaryScreen extends StatefulWidget {
  const WeeklySummaryScreen({super.key});

  @override
  State<WeeklySummaryScreen> createState() => _WeeklySummaryScreenState();
}

class _WeeklySummaryScreenState extends State<WeeklySummaryScreen> {
  WeeklyStats? _stats;
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final m = await PrayerTracker.load();
    if (mounted) setState(() => _stats = WeeklyStats.from(m));
  }

  List<String> _names(AppLocalizations l) => [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];

  Future<void> _share() async {
    final stats = _stats;
    if (stats == null || _sharing) return;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final names = _names(AppLocalizations.of(context)!);
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    setState(() => _sharing = true);
    try {
      final Uint8List bytes = await ScreenshotController().captureFromWidget(
        Material(
          type: MaterialType.transparency,
          child: MediaQuery(
            data: const MediaQueryData(size: Size(WeeklyShareCard.width, WeeklyShareCard.height), devicePixelRatio: 1.0),
            child: WeeklyShareCard(stats: stats, names: names, ar: ar, animate: false),
          ),
        ),
        context: context,
        pixelRatio: 1.0,
        delay: const Duration(milliseconds: 400),
        targetSize: const Size(WeeklyShareCard.width, WeeklyShareCard.height),
      ).timeout(const Duration(seconds: 15));

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/boshra_week_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes, flush: true);
      final code = await SadaqaJariyaScreen.inviteCode();
      Telemetry.log('weekly_share');
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png')],
        text: '${stats.sentence(names, ar)}\n\n${SadaqaJariyaScreen.link(code)}',
        sharePositionOrigin: origin,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ar ? 'تعذّر إنشاء الصورة، حاول مرة أخرى' : 'Could not create the image, try again')));
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final names = _names(l);
    final stats = _stats;

    return Scaffold(
      appBar: AppBar(
        title: Text(ar ? 'ملخّصك الأسبوعي' : 'Weekly summary'),
        actions: [
          IconButton(
            onPressed: stats == null || _sharing ? null : _share,
            icon: _sharing
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.share_rounded),
            tooltip: ar ? 'مشاركة كصورة' : 'Share as image',
          ),
        ],
      ),
      body: stats == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  stats.total == 0
                      ? (ar ? 'لسه ما سجّلتش صلوات هذا الأسبوع. ابدأ من «حديقة صلواتك» في الرئيسية 🌱' : 'No prayers logged this week yet. Start from your garden on Home 🌱')
                      : stats.sentence(names, ar),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: AspectRatio(
                    aspectRatio: WeeklyShareCard.width / WeeklyShareCard.height,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: WeeklyShareCard(stats: stats, names: names, ar: ar),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: _sharing ? null : _share,
                  icon: const Icon(Icons.ios_share_rounded),
                  label: Text(ar ? 'شارك شجرة أسبوعك' : 'Share your weekly tree'),
                ),
                const SizedBox(height: 10),
                Text(
                  ar
                      ? 'كل جمعة بعد العشاء بيجيلك إشعار بملخّص أسبوعك. تقدر تشاركه صدقة جارية لتشجيع غيرك.'
                      : 'Every Friday evening you get a notification with your weekly summary.',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12.5, height: 1.4),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }
}
