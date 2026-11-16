import 'package:flutter/material.dart';
import 'package:boshra/l10n/app_localizations.dart';
import 'storage_screen.dart';
import 'privacy_screen.dart';
import 'about_screen.dart';
import 'terms_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/sky_theme.dart';
import '../../../zakat/presentation/screens/zakat_screen.dart';
import '../../../tracker/presentation/screens/weekly_summary_screen.dart';
import '../../../diagnostics/presentation/screens/adhan_diagnostics_screen.dart';
import '../../../sadaqa/presentation/screens/sadaqa_jariya_screen.dart';
import '../../../tracker/presentation/screens/prayer_garden_screen.dart';
import '../../../tracker/presentation/screens/prayer_tracker_screen.dart';
import '../../../prayer/presentation/screens/prayer_mode_screen.dart';
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
    
    // Get current language from provider efficiently with select
    final currentLangCode = context.select<LocaleProvider, String>((p) => p.locale.languageCode);
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
        cacheExtent: 800,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(20.0),
        children: [
          // Section 1: General
          _SectionTitle(title: l10n.generalSettings),
          RepaintBoundary(
            child: _SettingsGroupCard(
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
          ),
          
          const SizedBox(height: 24),
          
          // Section 2: Alerts
          _SectionTitle(title: l10n.alertsSettings),
          RepaintBoundary(
            child: _SettingsGroupCard(
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
          ),

          const SizedBox(height: 24),

          // Section 3: Data & Storage
          _SectionTitle(title: l10n.dataAndStorage),
          RepaintBoundary(
            child: _SettingsGroupCard(
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
          ),

          const SizedBox(height: 24),

          // Section 4: Features & Services
          _SectionTitle(
            title: switch (currentLangCode) {
              'ar' => 'خدمات ومميزات',
              'ur' => 'خدمات اور خصوصیات',
              'fa' => 'ویژگی‌ها و خدمات',
              'fr' => 'Fonctionnalités et services',
              'es' => 'Funciones y servicios',
              'it' => 'Funzionalità e servizi',
              'hi' => 'सुविधाएँ और सेवाएँ',
              _ => 'Features & Services',
            },
          ),
          RepaintBoundary(
            child: _SettingsGroupCard(
              children: [
                _SettingsTile(
                  iconData: Icons.calculate_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'حاسبة الزكاة' : 'Zakat calculator',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'بأسعار الذهب والفضة بعملتك + تذكير سنوي'
                      : 'With live gold & silver prices in your currency + yearly reminder',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ZakatScreen()));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.insights_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'ملخّصك الأسبوعي' : 'Weekly summary',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'صلواتك هذا الأسبوع + شجرتك للمشاركة'
                      : 'Your prayers this week + your tree to share',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const WeeklySummaryScreen()));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.wb_twilight_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'المظهر الحي' : 'Living theme',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'خلفية تتغيّر مع الشمس الحقيقية في مدينتك والفصل'
                      : 'A sky that follows the real sun in your city and the season',
                  onTap: () {
                    final ar = Localizations.localeOf(context).languageCode == 'ar';
                    showModalBottomSheet<void>(
                      context: context,
                      showDragHandle: true,
                      builder: (_) => ValueListenableBuilder<bool>(
                        valueListenable: SkyTheme.enabled,
                        builder: (ctx, on, __) => SafeArea(
                          child: SwitchListTile(
                            secondary: const Icon(Icons.wb_twilight_rounded),
                            title: Text(ar ? 'المظهر الحي' : 'Living theme'),
                            subtitle: Text(ar
                                ? 'فجر، شروق، ظهر، غروب… الشمس والقمر في مكانهم الحقيقي بمدينتك، ولمسة تتغيّر مع الفصل.'
                                : 'Dawn, sunrise, noon, sunset… the sun and moon at their real place in your city, with a seasonal touch.'),
                            value: on,
                            onChanged: (v) => SkyTheme.setEnabled(v),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                _SettingsTile(
                  iconData: Icons.yard_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'حديقتي' : 'My garden',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'حديقة شهرية بالهجري — شجرة لكل صلاة في كل يوم'
                      : 'A monthly Hijri garden — a tree for every prayer, every day',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerGardenScreen()));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.park_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'متتبّع الصلوات' : 'Prayer tracker',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'سجّل صلواتك وكبّر شجرتك'
                      : 'Log your prayers and grow your trees',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerTrackerScreen()));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.do_not_disturb_on_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'وضع الصلاة والإقامة' : 'Prayer mode & Iqama',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'كتم تلقائي بعد الأذان وتنبيه الإقامة'
                      : 'Auto-silence after the Adhan and iqama alert',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerModeScreen()));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.volunteer_activism_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'صدقة جارية' : 'Ongoing charity',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'شارك التطبيق بكود الدعوة الخاص بك'
                      : 'Share the app with your invite code',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SadaqaJariyaScreen()),
                    );
                  },
                ),
                _SettingsTile(
                  iconData: Icons.health_and_safety_outlined,
                  title: Localizations.localeOf(context).languageCode == 'ar' ? 'هل الأذان هيشتغل؟' : 'Will the Adhan ring?',
                  subtitle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 'فحص الأذونات والبطارية والموقع والجدولة'
                      : 'Check permissions, battery, location & scheduling',
                  isLast: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdhanDiagnosticsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section 5: Info & Support
          _SectionTitle(title: l10n.infoAndSupport),
          RepaintBoundary(
            child: _SettingsGroupCard(
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
                  iconData: Icons.star_rate_outlined,
                  title: l10n.rateBoshra,
                  subtitle: l10n.rateBoshraDesc,
                  onTap: () {
                    launchUrl(
                      Uri.parse('https://play.google.com/store/apps/details?id=com.app.boshra'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
                _SettingsTile(
                  iconData: Icons.share_outlined,
                  title: l10n.shareBoshra,
                  subtitle: l10n.shareBoshraDesc,
                  onTap: () async {
                    final ar = Localizations.localeOf(context).languageCode == 'ar';
                    final code = await SadaqaJariyaScreen.inviteCode();
                    await Share.share(SadaqaJariyaScreen.message(code, ar));
                  },
                ),
                _SettingsTile(
                  iconData: Icons.chat_outlined,
                  title: l10n.contactUs,
                  subtitle: l10n.contactUsDesc,
                  onTap: () {
                    launchUrl(
                      Uri.parse('https://wa.me/201150125129'),
                      mode: LaunchMode.externalApplication,
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
          ),
          
          const SizedBox(height: 48), // Bottom padding
        ],
      ),
    );
  }

  String _getThemeSubtitle(BuildContext context, AppLocalizations l10n) {
    final mode = context.select<ThemeProvider, ThemeMode>((p) => p.themeMode);
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

    return Material(
      color: cardColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? colorScheme.outlineVariant : Colors.transparent,
        ),
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
