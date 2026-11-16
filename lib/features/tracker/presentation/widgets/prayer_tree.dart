import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A small tree that GROWS with the prayer streak (level 0 = seed … 5 = fruiting tree).
/// Growth animates smoothly when the level changes. [doneToday] adds a warm glow,
/// [thirsty] shows a water drop (prayer time started and not marked yet).
class PrayerTree extends StatelessWidget {
  final double level;
  final double size;
  final bool doneToday;
  final bool thirsty;
  /// false → drawn fully grown at once (used when capturing an image).
  final bool animate;
  const PrayerTree({
    super.key,
    required this.level,
    this.size = 64,
    this.doneToday = false,
    this.thirsty = false,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: animate ? 0 : level.clamp(0, 5).toDouble(), end: level.clamp(0, 5).toDouble()),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (_, g, __) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _TreePainter(g, doneToday, thirsty)),
      ),
    );
  }

  static String stageName(double level, bool ar) {
    if (level <= 0) return ar ? 'بذرة' : 'Seed';
    if (level < 2) return ar ? 'برعم' : 'Sprout';
    if (level < 3) return ar ? 'شتلة' : 'Sapling';
    if (level < 4) return ar ? 'شجرة صغيرة' : 'Young tree';
    if (level < 5) return ar ? 'شجرة' : 'Tree';
    return ar ? 'شجرة مثمرة' : 'Fruit tree';
  }
}

class _TreePainter extends CustomPainter {
  final double g; // 0..5 (animated, may overshoot slightly)
  final bool glow;
  final bool thirsty;
  _TreePainter(this.g, this.glow, this.thirsty);

  static const _trunk = Color(0xFF7A5230);
  static const _leaf1 = Color(0xFF4C9A2A);
  static const _leaf2 = Color(0xFF6BBF3B);
  static const _leaf3 = Color(0xFF3B7D1F);

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final gg = g.clamp(0.0, 5.2);
    final t = (gg / 5).clamp(0.0, 1.0);
    final groundY = h * 0.90;

    // warm glow when today's prayer is done
    if (glow) {
      final c = Offset(w / 2, groundY - h * (0.25 + 0.2 * t));
      canvas.drawCircle(
        c,
        w * 0.5,
        Paint()..shader = RadialGradient(colors: [const Color(0x55FFD54F), const Color(0x00FFD54F)]).createShader(Rect.fromCircle(center: c, radius: w * 0.5)),
      );
    }

    // ground
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, groundY + 1), width: w * 0.62, height: h * 0.10),
      Paint()..color = const Color(0xFF8D6E4A).withValues(alpha: 0.55),
    );

    if (gg < 0.4) {
      // seed
      canvas.drawOval(
        Rect.fromCenter(center: Offset(w / 2, groundY - h * 0.025), width: w * 0.12, height: h * 0.07),
        Paint()..color = _trunk,
      );
    } else {
      final trunkH = h * (0.10 + 0.36 * t);
      final trunkW = w * (0.035 + 0.075 * t);
      final trunkRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(w / 2 - trunkW / 2, groundY - trunkH, trunkW, trunkH),
        Radius.circular(trunkW / 2),
      );
      canvas.drawRRect(trunkRect, Paint()..color = _trunk);
      final topY = groundY - trunkH;

      if (gg < 1.8) {
        // sprout: two leaves
        final k = ((gg - 0.4) / 1.4).clamp(0.0, 1.0);
        _leaf(canvas, Offset(w / 2, topY + 1), -0.7, w * (0.10 + 0.08 * k), _leaf2);
        _leaf(canvas, Offset(w / 2, topY + 1), 0.7, w * (0.10 + 0.08 * k), _leaf1);
      } else {
        final r = h * (0.07 + 0.25 * ((gg - 1.8) / 3.2).clamp(0.0, 1.0));
        final cx = w / 2, cy = topY - r * 0.35;
        // back clusters
        if (gg >= 2.6) {
          canvas.drawCircle(Offset(cx - r * 0.75, cy + r * 0.2), r * 0.72, Paint()..color = _leaf3);
          canvas.drawCircle(Offset(cx + r * 0.75, cy + r * 0.2), r * 0.72, Paint()..color = _leaf3);
        }
        canvas.drawCircle(Offset(cx, cy), r, Paint()..color = _leaf1);
        if (gg >= 3.4) {
          canvas.drawCircle(Offset(cx - r * 0.35, cy - r * 0.55), r * 0.6, Paint()..color = _leaf2);
          canvas.drawCircle(Offset(cx + r * 0.45, cy - r * 0.35), r * 0.5, Paint()..color = _leaf2);
        } else {
          canvas.drawCircle(Offset(cx - r * 0.25, cy - r * 0.3), r * 0.5, Paint()..color = _leaf2);
        }
        // fruits (fully grown)
        if (gg >= 4.6) {
          final fruit = Paint()..color = const Color(0xFFE53935);
          final gold = Paint()..color = const Color(0xFFFFC107);
          final pts = [
            Offset(cx - r * 0.5, cy + r * 0.1),
            Offset(cx + r * 0.45, cy - r * 0.05),
            Offset(cx, cy + r * 0.5),
            Offset(cx - r * 0.1, cy - r * 0.45),
            Offset(cx + r * 0.7, cy + r * 0.4),
          ];
          for (var i = 0; i < pts.length; i++) {
            canvas.drawCircle(pts[i], r * 0.11, i.isEven ? fruit : gold);
          }
        }
      }
    }

    if (thirsty) {
      final c = Offset(w * 0.84, h * 0.16);
      final path = Path()
        ..moveTo(c.dx, c.dy - h * 0.09)
        ..quadraticBezierTo(c.dx + h * 0.07, c.dy, c.dx, c.dy + h * 0.05)
        ..quadraticBezierTo(c.dx - h * 0.07, c.dy, c.dx, c.dy - h * 0.09);
      canvas.drawPath(path, Paint()..color = const Color(0xFF42A5F5));
    }
  }

  void _leaf(Canvas canvas, Offset base, double angle, double len, Color color) {
    canvas.save();
    canvas.translate(base.dx, base.dy);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(len * 0.5, -len * 0.45, 0, -len)
      ..quadraticBezierTo(-len * 0.5, -len * 0.45, 0, 0);
    canvas.drawPath(path, Paint()..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TreePainter o) => o.g != g || o.glow != glow || o.thirsty != thirsty;
}

/// Bounce + haptic wrapper used when the user taps a tree to mark a prayer.
class TreeBounce extends StatefulWidget {
  final Widget child;
  final int trigger;
  const TreeBounce({super.key, required this.child, required this.trigger});

  @override
  State<TreeBounce> createState() => _TreeBounceState();
}

class _TreeBounceState extends State<TreeBounce> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));

  @override
  void didUpdateWidget(TreeBounce old) {
    super.didUpdateWidget(old);
    if (old.trigger != widget.trigger) _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, child) => Transform.scale(scale: 1 + 0.18 * math.sin(_c.value * math.pi), child: child),
        child: widget.child,
      );
}
