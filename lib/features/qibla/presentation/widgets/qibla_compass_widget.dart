import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/qibla_controller.dart';
import '../../../../l10n/app_localizations.dart';

class QiblaCompassWidget extends StatefulWidget {
  final QiblaState state;

  const QiblaCompassWidget({super.key, required this.state});

  @override
  State<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends State<QiblaCompassWidget> {
  double _lastValidHeading = 0.0;
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    
    final qiblaBearing = widget.state.qiblaBearing ?? 0.0;
    final deviceHeading = widget.state.deviceHeading ?? 0.0;
    final isAligned = widget.state.status == QiblaStatus.qiblaLocked;

    // Calculate shortest path for smooth rotation
    if (widget.state.deviceHeading != null) {
      double diff = deviceHeading - _lastValidHeading;
      if (diff > 180) diff -= 360;
      if (diff < -180) diff += 360;
      _lastValidHeading += diff; // continuous growing/shrinking angle
    }
    
    final currentHeading = _lastValidHeading;

    // Calculate rotation in a way that chooses the shortest path
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          
          // Custom Compass Dial - Fully Dynamic
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 350,
              ),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle Glow when aligned
              AnimatedOpacity(
                opacity: isAligned ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 40,
                        spreadRadius: 20,
                      )
                    ],
                  ),
                ),
              ),

              // The World-Relative Compass Dial
              AnimatedRotation(
                turns: -currentHeading / 360.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Dial Background (N, E, S, W, ticks)
                        CustomPaint(
                          size: const Size(300, 300),
                          painter: CompassDialPainter(
                            color: colorScheme.primary,
                          ),
                        ),
                        
                        // Qibla Marker drawn relative to True North
                        Transform.rotate(
                          angle: qiblaBearing * (math.pi / 180),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30), // Offset from edge
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isAligned ? 45 : 35,
                                height: isAligned ? 45 : 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorScheme.surface,
                                  border: Border.all(
                                    color: isAligned ? colorScheme.primary : colorScheme.primary.withValues(alpha: 0.5), 
                                    width: isAligned ? 3 : 1
                                  ),
                                  boxShadow: isAligned ? [
                                    BoxShadow(
                                      color: colorScheme.primary.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ] : null,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/Kaaba.png',
                                    width: isAligned ? 30 : 20,
                                    height: isAligned ? 30 : 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              // Fixed Center Indicator (YOU ARE HERE)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomPaint(
                    size: const Size(20, 20),
                    painter: FixedIndicatorPainter(color: colorScheme.error), // Usually red to indicate forward
                  ),
                ),
              ),
              
              // Center Dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ),
      ),
    ), // Close Flexible

    const SizedBox(height: 30),

        // Angle Display & Alignment Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: isAligned ? colorScheme.primaryContainer : Colors.transparent,
            border: Border.all(
              color: isAligned ? Colors.transparent : colorScheme.primary.withValues(alpha: 0.2)
            ),
          ),
          child: Column(
            children: [
              Text(
                l10n.qiblaDirection,
                style: TextStyle(
                  color: isAligned ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${qiblaBearing.toStringAsFixed(0)}°',
                style: TextStyle(
                  color: isAligned ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: isAligned 
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            l10n.youAreFacingQibla,
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(height: 0),
              )
            ],
          ),
        ),
      ],
    ),
  );
  }
}

class CompassDialPainter extends CustomPainter {
  final Color color;

  CompassDialPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw outer circle
    canvas.drawCircle(center, radius - 15, paint);
    
    final innerPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius - 45, innerPaint);
    canvas.drawCircle(center, radius - 75, innerPaint);

    // Draw tick marks
    for (int i = 0; i < 360; i += 5) {
      final isMajor = i % 90 == 0;
      final isMedium = i % 30 == 0;
      
      final tickLength = isMajor ? 20.0 : (isMedium ? 12.0 : 6.0);
      final angle = (i - 90) * math.pi / 180; // Start 0 at top
      
      final p1 = Offset(
        center.dx + (radius - 15) * math.cos(angle),
        center.dy + (radius - 15) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius - 15 - tickLength) * math.cos(angle),
        center.dy + (radius - 15 - tickLength) * math.sin(angle),
      );

      final tickPaint = Paint()
        ..color = isMajor ? color : color.withValues(alpha: isMedium ? 0.7 : 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isMajor ? 2.5 : (isMedium ? 1.5 : 1.0);
        
      canvas.drawLine(p1, p2, tickPaint);
    }

    // Draw N, E, S, W
    _drawText(canvas, 'N', Offset(center.dx, center.dy - radius + 45), color, isBold: true);
    _drawText(canvas, 'E', Offset(center.dx + radius - 45, center.dy), color);
    _drawText(canvas, 'S', Offset(center.dx, center.dy + radius - 45), color);
    _drawText(canvas, 'W', Offset(center.dx - radius + 45, center.dy), color);
  }

  void _drawText(Canvas canvas, String text, Offset position, Color color, {bool isBold = false}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: isBold ? 22 : 16,
          fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FixedIndicatorPainter extends CustomPainter {
  final Color color;

  FixedIndicatorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw an inverted triangle pointing down slightly at the top rim
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
