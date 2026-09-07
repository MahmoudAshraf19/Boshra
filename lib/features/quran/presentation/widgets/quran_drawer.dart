import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import '../../../../core/services/storage_service.dart';

class QuranDrawer extends StatefulWidget {
  final int selectedSurah;
  final void Function(int surahNumber, {int? ayahNumber}) onSurahSelected;

  const QuranDrawer({
    super.key, 
    required this.selectedSurah, 
    required this.onSurahSelected,
  });

  @override
  State<QuranDrawer> createState() => _QuranDrawerState();
}

class _QuranDrawerState extends State<QuranDrawer> {
  final QuranRepository _repository = QuranRepository();
  QuranMetaModel? _metaData;
  bool _isLoading = true;
  int _selectedTabIndex = 0; // 0: Surahs, 1: Juzs, 2: Hizbs
  String _searchQuery = '';
  Set<int> _downloadedSurahs = {};
  Set<int> _downloadingSurahs = {};
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _loadMetadata();
  }

  Future<void> _loadMetadata() async {
    final meta = await _repository.getQuranMetadata();
    final downloaded = await _repository.getDownloadedSurahs();
    
    bool isOffline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        isOffline = true;
      }
    } catch (_) {
      isOffline = true;
    }

    if (mounted) {
      setState(() {
        _metaData = meta;
        _downloadedSurahs = downloaded;
        _isOffline = isOffline;
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadSurah(int surahNumber) async {
    if (_downloadedSurahs.contains(surahNumber) || _downloadingSurahs.contains(surahNumber)) return;
    
    final storageService = StorageService();
    if (!(await storageService.hasEnoughSpace(100 * 1024))) { // Estimate 100KB for text
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.notEnoughSpace),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return;
    }

    setState(() {
      _downloadingSurahs.add(surahNumber);
    });
    
    try {
      // getSurah fetches from API if not cached, and explicitly saves it
      await _repository.getSurah(surahNumber, useUthmani: true, saveToCache: true);
      
      if (mounted) {
        setState(() {
          _downloadedSurahs.add(surahNumber);
          _downloadingSurahs.remove(surahNumber);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _downloadingSurahs.remove(surahNumber);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download Surah. Check internet connection.')),
        );
      }
    }
  }

  String removeDiacritics(String text) {
    return text.replaceAll(RegExp(r'[\u064B-\u065F]'), '');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Use surface color for drawer to respect light/dark themes
    final drawerBgColor = colorScheme.surface;
    final textColor = colorScheme.onSurface;
    final secondaryTextColor = colorScheme.onSurfaceVariant;
    final searchBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.1) 
        : Colors.black.withValues(alpha: 0.05);
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final activeTabColor = colorScheme.primary;

    return Drawer(
      backgroundColor: drawerBgColor,
      child: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: l10n.searchSurah,
                  hintStyle: TextStyle(color: secondaryTextColor),
                  prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                  filled: true,
                  fillColor: searchBgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab(l10n.tabSurahs, 0, activeTabColor, secondaryTextColor),
                  _buildTab(l10n.tabJuzs, 1, activeTabColor, secondaryTextColor),
                  _buildTab(l10n.tabHizbs, 2, activeTabColor, secondaryTextColor),
                ],
              ),
            ),
            Divider(color: dividerColor, height: 1),
            
            // Content
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: activeTabColor))
                  : _metaData == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: colorScheme.error, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                "Failed to load data",
                                style: TextStyle(color: textColor),
                              ),
                              TextButton(
                                onPressed: _loadMetadata,
                                child: const Text("Retry"),
                              )
                            ],
                          ),
                        )
                      : _buildListContent(context, l10n, textColor, secondaryTextColor, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index, Color activeColor, Color inactiveColor) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? activeColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? activeColor : inactiveColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildListContent(BuildContext context, AppLocalizations l10n, Color textColor, Color secondaryTextColor, bool isDark) {
    final colorScheme = Theme.of(context).colorScheme;
    
    if (_selectedTabIndex == 0) {
      // Surahs
      final normalizedQuery = removeDiacritics(_searchQuery.toLowerCase());
      final surahs = _metaData!.surahs.where((s) {
        if (normalizedQuery.isEmpty) return true;
        return removeDiacritics(s.name).toLowerCase().contains(normalizedQuery) ||
               removeDiacritics(s.englishName).toLowerCase().contains(normalizedQuery);
      }).toList();

      return ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          final isSelected = surah.number == widget.selectedSurah;
          final activeHighlight = isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05);
          
          final revelation = surah.revelationType == 'Meccan' ? l10n.meccan : l10n.medinan;
          final ayahsText = l10n.ayahsCount(surah.numberOfAyahs);
          
          final locale = Localizations.localeOf(context).languageCode;
          final surahTitle = locale == 'ar' ? surah.name : surah.englishName;
          final surahSubtitle = locale == 'ar' 
              ? '$revelation - $ayahsText' 
              : '${surah.englishNameTranslation} • $revelation - $ayahsText';
              
          final isDownloaded = _downloadedSurahs.contains(surah.number);
          final isClickable = !_isOffline || isDownloaded;

          return InkWell(
            onTap: isClickable ? () {
              Navigator.pop(context);
              widget.onSurahSelected(surah.number);
            } : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(locale == 'ar' ? 'هذه السورة غير متاحة بدون إنترنت، يرجى تحميلها أولاً.' : 'This Surah is not available offline. Please download it first.'),
                  backgroundColor: colorScheme.error,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              decoration: isSelected
                  ? BoxDecoration(
                      color: activeHighlight,
                      border: const Border(
                        left: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    )
                  : null,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: Row(
                      children: [
                        Text(
                          surah.number.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: isSelected ? const Color(0xFFDDA15E) : secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surahTitle,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                                Text(
                                  surahSubtitle,
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Download Indicator / Button
                          if (_downloadingSurahs.contains(surah.number))
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.primary),
                            )
                          else if (isDownloaded)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF354823), // Dark olive green as requested
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            )
                          else
                            IconButton(
                              onPressed: () => _downloadSurah(surah.number),
                              icon: Icon(Icons.download_rounded, color: secondaryTextColor, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20,
                            ),
                        ],
                      ),
                    ),
                  if (isSelected)
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      end: 0,
                      top: 16,
                      bottom: 16,
                      child: Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDA15E),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDDA15E).withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } else if (_selectedTabIndex == 1) {
      // Juzs
      final juzs = _metaData!.juzs;
      return ListView.builder(
        itemCount: juzs.length,
        itemBuilder: (context, index) {
          final juz = juzs[index];
          return ListTile(
            title: Text('${l10n.tabJuzs} ${juz.number}', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            subtitle: Text('${l10n.tabSurahs}: ${juz.surah}', style: TextStyle(color: secondaryTextColor)),
            leading: Icon(Icons.menu_book, color: const Color(0xFFDDA15E)),
            onTap: () {
              Navigator.pop(context);
              widget.onSurahSelected(juz.surah, ayahNumber: juz.ayah);
            },
          );
        },
      );
    } else {
      // Hizbs
      final hizbs = _metaData!.hizbs;
      return ListView.builder(
        itemCount: hizbs.length,
        itemBuilder: (context, index) {
          final hizb = hizbs[index];
          return ListTile(
            title: Text('${l10n.tabHizbs} ${hizb.number}', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            subtitle: Text('${l10n.tabSurahs}: ${hizb.surah}', style: TextStyle(color: secondaryTextColor)),
            leading: Icon(Icons.star_border, color: const Color(0xFFDDA15E)),
            onTap: () {
              Navigator.pop(context);
              widget.onSurahSelected(hizb.surah, ayahNumber: hizb.ayah);
            },
          );
        },
      );
    }
  }
}
