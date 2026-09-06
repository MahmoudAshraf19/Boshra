import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../qibla/presentation/screens/qibla_screen.dart';
import '../../../quran/presentation/widgets/recitation_bottom_sheet.dart';

class QuickAccessCard extends StatelessWidget {
  final Function(int)? onTabChange;
  
  const QuickAccessCard({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark 
            ? colorScheme.primary.withValues(alpha: 0.1) 
            : colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.quickAccess,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Items Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(
                context,
                title: l10n.quran,
                icon: Icons.menu_book_outlined,
                color: AppColors.lightPrimary,
                isDark: isDark,
                onTap: () {
                  onTabChange?.call(1); // Index 1 is Quran
                },
              ),
              _buildItem(
                context,
                title: l10n.recitation,
                icon: Icons.headphones_outlined,
                color: AppColors.lightGoldenAccent,
                isDark: isDark,
                onTap: () {
                  onTabChange?.call(1); // Index 1 is Quran Tab
                },
              ),
              _buildItem(
                context,
                title: l10n.qibla,
                icon: Icons.explore_outlined,
                color: AppColors.lightPrimary,
                isDark: isDark,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QiblaScreen()));
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(
                context,
                title: l10n.azkar,
                icon: Icons.lens_blur, // Represents misbaha/beads
                color: AppColors.lightTerracottaAccent,
                isDark: isDark,
                onTap: () {
                  onTabChange?.call(2); // Index 2 is Azkar
                },
              ),
              _buildItem(
                context,
                title: l10n.quranRadio,
                icon: Icons.radio_outlined,
                color: AppColors.lightPrimary,
                isDark: isDark,
                onTap: () {
                  onTabChange?.call(3); // Index 3 is Radio
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    // Adaptive colors
    final Color bgColor = isDark 
        ? color.withValues(alpha: 0.15)
        : color.withValues(alpha: 0.1);
    
    final Color iconColor = isDark
        ? color.withValues(alpha: 0.8)
        : color;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 60,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
