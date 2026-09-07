import 'package:flutter/material.dart';
import 'package:boshra/l10n/app_localizations.dart';
import 'storage_screen.dart';
import 'privacy_screen.dart';
import 'about_screen.dart';
import 'terms_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../prayer/presentation/screens/prayer_settings_screen.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/theme_bottom_sheet.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // Get current language from provider
    final currentLangCode = context.watch<LocaleProvider>().locale?.languageCode ?? 'en';
    final currentLangName = LanguageBottomSheet.supportedLanguages.firstWhere(
      (lang) => lang['code'] == currentLangCode,
      orElse: () => {'name': 'English'},
    )['name']!;
    
    // Use the same background as Azkar and Quran screens
    final backgroundColor = isDark ? const Color(0xFF1C221A) : Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.moreScreenTitle,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Section 1: General
          _SectionTitle(title: l10n.generalSettings),
          _SettingsGroupCard(
            children: [
              _SettingsTile(
                iconData: Icons.palette_outlined,
                title: l10n.appearance,
                subtitle: _getThemeSubtitle(context, l10n),
                onTap: () {
                  ThemeBottomSheet.show(context);
                },
              ),
              _SettingsTile(
                iconData: Icons.language_outlined,
                title: l10n.appLanguage,
                subtitle: currentLangName,
                isLast: true,
                onTap: () {
                  LanguageBottomSheet.show(context);
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Section 2: Alerts
          _SectionTitle(title: l10n.alertsSettings),
          _SettingsGroupCard(
            children: [
              _SettingsTile(
                iconData: Icons.notifications_none_outlined,
                title: l10n.notifications,
                subtitle: l10n.adhanAndReminders,
                isLast: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerSettingsScreen()));
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section 3: Data & Storage
          _SectionTitle(title: l10n.dataAndStorage),
          _SettingsGroupCard(
            children: [
              _SettingsTile(
                iconData: Icons.folder_open_outlined,
                title: l10n.storage,
                subtitle: l10n.storageDesc,
                isLast: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StorageScreen()),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section 4: Info & Support
          _SectionTitle(title: l10n.infoAndSupport),
          _SettingsGroupCard(
            children: [
              _SettingsTile(
                iconData: Icons.description_outlined,
                title: l10n.termsAndConditions,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TermsScreen()),
                  );
                },
              ),
              _SettingsTile(
                iconData: Icons.shield_outlined,
                title: l10n.privacyAndPermissions,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                  );
                },
              ),
              _SettingsTile(
                iconData: Icons.info_outline,
                title: l10n.aboutBoshra,
                isLast: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: 48), // Bottom padding
        ],
      ),
    );
  }

  String _getThemeSubtitle(BuildContext context, AppLocalizations l10n) {
    final mode = context.watch<ThemeProvider>().themeMode;
    switch (mode) {
      case ThemeMode.light:
        return l10n.themeLight;
      case ThemeMode.dark:
        return l10n.themeDark;
      case ThemeMode.system:
        return l10n.themeSystem;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsGroupCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // Card background color should stand out slightly from scaffold
    final cardColor = isDark ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? colorScheme.outlineVariant : Colors.transparent,
        ),
        boxShadow: const [],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isLast;

  const _SettingsTile({
    required this.iconData,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: isLast && subtitle == null ? const Radius.circular(0) : const Radius.circular(0), // Simplified, handled by parent clip or material
      ), // Actually, we should just let InkWell clip or wrap the whole group in a Material. 
      // For now, this works fine.
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                // Icon with subtle background
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark ? colorScheme.primaryContainer : colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: isDark ? colorScheme.onPrimaryContainer : colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing Chevron
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          if (!isLast)
            Divider(
              height: 1,
              indent: 72, // Aligns with text
              color: isDark ? colorScheme.outlineVariant : Colors.black.withValues(alpha: 0.05),
            ),
        ],
      ),
    );
  }
}
