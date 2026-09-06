import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/radio_provider.dart';
import '../../../../core/theme/app_colors.dart';

class RadioPlayerBar extends StatelessWidget {
  const RadioPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RadioProvider>();
    final radio = provider.selectedRadio;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (radio == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevatedSurface : AppColors.lightSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Radio Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                radio.img,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Icon(Icons.radio),
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Radio Name and Status
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    radio.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider.isPlaying ? 'مباشر - Live' : 'متوقف - Paused',
                    style: TextStyle(
                      fontSize: 12,
                      color: provider.isPlaying ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Play/Pause Button
            IconButton(
              iconSize: 32,
              icon: Icon(
                provider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                if (provider.isPlaying) {
                  provider.togglePlayPause();
                } else {
                  provider.playSelectedRadio();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
