import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import '../../../../core/services/storage_service.dart';
import '../widgets/quran_drawer.dart';
import 'quran_reading_screen.dart';
import '../widgets/surah_tafsir_bottom_sheet.dart';
import '../widgets/surah_recitation_bottom_sheet.dart';
import '../widgets/surah_info_bottom_sheet.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int? _lastReadSurah;
  double? _lastReadAlignment;
  int? _readingSurah;
  double? _readingAlignment;
  int? _targetAyah;
  SurahMetaModel? _currentSurahMeta;
  
  @override
  void initState() {
    super.initState();
    _loadLastReadSurah();
  }
  
  Future<void> _loadLastReadSurah() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastReadSurah = prefs.getInt('last_read_surah');
      _lastReadAlignment = prefs.getDouble('last_read_alignment') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    final locale = Localizations.localeOf(context).languageCode;
    String appBarTitle = l10n.quranScreenTitle;
    String appBarSubtitle = '';
    
    if (_readingSurah != null && _currentSurahMeta != null) {
      appBarTitle = _currentSurahMeta!.name;
      final revelation = _currentSurahMeta!.revelationType == 'Meccan' ? l10n.meccan : l10n.medinan;
      final ayahsText = l10n.ayahsCount(_currentSurahMeta!.numberOfAyahs);
      appBarSubtitle = '$revelation - $ayahsText';
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: QuranDrawer(
        selectedSurah: _currentSurahMeta?.number ?? _readingSurah ?? 1,
        onSurahSelected: (int surahNumber, {int? ayahNumber}) {
          setState(() {
            _readingSurah = surahNumber;
            _readingAlignment = 0.0;
            _targetAyah = ayahNumber;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: colorScheme.onSurface),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          children: [
            Text(
              appBarTitle,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (appBarSubtitle.isNotEmpty)
              Text(
                appBarSubtitle,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        actions: [
          if (_readingSurah != null)
            IconButton(
              icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
              onPressed: () {
                _showMoreOptionsBottomSheet(context, l10n, colorScheme);
              },
            ),
        ],
      ),
      body: _readingSurah != null
          ? QuranReadingWidget(
              initialSurah: _readingSurah!,
              initialAyah: _targetAyah,
              initialAlignment: _readingAlignment ?? 0.0,
              onVisibleSurahChanged: (meta) {
                if (meta != null && (_currentSurahMeta == null || _currentSurahMeta!.number != meta.number)) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _currentSurahMeta = meta;
                      });
                    }
                  });
                }
              },
            )
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Main Image
              Image.asset(
                'assets/images/background_quranScreen.png',
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Return an elegant placeholder or empty space if image is missing
                  return Icon(
                    Icons.menu_book,
                    size: MediaQuery.of(context).size.width * 0.4,
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  );
                },
              ),
              const SizedBox(height: 32),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  l10n.startQuranJourney,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  l10n.openSurahAndRead,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                  children: [
                    if (_lastReadSurah != null) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _readingSurah = _lastReadSurah;
                              _readingAlignment = _lastReadAlignment;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDDA15E),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                locale == 'ar' ? 'متابعة القراءة' : 'Continue Reading',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.menu_book, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _lastReadSurah != null 
                                ? Colors.transparent 
                                : (isDark ? colorScheme.primaryContainer : const Color(0xFF354823)),
                            foregroundColor: _lastReadSurah != null ? colorScheme.primary : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: _lastReadSurah != null 
                                  ? BorderSide(color: colorScheme.primary, width: 2)
                                  : BorderSide.none,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.browseSurahs,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.adaptive.arrow_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBottomSheetOption(IconData icon, String title, ColorScheme colorScheme, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _showMoreOptionsBottomSheet(BuildContext context, AppLocalizations l10n, ColorScheme colorScheme) async {
    if (_currentSurahMeta == null) return;
    
    // Check if the current Surah is downloaded
    final repository = QuranRepository();
    final downloadedSurahs = await repository.getDownloadedSurahs();
    final isDownloaded = downloadedSurahs.contains(_currentSurahMeta!.number);
    
    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetOption(Icons.menu_book, l10n.tafsirOption, colorScheme, () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SurahTafsirBottomSheet(
                    surahNumber: _currentSurahMeta!.number,
                    surahName: _currentSurahMeta!.name,
                    locale: Localizations.localeOf(context).languageCode,
                  ),
                );
              }),
              _buildBottomSheetOption(Icons.headset, l10n.recitationOption, colorScheme, () async {
                Navigator.pop(context);
                if (_currentSurahMeta != null) {
                  // Show loading while fetching the full SurahModel
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogCtx) => const Center(child: CircularProgressIndicator()),
                  );
                  
                  try {
                    final repository = QuranRepository();
                    final surah = await repository.getSurah(_currentSurahMeta!.number, useUthmani: true);
                    
                    if (context.mounted) Navigator.pop(context); // Hide loading
                    
                    if (surah != null && context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => SurahRecitationBottomSheet(
                          surah: surah,
                          locale: Localizations.localeOf(context).languageCode,
                        ),
                      );
                    } else if (surah == null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to load recitation data')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) Navigator.pop(context); // Hide loading on error
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('An error occurred. Please check your internet connection.')),
                      );
                    }
                  }
                }
              }),
              _buildBottomSheetOption(
                isDownloaded ? Icons.download_done_rounded : Icons.download_rounded, 
                isDownloaded ? l10n.downloadedOption : l10n.downloadOption, 
                colorScheme, 
                () async {
                  Navigator.pop(context);
                  if (isDownloaded) return; // Already downloaded, do nothing or show message

                  // Check Storage Space
                  final storageService = StorageService();
                  if (!(await storageService.hasEnoughSpace(100 * 1024))) { // Estimate 100KB for text
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.notEnoughSpace),
                          backgroundColor: colorScheme.error,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                    return;
                  }

                  // Download the Surah
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'جاري التحميل...' : 'Downloading...')),
                  );
                  
                  try {
                    await repository.getSurah(_currentSurahMeta!.number, useUthmani: true, saveToCache: true);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'تم التحميل بنجاح!' : 'Downloaded successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to download Surah.'), backgroundColor: colorScheme.error),
                      );
                    }
                  }
                },
              ),

              _buildBottomSheetOption(Icons.info_outline, l10n.infoOption, colorScheme, () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SurahInfoBottomSheet(
                    surahMeta: _currentSurahMeta!,
                    locale: Localizations.localeOf(context).languageCode,
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
