import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class QiblaCalibrationWidget extends StatefulWidget {
  const QiblaCalibrationWidget({super.key});

  @override
  State<QiblaCalibrationWidget> createState() => _QiblaCalibrationWidgetState();
}

class _QiblaCalibrationWidgetState extends State<QiblaCalibrationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        
        // Animated Figure 8
        SizedBox(
          width: 200,
          height: 100,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: Figure8Painter(
                  color: colorScheme.primary,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 60),

        Text(
          AppLocalizations.of(context)?.qiblaCalibration ?? 'معايرة القبلة',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            AppLocalizations.of(context)?.qiblaCalibrationDesc ?? 'يرجى تحريك الهاتف ببطء في شكل رقم 8 حتى معايرة البوصلة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class Figure8Painter extends CustomPainter {
  final Color color;
  final double progress;

  Figure8Painter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeDashPattern = [5, 5];

    final path = Path();
    
    // Draw infinity / Figure 8 symbol
    final width = size.width;
    final height = size.height;
    
    for (double t = 0; t <= math.pi * 2; t += 0.05) {
      final x = width / 2 + (width / 2.2 * math.cos(t)) / (1 + math.pow(math.sin(t), 2));
      final y = height / 2 + (height / 2.2 * math.sin(t) * math.cos(t)) / (1 + math.pow(math.sin(t), 2));
      
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    path.close();
    canvas.drawPath(path, paint);

    // Draw moving dot
    final t = progress * math.pi * 2;
    final dotX = width / 2 + (width / 2.2 * math.cos(t)) / (1 + math.pow(math.sin(t), 2));
    final dotY = height / 2 + (height / 2.2 * math.sin(t) * math.cos(t)) / (1 + math.pow(math.sin(t), 2));

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
      
    canvas.drawCircle(Offset(dotX, dotY), 8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant Figure8Painter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Extension to support dash pattern drawing
extension DashPathExtension on Paint {
  set strokeDashPattern(List<double> pattern) {
    // Basic dash pattern support is not built into standard Canvas directly without path metrics,
    // For simplicity, we just use a solid line with alpha, or one could use path_drawing package.
    // Given the constraints, we will just rely on the alpha for the background path.
  }
}
