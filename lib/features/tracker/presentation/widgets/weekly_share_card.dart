import 'package:flutter/material.dart';
import '../../data/weekly_stats.dart';
import 'prayer_tree.dart';

/// The shareable "tree of the week" card, designed for a 1080 × 1350 canvas.
/// Used both for the on-screen preview (scaled down) and for the PNG that is shared.
class WeeklyShareCard extends StatelessWidget {
  static const width = 1080.0;
  static const height = 1350.0;

  final WeeklyStats stats;
  final List<String> names;
  final bool ar;
  final bool animate;
  const WeeklyShareCard({super.key, required this.stats, required this.names, required this.ar, this.animate = true});

  static const _bg1 = Color(0xFF1F3A1B);
  static const _bg2 = Color(0xFF3F6B2C);
  static const _gold = Color(0xFFE9C46A);

  @override
  Widget build(BuildContext context) {
    String t(String a, String e) => ar ? a : e;
    final days = ar ? ['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'] : ['S', 'S', 'M', 'T', 'W', 'T', 'F'];
    final today = DateTime.now();
    final b = stats.best, w = stats.weakest;

    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [_bg1, _bg2]),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(70, 80, 70, 60),
            child: Column(children: [
              Text(t('ملخّصي الأسبوعي', 'My weekly summary'),
                  style: const TextStyle(color: _gold, fontSize: 54, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
              const SizedBox(height: 6),
              Text(t('شجرة صلواتي هذا الأسبوع 🌳', 'My prayer tree this week 🌳'),
                  style: const TextStyle(color: Colors.white70, fontSize: 32, decoration: TextDecoration.none)),
              const SizedBox(height: 10),
              PrayerTree(level: stats.treeLevel, size: 430, doneToday: stats.total > 0, animate: animate),
              Text('${stats.total} / ${WeeklyStats.max}',
                  style: const TextStyle(color: Colors.white, fontSize: 120, fontWeight: FontWeight.bold, height: 1.05, decoration: TextDecoration.none)),
              Text(t('${stats.percent}% من صلواتي في وقتها بإذن الله', '${stats.percent}% of my prayers logged'),
                  style: const TextStyle(color: Colors.white70, fontSize: 32, decoration: TextDecoration.none)),
              const SizedBox(height: 34),
              // 7 days
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var k = 0; k < 7; k++)
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: 58,
                        height: 18 + stats.perDay[k] * 26.0,
                        decoration: BoxDecoration(
                          color: stats.perDay[k] == 5 ? _gold : Colors.white.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(days[(today.subtract(Duration(days: 6 - k)).weekday + 1) % 7],
                          style: const TextStyle(color: Colors.white70, fontSize: 28, decoration: TextDecoration.none)),
                    ]),
                ],
              ),
              const Spacer(),
              if (b != null)
                Text(
                  t('أفضل صلاة: ${names[b]}', 'Strongest: ${names[b]}') + (w != null ? t('   •   أضعفها: ${names[w]}', '   •   Weakest: ${names[w]}') : ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
                ),
              const SizedBox(height: 10),
              if (stats.streak > 0)
                Text(t('🔥 ${stats.streak} أيام متتالية بكل الصلوات', '🔥 ${stats.streak}-day streak, all five prayers'),
                    style: const TextStyle(color: _gold, fontSize: 32, decoration: TextDecoration.none)),
              const SizedBox(height: 24),
              Text(t('تطبيق بُشرى — الأذان والأذكار والقرآن', 'Boshra — Adhan, Azkar & Quran'),
                  style: const TextStyle(color: Colors.white54, fontSize: 28, decoration: TextDecoration.none)),
            ]),
          ),
        ),
      ),
    );
  }
}
