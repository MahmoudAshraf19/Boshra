import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boshra/l10n/app_localizations.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/widgets/blur_loading_overlay.dart';

class LanguageBottomSheet extends StatelessWidget {
  final BuildContext parentContext;

  const LanguageBottomSheet({super.key, required this.parentContext});

  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ar', 'name': 'العربية'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'fr', 'name': 'Français'},
    {'code': 'it', 'name': 'Italiano'},
    {'code': 'fa', 'name': 'فارسی'},
    {'code': 'ur', 'name': 'اردو'},
    {'code': 'hi', 'name': 'हिन्दी'},
  ];

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LanguageBottomSheet(parentContext: context),
    );
  }

  void _onLanguageSelected(BuildContext context, String langCode) async {
    final currentCode = parentContext.read<LocaleProvider>().locale?.languageCode ?? 'en';
    if (currentCode == langCode) {
      Navigator.pop(context);
      return;
    }

    // Close BottomSheet
    Navigator.pop(context);

    // Show Blur Loading Overlay using parent context
    BlurLoadingOverlay.show(parentContext);

    // Give it a brief pause for the beautiful effect
    await Future.delayed(const Duration(milliseconds: 1200));

    // Change Language
    if (parentContext.mounted) {
      await parentContext.read<LocaleProvider>().changeLanguage(langCode);
      // Wait for flutter to rebuild before hiding overlay
      await Future.delayed(const Duration(milliseconds: 300));
      if (parentContext.mounted) {
        BlurLoadingOverlay.hide(parentContext);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // Fallback to English if not set
    final currentLang = context.watch<LocaleProvider>().locale?.languageCode ?? 'en';

    return Container(
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest : const Color(0xFFF9F7F3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              AppLocalizations.of(context)!.appLanguage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            
            const SizedBox(height: 24),
            
            Container(
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? colorScheme.outlineVariant : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: supportedLanguages.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: isDark ? colorScheme.outlineVariant : Colors.black.withValues(alpha: 0.05),
                ),
                itemBuilder: (context, index) {
                  final lang = supportedLanguages[index];
                  final isSelected = lang['code'] == currentLang;
                  
                  return InkWell(
                    onTap: () => _onLanguageSelected(context, lang['code']!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: isSelected 
                                ? const Color(0xFF2E4D43) // Elegant dark green based on UI
                                : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              lang['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected 
                                    ? const Color(0xFF2E4D43)
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2E4D43),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            )
                          else
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
