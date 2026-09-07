import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:boshra/l10n/app_localizations.dart';
import '../../../../core/providers/locale_provider.dart';
import 'terms_data.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1C221A) : Theme.of(context).scaffoldBackgroundColor;
    
    final currentLang = context.watch<LocaleProvider>().locale?.languageCode ?? 'en';
    final termsMarkdown = TermsData.localizedTerms[currentLang] ?? TermsData.localizedTerms['en']!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.termsAndConditions,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: isDark ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Markdown(
            data: termsMarkdown,
            selectable: true,
            padding: const EdgeInsets.all(24.0),
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: colorScheme.onSurface,
              ),
              h2: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                height: 1.5,
              ),
              h3: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary.withValues(alpha: 0.8),
                height: 1.5,
              ),
              listBullet: TextStyle(
                color: colorScheme.primary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
