import 'package:flutter/material.dart';
import 'package:boshra/l10n/app_localizations.dart';
import 'dart:math' as math;
import '../../../../core/services/storage_service.dart';
import '../../../../features/splash/presentation/screens/splash_screen.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final StorageService _storageService = StorageService();
  StorageInfo? _storageInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStorageInfo();
  }

  Future<void> _loadStorageInfo() async {
    setState(() => _isLoading = true);
    final info = await _storageService.getStorageInfo();
    setState(() {
      _storageInfo = info;
      _isLoading = false;
    });
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 MB";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).round()} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1C221A) : Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.dataAndStorage,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Chart
                  _buildChartCard(context, colorScheme),
                  
                  const SizedBox(height: 32),
                  
                  // Legend
                  _buildLegendItem(colorScheme.primary, l10n.systemApp, _formatBytes(_storageInfo!.systemBytes)),
                  _buildLegendItem(const Color(0xFF8B5A2B), 'App Data', _formatBytes(_storageInfo!.appDataBytes)),
                  _buildLegendItem(const Color(0xFFB89F78), l10n.downloadedSurahs, _formatBytes(_storageInfo!.downloadedSurahsBytes)),
                  _buildLegendItem(const Color(0xFFDDA15E), l10n.azkar, _formatBytes(_storageInfo!.azkarBytes)),
                  _buildLegendItem(const Color(0xFF3A86FF), l10n.cache, _formatBytes(_storageInfo!.cacheBytes)),
                  
                  const SizedBox(height: 24),
                  
                  // Boshra Storage Limit Bar
                  _buildStorageLimitBar(context, colorScheme),
                  
                  const SizedBox(height: 16),
                  Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  
                  // Buttons
                  _buildActionButton(
                    icon: Icons.delete_outline,
                    label: l10n.clearCache,
                    bgColor: isDark ? colorScheme.surfaceContainerHighest : const Color(0xFFE8E1D5),
                    textColor: colorScheme.onSurface,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(l10n.clearCache),
                          content: Text(l10n.clearCacheWarning),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                              child: Text(l10n.yesClear),
                            ),
                          ],
                        ),
                      );
                      
                      if (confirm == true) {
                        await _storageService.clearCache();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const SplashScreen()),
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildActionButton(
                    icon: Icons.delete_forever,
                    label: l10n.clearAllDownloads,
                    bgColor: isDark ? colorScheme.surfaceContainerHighest : const Color(0xFFE8E1D5),
                    textColor: colorScheme.onSurface,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(l10n.clearAllDownloads),
                          content: Text(l10n.clearWarning),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                              child: Text(l10n.yesClear),
                            ),
                          ],
                        ),
                      );
                      
                      if (confirm == true) {
                        await _storageService.clearAllDownloads();
                        await _loadStorageInfo();
                      }
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildActionButton(
                    icon: Icons.warning_amber_rounded,
                    label: l10n.clearAllData,
                    bgColor: colorScheme.errorContainer.withValues(alpha: 0.2),
                    textColor: colorScheme.error,
                    borderColor: colorScheme.error,
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(l10n.clearAllData),
                          content: Text(l10n.clearDataWarning),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
                              child: Text(l10n.yesClear),
                            ),
                          ],
                        ),
                      );
                      
                      if (confirm == true) {
                        await _storageService.clearAllData();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const SplashScreen()),
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _buildChartCard(BuildContext context, ColorScheme colorScheme) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalUsed = _storageInfo!.totalUsedBytes;
    final maxStorage = StorageService.maxStorageBytes;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [],
      ),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(200, 200),
                painter: _StorageChartPainter(
                  info: _storageInfo!,
                  maxStorage: maxStorage,
                  colorScheme: colorScheme,
                  isDark: isDark,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.totalUsed,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatBytes(totalUsed),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Localizations.localeOf(context).languageCode == 'ar' ? 'من 3 جيجا' : 'of 3 GB',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageLimitBar(BuildContext context, ColorScheme colorScheme) {
    final totalUsed = _storageInfo!.totalUsedBytes;
    final maxStorage = StorageService.maxStorageBytes;
    final percentage = (totalUsed / maxStorage).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Boshra Storage Limit',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              '${_formatBytes(totalUsed)} / ${_formatBytes(maxStorage)}',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
            backgroundColor: colorScheme.outlineVariant.withValues(alpha: 0.2),
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StorageChartPainter extends CustomPainter {
  final StorageInfo info;
  final int maxStorage;
  final ColorScheme colorScheme;
  final bool isDark;

  _StorageChartPainter({
    required this.info,
    required this.maxStorage,
    required this.colorScheme,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 24.0;
    
    // Background track (Free space)
    final trackPaint = Paint()
      ..color = isDark ? colorScheme.outlineVariant.withValues(alpha: 0.1) : const Color(0xFFF0EBE1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;
      
    canvas.drawCircle(center, radius - strokeWidth / 2, trackPaint);

    double startAngle = -math.pi / 2; // Start at top

    void drawSegment(int bytes, Color color) {
      if (bytes <= 0) return;
      
      // Calculate real angle
      double sweepAngle = (bytes / maxStorage) * 2 * math.pi;
      
      // Enforce a minimum visual angle (e.g. 3 degrees) so tiny files are still visible on the chart
      final minAngle = (3.0 * math.pi) / 180.0;
      if (sweepAngle < minAngle) {
        sweepAngle = minAngle;
      }
      
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
        
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      
      startAngle += sweepAngle;
    }

    drawSegment(info.systemBytes, colorScheme.primary);
    drawSegment(info.appDataBytes, const Color(0xFF8B5A2B));
    drawSegment(info.downloadedSurahsBytes, const Color(0xFFB89F78));
    drawSegment(info.azkarBytes, const Color(0xFFDDA15E));
    drawSegment(info.cacheBytes, const Color(0xFF3A86FF));
  }

  @override
  bool shouldRepaint(covariant _StorageChartPainter oldDelegate) {
    return oldDelegate.info != info || oldDelegate.maxStorage != maxStorage || oldDelegate.isDark != isDark;
  }
}
