import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Brand colours of the banner (olive green + gold, same family as the app theme).
class _C {
  static const dark = Color(0xFF283618);
  static const mid = Color(0xFF3F4F24);
  static const light = Color(0xFF606C38);
  static const gold = Color(0xFFDDA15E);
  static const goldSoft = Color(0xFFF0C987);
  static const cream = Color(0xFFFBEFD5);
}

/// The Islamic-styled Adhan banner (pure UI – no logic).
/// Used (1) as the in-app banner while the app is open and (2) as the live
/// preview in the prayer-settings screen.
class AdhanBannerView extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? verse;
  final String stopLabel;
  final VoidCallback? onStop;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry margin;

  const AdhanBannerView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stopLabel,
    this.verse,
    this.onStop,
    this.onClose,
    this.margin = EdgeInsets.zero,
  });

  /// Custom calligraphy font (assets/fonts/ArefRuqaa-*.ttf) for Arabic only.
  /// Persian / Urdu / other scripts keep the app font (full glyph coverage).
  static const arabicFont = 'ArefRuqaa';

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final titleStyle = TextStyle(
      fontFamily: isArabic ? arabicFont : null,
      fontWeight: FontWeight.w700,
      fontSize: isArabic ? 22 : 17,
      height: 1.25,
      color: _C.cream,
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [_C.dark, _C.mid, _C.light],
        ),
        border: Border.all(color: _C.gold.withValues(alpha: 0.65), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: CustomPaint(
          painter: _PatternPainter(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 48, height: 48, child: _Emblem()),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(title, style: titleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: _C.goldSoft.withValues(alpha: 0.95),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (onClose != null)
                      IconButton(
                        onPressed: onClose,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.7), size: 20),
                      ),
                  ],
                ),
                if (verse != null && verse!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(child: Container(height: 1, color: _C.gold.withValues(alpha: 0.35))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.star_rate_rounded, size: 12, color: _C.gold.withValues(alpha: 0.9)),
                    ),
                    Expanded(child: Container(height: 1, color: _C.gold.withValues(alpha: 0.35))),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    verse!,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: isArabic ? 'AmiriQuran' : null,
                      fontSize: isArabic ? 15 : 12,
                      height: 1.6,
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: onStop,
                  icon: const Icon(Icons.stop_circle_rounded, size: 22),
                  label: Text(stopLabel),
                  style: FilledButton.styleFrom(
                    backgroundColor: _C.gold,
                    foregroundColor: _C.dark,
                    disabledBackgroundColor: _C.gold,
                    disabledForegroundColor: _C.dark,
                    minimumSize: const Size.fromHeight(46),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Gold medallion with crescent + star.
class _Emblem extends StatelessWidget {
  const _Emblem();
  @override
  Widget build(BuildContext context) => CustomPaint(painter: _EmblemPainter());
}

class _EmblemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final c = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(c, s / 2, Paint()..color = Colors.black.withValues(alpha: 0.22));
    canvas.drawCircle(
        c,
        s / 2 - 1,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..color = _C.gold);

    final outer = Path()..addOval(Rect.fromCircle(center: Offset(s * 0.45, s * 0.53), radius: s * 0.27));
    final cutMoved = Path()..addOval(Rect.fromCircle(center: Offset(s * 0.60, s * 0.45), radius: s * 0.22));
    final crescent = Path.combine(PathOperation.difference, outer, cutMoved);
    canvas.drawPath(crescent, Paint()..color = _C.goldSoft);

    final star = Path();
    final sc = Offset(s * 0.70, s * 0.33);
    const points = 5;
    final big = s * 0.095, small = s * 0.04;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? big : small;
      final a = -math.pi / 2 + i * math.pi / points;
      final p = Offset(sc.dx + r * math.cos(a), sc.dy + r * math.sin(a));
      i == 0 ? star.moveTo(p.dx, p.dy) : star.lineTo(p.dx, p.dy);
    }
    star.close();
    canvas.drawPath(star, Paint()..color = _C.goldSoft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Very light 8-point-star lattice (classic Islamic geometric pattern).
class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = _C.gold.withValues(alpha: 0.11);
    const tile = 46.0;
    const r = 15.0;
    for (double y = 0; y < size.height + tile; y += tile) {
      for (double x = 0; x < size.width + tile; x += tile) {
        _star(canvas, Offset(x, y), r, paint);
        _star(canvas, Offset(x + tile / 2, y + tile / 2), r * 0.55, paint);
      }
    }
  }

  void _star(Canvas canvas, Offset c, double r, Paint p) {
    for (final rot in [0.0, math.pi / 4]) {
      final path = Path();
      for (int k = 0; k < 4; k++) {
        final a = rot + k * math.pi / 2;
        final pt = Offset(c.dx + r * math.cos(a), c.dy + r * math.sin(a));
        k == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
      }
      path.close();
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
