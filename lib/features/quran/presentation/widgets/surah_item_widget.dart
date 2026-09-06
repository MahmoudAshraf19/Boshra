import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import 'tafsir_bottom_sheet.dart';
import 'recitation_bottom_sheet.dart';
import 'ayah_share_widget.dart';

class SurahItemWidget extends StatefulWidget {
  final int surahNumber;
  final int? targetAyahToScroll;
  final QuranRepository repository;
  final ThemeData theme;
  final bool isDark;
  final AppLocalizations l10n;
  final String locale;

  const SurahItemWidget({
    super.key,
    required this.surahNumber,
    this.targetAyahToScroll,
    required this.repository,
    required this.theme,
    required this.isDark,
    required this.l10n,
    required this.locale,
  });

  @override
  State<SurahItemWidget> createState() => _SurahItemWidgetState();
}

class _SurahItemWidgetState extends State<SurahItemWidget> with AutomaticKeepAliveClientMixin {
  SurahModel? _surah;
  bool _isLoading = true;
  final List<TapGestureRecognizer> _recognizers = [];
  int? _selectedAyahNumber;
  final GlobalKey _targetAyahKey = GlobalKey();

  @override
  bool get wantKeepAlive => true; // Keep the loaded Surah in memory to avoid flashing when scrolling back

  @override
  void initState() {
    super.initState();
    _loadSurah();
  }

  Future<void> _loadSurah() async {
    final surah = await widget.repository.getSurah(widget.surahNumber, useUthmani: true);
    if (mounted) {
      setState(() {
        _surah = surah;
        _isLoading = false;
        
        _recognizers.clear();
        if (surah != null) {
          for (final ayah in surah.ayahs) {
            _recognizers.add(TapGestureRecognizer()..onTap = () {
              _showAyahOptionsBottomSheet(context, ayah, surah);
            });
          }
        }
      });
      
      if (widget.targetAyahToScroll != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _targetAyahKey.currentContext != null) {
            Scrollable.ensureVisible(
              _targetAyahKey.currentContext!,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              alignment: 0.1,
            );
          }
        });
      }
    }
  }

  @override
  void didUpdateWidget(SurahItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetAyahToScroll != widget.targetAyahToScroll && widget.targetAyahToScroll != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _targetAyahKey.currentContext != null) {
          Scrollable.ensureVisible(
            _targetAyahKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            alignment: 0.1,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    if (_isLoading) {
      return Container(
        height: 200, // Approximate height to prevent huge scroll jumps
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: widget.theme.colorScheme.primary),
      );
    }

    if (_surah == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Surah Banner
          _buildSurahBanner(_surah!.name, widget.theme, widget.isDark),
          
          const SizedBox(height: 24),
          
          // Bismillah (except for Surah 9 or if it's Fatiha where Bismillah is Ayah 1)
          if (_surah!.number != 1 && _surah!.number != 9)
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AmiriQuran',
                  fontSize: 24,
                  color: widget.theme.colorScheme.onSurface,
                ),
              ),
            ),
            
          // Mushaf Arabic Text Block
          Directionality(
            textDirection: TextDirection.rtl,
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: _surah!.ayahs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final ayah = entry.value;
                  // Remove Bismillah from the first Ayah if it's not Al-Fatiha
                  String text = ayah.text;
                  if (_surah!.number != 1 && ayah.numberInSurah == 1) {
                    text = text.replaceFirst('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ ', '');
                  }
                  
                  final isSelected = _selectedAyahNumber == ayah.numberInSurah;
                  final highlightColor = widget.theme.colorScheme.primary.withValues(alpha: 0.2);
                  
                  return TextSpan(
                    children: [
                      TextSpan(
                        text: '$text ',
                        style: TextStyle(
                          fontFamily: 'AmiriQuran',
                          fontSize: 28, // Large readable font
                          height: 1.8,
                          color: widget.theme.colorScheme.onSurface,
                          backgroundColor: isSelected ? highlightColor : Colors.transparent,
                        ),
                        recognizer: _recognizers[index],
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          key: (widget.targetAyahToScroll != null && ayah.numberInSurah == widget.targetAyahToScroll) ? _targetAyahKey : null,
                          onTap: () {
                            _showAyahOptionsBottomSheet(context, ayah, _surah!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? highlightColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: _buildAyahEndMarker(ayah.numberInSurah, widget.theme),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' '),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahBanner(String arabicName, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          arabicName,
          style: TextStyle(
            fontFamily: 'AmiriQuran',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildAyahEndMarker(int number, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFDDA15E),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'IBMPlexSansArabic',
            color: Color(0xFFDDA15E),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showAyahOptionsBottomSheet(BuildContext context, AyahModel ayah, SurahModel surah) async {
    if (mounted) {
      setState(() {
        _selectedAyahNumber = ayah.numberInSurah;
      });
    }

    await showModalBottomSheet(
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
              Text(
                '${surah.name} - ${widget.l10n.ayahNumber(ayah.numberInSurah.toString())}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildBottomSheetOption(Icons.bookmark_add, widget.l10n.saveBookmark, widget.theme.colorScheme, () async {
                Navigator.pop(context);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('last_read_surah', surah.number);
                await prefs.setInt('last_read_ayah', ayah.numberInSurah);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(widget.l10n.bookmarkSavedSuccessfully(surah.name, ayah.numberInSurah.toString())),
                      backgroundColor: widget.theme.colorScheme.primary,
                    ),
                  );
                }
              }),
              _buildBottomSheetOption(Icons.menu_book, widget.l10n.tafsirOption, widget.theme.colorScheme, () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => TafsirBottomSheet(
                    ayah: ayah,
                    surah: surah,
                    locale: widget.locale,
                  ),
                );
              }),
              _buildBottomSheetOption(Icons.headset, widget.l10n.recitationOption, widget.theme.colorScheme, () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => RecitationBottomSheet(
                    initialAyah: ayah,
                    surah: surah,
                    locale: widget.locale,
                  ),
                );
              }),
              _buildBottomSheetOption(Icons.share, widget.l10n.shareOption, widget.theme.colorScheme, () async {
                final parentContext = this.context;
                Navigator.pop(context);
                
                // Show a brief loading dialog
                showDialog(
                  context: parentContext,
                  barrierDismissible: false,
                  builder: (dialogCtx) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  final screenshotController = ScreenshotController();
                  final Uint8List? imageBytes = await screenshotController.captureFromWidget(
                    MediaQuery(
                      data: const MediaQueryData(size: Size(1080, 1350)),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: AyahShareWidget(
                          ayah: ayah,
                          surah: surah,
                        ),
                      ),
                    ),
                    delay: const Duration(milliseconds: 100),
                    targetSize: const Size(1080, 1350),
                  );

                  // Hide loading
                  if (mounted) Navigator.pop(parentContext);

                  if (imageBytes != null) {
                    final directory = await getTemporaryDirectory();
                    final imagePath = '${directory.path}/ayah_share.png';
                    final file = File(imagePath);
                    await file.writeAsBytes(imageBytes);
                    
                    await Share.shareXFiles(
                      [XFile(imagePath)],
                      text: '${ayah.text}\n[${surah.name} : ${ayah.numberInSurah}]',
                    );
                  }
                } catch (e) {
                  if (mounted) Navigator.pop(parentContext);
                  print("Error capturing image: $e");
                }
              }),
              _buildBottomSheetOption(Icons.copy, widget.l10n.copyOption, widget.theme.colorScheme, () {
                Navigator.pop(context);
                final ayahText = '${ayah.text} ﴿${ayah.numberInSurah}﴾';
                Clipboard.setData(ClipboardData(text: ayahText)).then((_) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(widget.l10n.copiedSuccessfully),
                        backgroundColor: widget.theme.colorScheme.primary,
                      ),
                    );
                  }
                });
              }),
              _buildBottomSheetOption(Icons.share, widget.l10n.shareOption, widget.theme.colorScheme, () {
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );

    if (mounted) {
      setState(() {
        _selectedAyahNumber = null;
      });
    }
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
}
