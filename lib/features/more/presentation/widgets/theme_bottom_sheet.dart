import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/providers/theme_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  final BuildContext parentContext;

  const ThemeBottomSheet({super.key, required this.parentContext});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ThemeBottomSheet(parentContext: context),
    );
  }

  void _onThemeSelected(BuildContext context, ThemeMode mode) async {
    final currentMode = parentContext.read<ThemeProvider>().themeMode;
    if (currentMode == mode) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    
    // Slight delay for smoother UX
    await Future.delayed(const Duration(milliseconds: 150));
    
    if (parentContext.mounted) {
      await parentContext.read<ThemeProvider>().setThemeMode(mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentMode = context.watch<ThemeProvider>().themeMode;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                l10n.appearance,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 32),

              _buildThemeOption(
                context: context,
                mode: ThemeMode.light,
                title: l10n.themeLight,
                subtitle: l10n.themeLightDesc,
                icon: Icons.wb_sunny_outlined,
                isSelected: currentMode == ThemeMode.light,
                backgroundColor: const Color(0xFFF6F3EC), // Warm cream
                textColor: const Color(0xFF4A4B42), // Dark olive text
                iconColor: const Color(0xFFB59353), // Golden sun
                borderColor: Colors.transparent,
              ),
              
              const SizedBox(height: 12),

              _buildThemeOption(
                context: context,
                mode: ThemeMode.dark,
                title: l10n.themeDark,
                subtitle: l10n.themeDarkDesc,
                icon: Icons.nightlight_round_outlined,
                isSelected: currentMode == ThemeMode.dark,
                backgroundColor: const Color(0xFF424A3B), // Deep olive dark
                textColor: Colors.white,
                iconColor: const Color(0xFFF9D699), // Light moon
                borderColor: Colors.transparent,
              ),

              const SizedBox(height: 12),

              _buildThemeOption(
                context: context,
                mode: ThemeMode.system,
                title: l10n.themeSystem,
                subtitle: l10n.themeSystemDesc,
                icon: Icons.settings_outlined,
                isSelected: currentMode == ThemeMode.system,
                backgroundColor: isDark ? colorScheme.surface : Colors.white,
                textColor: isDark ? colorScheme.onSurface : const Color(0xFF2E4D43),
                iconColor: isDark ? colorScheme.onSurface : const Color(0xFF2E4D43),
                borderColor: const Color(0xFF2E4D43).withValues(alpha: 0.3),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required ThemeMode mode,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
    required Color borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onThemeSelected(context, mode),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E4D43),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: textColor.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
