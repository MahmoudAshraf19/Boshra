import 'package:flutter/material.dart';
import '../../../../core/services/tafsir_api_service.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/models/quran_models.dart';
import '../../../../l10n/app_localizations.dart';

class SurahTafsirBottomSheet extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final String locale;

  const SurahTafsirBottomSheet({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.locale,
  });

  @override
  State<SurahTafsirBottomSheet> createState() => _SurahTafsirBottomSheetState();
}

class _SurahTafsirBottomSheetState extends State<SurahTafsirBottomSheet> {
  final TafsirApiService _tafsirApiService = TafsirApiService();
  final QuranRepository _quranRepository = QuranRepository();
  
  bool _isLoading = true;
  SurahModel? _surahModel;
  List<String>? _tafsirs;
  String _errorMessage = '';
  
  late List<Map<String, String>> _availableTafsirs;
  int _selectedTafsirIndex = 0;

  @override
  void initState() {
    super.initState();
    _availableTafsirs = _getTafsirsForLocale(widget.locale);
    _loadSurahAndTafsir();
  }

  List<Map<String, String>> _getTafsirsForLocale(String locale) {
    switch (locale) {
      case 'ar':
        return [
          {'key': 'ar.muyassar', 'name': 'التفسير الميسر'},
          {'key': 'ar.jalalayn', 'name': 'تفسير الجلالين'},
          {'key': 'ar.qurtubi', 'name': 'تفسير القرطبي'},
        ];
      case 'en':
        return [
          {'key': 'en.sahih', 'name': 'Saheeh Intl'},
          {'key': 'en.maududi', 'name': 'Maududi'},
          {'key': 'en.yusufali', 'name': 'Yusuf Ali'},
        ];
      case 'ur':
        return [
          {'key': 'ur.maududi', 'name': 'Maududi'},
          {'key': 'ur.jalandhry', 'name': 'Jalandhry'},
        ];
      case 'fr':
        return [
          {'key': 'fr.hamidullah', 'name': 'Hamidullah'},
        ];
      case 'fa':
        return [
          {'key': 'fa.makarem', 'name': 'Makarem'},
          {'key': 'fa.ansarian', 'name': 'Ansarian'},
        ];
      default:
        return [
          {'key': 'en.sahih', 'name': 'Saheeh Intl'},
        ];
    }
  }

  Future<void> _loadSurahAndTafsir() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    try {
      final selectedTafsirKey = _availableTafsirs[_selectedTafsirIndex]['key']!;
      final surah = await _quranRepository.getSurah(widget.surahNumber, useUthmani: true);
      final tafsirs = await _tafsirApiService.getSurahTafsir(widget.surahNumber, selectedTafsirKey);
      
      if (mounted) {
        if (surah != null && tafsirs != null && surah.ayahs.length == tafsirs.length) {
          setState(() {
            _surahModel = surah;
            _tafsirs = tafsirs;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Failed to load Tafsir correctly.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'An error occurred: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final selectedTafsirName = _availableTafsirs[_selectedTafsirIndex]['name']!;

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      '${l10n.tafsirOption} - ${widget.surahName}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontFamily: 'AmiriQuran',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Tafsir Selection Chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _availableTafsirs.length,
                        itemBuilder: (context, index) {
                          final tafsir = _availableTafsirs[index];
                          final isSelected = index == _selectedTafsirIndex;
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(tafsir['name']!),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected && !isSelected) {
                                  setState(() {
                                    _selectedTafsirIndex = index;
                                  });
                                  _loadSurahAndTafsir();
                                }
                              },
                              selectedColor: theme.colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage, style: TextStyle(color: colorScheme.error)))
                        : ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.all(24),
                            itemCount: _surahModel!.ayahs.length,
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Divider(color: colorScheme.primary.withValues(alpha: 0.2)),
                            ),
                            itemBuilder: (context, index) {
                              final ayah = _surahModel!.ayahs[index];
                              final tafsir = _tafsirs![index];
                              
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Ayah Text
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
                                    ),
                                    child: Text(
                                      '${ayah.text} ﴿${ayah.numberInSurah}﴾',
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontFamily: 'AmiriQuran',
                                        fontSize: 26,
                                        height: 1.8,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Tafsir Text
                                  Text(
                                    tafsir,
                                    textAlign: TextAlign.justify,
                                    textDirection: widget.locale == 'ar' || widget.locale == 'ur' || widget.locale == 'fa'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexSansArabic',
                                      fontSize: 18,
                                      height: 1.6,
                                      color: colorScheme.onSurface.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
