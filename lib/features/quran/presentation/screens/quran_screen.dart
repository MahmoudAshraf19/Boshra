import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/reader_settings.dart';
import 'quran_downloads_screen.dart';
import '../widgets/quran_drawer.dart';
import 'quran_reading_screen.dart';
import '../widgets/surah_tafsir_bottom_sheet.dart';
import '../widgets/surah_recitation_bottom_sheet.dart';
import '../widgets/surah_info_bottom_sheet.dart';
import '../../../../core/error/error_handler.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int? _lastReadSurah;
  int? _lastReadAyah;
  double? _lastReadAlignment;
  int? _readingSurah;
  double? _readingAlignment;
  int? _targetAyah;
  int _navRequest = 0;
  (int, int)? _bookmark;
  SurahMetaModel? _currentSurahMeta;
  
  @override
  void initState() {
    super.initState();
    _loadLastReadSurah();
  }
  
  Future<void> _loadLastReadSurah() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final bm = await QuranRepository().getBookmark();
    if (!mounted) return;
    setState(() {
      _bookmark = bm;
      _lastReadSurah = prefs.getInt('last_read_surah');
      _lastReadAyah = prefs.getInt('last_read_ayah');
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
            _navRequest++;
          });
        },
        onOpenDownloads: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const QuranDownloadsScreen())),
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
              requestId: _navRequest,
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
                              _targetAyah = _lastReadAyah;
                              _readingAlignment = _lastReadAlignment;
                              _navRequest++;
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
                                l10n.continueReadingBtn,
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
                    if (_bookmark != null) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.bookmark),
                          label: Text(locale == 'ar' ? 'العلامة المرجعية' : 'Bookmark'),
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          onPressed: () => setState(() {
                            _readingSurah = _bookmark!.$1;
                            _targetAyah = _bookmark!.$2;
                            _readingAlignment = 0.0;
                            _navRequest++;
                          }),
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

  Future<void> _showMoreOptionsBottomSheet(
      BuildContext hostContext, AppLocalizations l10n, ColorScheme colorScheme) async {
    final meta = _currentSurahMeta;
    if (meta == null) return;
    final repository = QuranRepository();
    final locale = Localizations.localeOf(hostContext).languageCode;

    // IMPORTANT: every follow-up action uses [hostContext] (this screen), never the
    // bottom-sheet context — that one is already unmounted after Navigator.pop, which
    // left the old "loading" dialog open forever (the "stuck" Quran screen).
    Widget option(BuildContext sheetCtx, IconData icon, String title, Future<void> Function() run) {
      return _buildBottomSheetOption(icon, title, colorScheme, () async {
        Navigator.pop(sheetCtx);
        if (!hostContext.mounted) return;
        await run();
      });
    }

    await showModalBottomSheet<void>(
      context: hostContext,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetCtx) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          option(sheetCtx, Icons.menu_book, l10n.tafsirOption, () async {
            await showModalBottomSheet<void>(
              context: hostContext,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              builder: (_) => SurahTafsirBottomSheet(
                  surahNumber: meta.number, surahName: meta.name, locale: locale),
            );
          }),
          option(sheetCtx, Icons.headset, l10n.recitationOption, () async {
            final surah = repository.getSurahSync(meta.number);
            await showModalBottomSheet<void>(
              context: hostContext,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              builder: (_) => SurahRecitationBottomSheet(surah: surah, locale: locale),
            );
          }),
          option(sheetCtx, Icons.download_for_offline_rounded,
              locale == 'ar' ? 'التلاوات والتحميل' : 'Audio & Downloads', () async {
            await Navigator.of(hostContext).push(
                MaterialPageRoute(builder: (_) => const QuranDownloadsScreen()));
          }),
          option(sheetCtx, Icons.text_fields, locale == 'ar' ? 'حجم الخط' : 'Font size', () async {
            await showModalBottomSheet<void>(
              context: hostContext,
              builder: (_) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ValueListenableBuilder<double>(
                    valueListenable: ReaderSettings.fontSize,
                    builder: (_, v, __) => Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(locale == 'ar' ? 'حجم الخط' : 'Font size',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Slider(
                        value: v,
                        min: ReaderSettings.minFont,
                        max: ReaderSettings.maxFont,
                        divisions: 11,
                        label: v.round().toString(),
                        onChanged: ReaderSettings.setFontSize,
                      ),
                    ]),
                  ),
                ),
              ),
            );
          }),
          option(sheetCtx, Icons.info_outline, l10n.infoOption, () async {
            await showModalBottomSheet<void>(
              context: hostContext,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              builder: (_) => SurahInfoBottomSheet(surahMeta: meta, locale: locale),
            );
          }),
        ]),
      ),
    );
  }
}
