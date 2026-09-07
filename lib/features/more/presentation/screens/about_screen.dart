import 'package:flutter/material.dart';
import 'package:boshra/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
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
          l10n.aboutBoshra,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          // LOGO AND HEADER
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/main_logo.png', // Ensure this exists, else placeholder
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.mosque,
                        size: 50,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Boshra',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.boshraTagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                if (_version.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'v$_version+$_buildNumber',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 48),
          
          // FEATURES LIST
          _SectionCard(
            children: [
              _FeatureTile(
                title: l10n.quran,
                subtitle: l10n.quranDesc,
                icon: Icons.menu_book,
              ),
              const Divider(height: 1),
              _FeatureTile(
                title: l10n.quranRecitation,
                subtitle: l10n.quranRecitationDesc,
                icon: Icons.headset,
              ),
              const Divider(height: 1),
              _FeatureTile(
                title: l10n.azkar,
                subtitle: l10n.azkarDesc,
                icon: Icons.volunteer_activism,
              ),
              const Divider(height: 1),
              _FeatureTile(
                title: l10n.prayerTimesText,
                subtitle: l10n.prayerTimesDesc,
                icon: Icons.access_time,
              ),
              const Divider(height: 1),
              _FeatureTile(
                title: l10n.qibla,
                subtitle: l10n.qiblaDesc,
                icon: Icons.explore,
              ),
              const Divider(height: 1),
              _FeatureTile(
                title: l10n.reminders,
                subtitle: l10n.remindersDesc,
                icon: Icons.notifications_active,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // MORE
          _SectionCard(
            children: [
              _ActionTile(
                title: l10n.rateBoshra,
                icon: Icons.star_border,
                onTap: () {
                  // TODO: App Store link
                },
              ),
              const Divider(height: 1),
              _ActionTile(
                title: l10n.shareBoshra,
                icon: Icons.share,
                onTap: () {
                  // TODO: Share logic
                },
              ),
              const Divider(height: 1),
              _ActionTile(
                title: l10n.contactUs,
                icon: Icons.mail_outline,
                onTap: () => _launchUrl('mailto:mahmoudashraf.eng19@gmail.com'),
              ),
              const Divider(height: 1),
              _ActionTile(
                title: l10n.openSourceLicenses,
                icon: Icons.code,
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: 'Boshra',
                    applicationVersion: _version,
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/icons/main_logo.png',
                        width: 64,
                        errorBuilder: (c,e,s) => Icon(Icons.mosque, size: 64, color: colorScheme.primary),
                      ),
                    ),
                    applicationLegalese: l10n.madeWithCare,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
          

          
          // FOOTER
          Center(
            child: Column(
              children: [
                Text(
                  '${l10n.version} $_version (${l10n.buildNumber} $_buildNumber)',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.madeWithCare,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
            size: 24,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _ActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
