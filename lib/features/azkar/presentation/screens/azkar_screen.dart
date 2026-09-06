import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/azkar_category_card.dart';
import 'azkar_details_screen.dart';
import 'azkar_categories_screen.dart';
import 'package:provider/provider.dart';
import '../providers/azkar_provider.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  @override
  void initState() {
    super.initState();
    // Load Azkar if not loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AzkarProvider>();
      if (provider.groupedAzkar.isEmpty && !provider.isLoading) {
        provider.loadAzkar(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Using a subtle dark background similar to the image
    final backgroundColor = isDark ? const Color(0xFF1C221A) : Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header Title
              Text(
                l10n.azkarScreenTitle,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Theme.of(context).colorScheme.primary, 
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                l10n.azkarScreenSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 16),
              
              // Grid View
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9, // Adjust ratio to match cards
                  children: [
                    AzkarCategoryCard(
                      title: l10n.azkarCategoryMorning,
                      subtitle: l10n.azkarCategoryMorningSub,
                      icon: Icons.wb_sunny_outlined,
                      onTap: () => _navigateToDetails(context, 'أذكار الصباح', 'Morning'),
                    ),
                    AzkarCategoryCard(
                      title: l10n.azkarCategoryEvening,
                      subtitle: l10n.azkarCategoryEveningSub,
                      icon: Icons.wb_twilight_outlined,
                      onTap: () => _navigateToDetails(context, 'أذكار المساء', 'Evening'),
                    ),
                    AzkarCategoryCard(
                      title: l10n.azkarCategoryPrayer,
                      subtitle: l10n.azkarCategoryPrayerSub,
                      icon: Icons.mosque_outlined,
                      onTap: () => _navigateToDetails(context, 'الأذكار بعد السلام من الصلاة', 'Prayer'),
                    ),
                    AzkarCategoryCard(
                      title: l10n.azkarCategorySleep,
                      subtitle: l10n.azkarCategorySleepSub,
                      icon: Icons.nights_stay_outlined,
                      onTap: () => _navigateToDetails(context, 'أذكار النوم', 'Sleep'),
                    ),
                    AzkarCategoryCard(
                      title: l10n.azkarCategoryProtection,
                      subtitle: l10n.azkarCategoryProtectionSub,
                      icon: Icons.security_outlined,
                      onTap: () => _navigateToDetails(context, 'أذكار الاستيقاظ من النوم', 'Waking up'),
                    ),
                    AzkarCategoryCard(
                      title: l10n.azkarCategoryDaily,
                      subtitle: l10n.azkarCategoryDailySub,
                      icon: Icons.eco_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AzkarCategoriesScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String arKey, String enKeyword) {
    final provider = context.read<AzkarProvider>();
    String targetKey = arKey;
    
    // Dynamically find the key from the loaded JSON based on English/Arabic keywords
    if (!provider.groupedAzkar.containsKey(arKey)) {
      try {
        targetKey = provider.groupedAzkar.keys.firstWhere(
          (k) => k.toLowerCase().contains(enKeyword.toLowerCase()) || k.contains(arKey)
        );
      } catch (_) {
        // If exact match not found, just use the first available category to avoid empty screens
        if (provider.groupedAzkar.isNotEmpty) {
           targetKey = provider.groupedAzkar.keys.first;
        }
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AzkarDetailsScreen(categoryName: targetKey),
      ),
    );
  }
}
