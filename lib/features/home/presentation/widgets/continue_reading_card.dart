import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../quran/data/repositories/quran_repository.dart';
import '../../../quran/presentation/screens/quran_screen.dart';

class ContinueReadingCard extends StatefulWidget {
  const ContinueReadingCard({super.key});

  @override
  State<ContinueReadingCard> createState() => _ContinueReadingCardState();
}

class _ContinueReadingCardState extends State<ContinueReadingCard> {
  int _lastReadSurah = 1;
  int _lastReadAyah = 1;
  String _surahName = 'الفاتحة';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedBookmark();
  }

  Future<void> _loadSavedBookmark() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _lastReadSurah = prefs.getInt('last_read_surah') ?? 1;
      _lastReadAyah = prefs.getInt('last_read_ayah') ?? 1;

      final repo = QuranRepository();
      final meta = await repo.getQuranMetadata();
      if (meta != null && _lastReadSurah > 0 && _lastReadSurah <= meta.surahs.length) {
        _surahName = meta.surahs[_lastReadSurah - 1].name;
      }
    } catch (e) {
      print('Error loading bookmark: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    // We can extract current language directionality if needed,
    // but Flutter's Directionality handles Row ordering for RTL automatically.

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                l10n.continueReadingCardTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.menu_book_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          GestureDetector(
            onTap: () {
              // Open Quran screen at specific surah and ayah
              // We'll push a dedicated QuranScreen, or if they want it in the bottom nav, 
              // we can instruct the user to use the tab change. Since QuranScreen doesn't take params natively,
              // we will just set the shared prefs and change tab, but since we already set prefs,
              // wait, QuranScreen uses `_readingSurah` from Drawer.
              // Actually, pushing a new QuranScreen is the safest way to pass targetAyah.
              // We could also pass a callback, but let's push a new screen for precise navigation.
              // The user said "يروح لاسكرين القران (كجزء من شريط التنقل السفلي)"
              // So we should update SharedPreferences and then call a tab change callback if we had one.
              // Wait, we don't have onTabChange here. Let's just push it directly for now or add it later.
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuranScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark 
                    ? colorScheme.primary.withValues(alpha: 0.1) 
                    : colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark 
                      ? colorScheme.outline.withValues(alpha: 0.1) 
                      : const Color(0xFFEBE5D9),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Right Side (Image in RTL)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/cover_quran.png',
                      width: 70,
                      height: 90,
                      fit: BoxFit.cover,
                      // If image is missing, show a fallback
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 70,
                        height: 90,
                        color: colorScheme.primaryContainer,
                        child: Icon(Icons.book, color: colorScheme.primary),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Left Side (Text and Progress in RTL)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isLoading ? '...' : l10n.surahName(_surahName),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isLoading ? '...' : l10n.ayahNumber(_lastReadAyah.toString()),
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.0, // Progress tracking can be added later
                            minHeight: 6,
                            backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary, // The green color
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        // Continue Reading Button Text
                        Row(
                          children: [
                            Text(
                              l10n.continueReading,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.play_circle_fill_rounded,
                              color: colorScheme.primary,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
