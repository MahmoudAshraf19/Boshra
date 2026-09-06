import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_action_button.dart';
import '../../../quran/data/models/quran_models.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../l10n/app_localizations.dart';

class AyahOfTheDayCard extends StatelessWidget {
  final AyahModel ayah;
  final VoidCallback onListen;
  final VoidCallback onTafseer;

  const AyahOfTheDayCard({
    super.key,
    required this.ayah,
    required this.onListen,
    required this.onTafseer,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final String title = l10n.ayahOfTheDay; 
    final String listenStr = l10n.listen;
    final String tafseerStr = l10n.tafseer;
    
    // Safely extract the surah name based on language
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final surahName = isAr ? (ayah.surahName ?? 'غير معروف') : (ayah.surahEnglishName ?? 'Unknown');
    final ayahInfo = l10n.surahAndVerse(surahName, ayah.numberInSurah.toString());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark 
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) 
            : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history_edu,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              // Quran icon placeholder - Replace with actual asset if available
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.lightBackground.withValues(alpha: isDark ? 0.1 : 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.menu_book, color: AppColors.lightGoldenAccent),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Ayah Text
          Center(
            child: Text(
              ayah.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                height: 1.8,
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'Uthmanic', 
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Surah Info
          Center(
            child: Text(
              ayahInfo,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomActionButton(
                label: listenStr,
                icon: Icons.play_arrow_outlined,
                backgroundColor: isDark ? Colors.green.shade800 : const Color(0xFF356B4E), // Dark green
                foregroundColor: Colors.white,
                onTap: onListen,
              ),
              CustomActionButton(
                label: tafseerStr,
                icon: Icons.menu_book,
                onTap: onTafseer,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
