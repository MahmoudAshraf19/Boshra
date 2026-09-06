import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';

class TafsirEdition {
  final String key;
  final String name;
  final bool isUmmahApi;

  TafsirEdition({required this.key, required this.name, required this.isUmmahApi});
}

class TafsirBottomSheet extends StatefulWidget {
  final AyahModel ayah;
  final SurahModel surah;
  final String locale;

  const TafsirBottomSheet({
    super.key,
    required this.ayah,
    required this.surah,
    required this.locale,
  });

  @override
  State<TafsirBottomSheet> createState() => _TafsirBottomSheetState();
}

class _TafsirBottomSheetState extends State<TafsirBottomSheet> {
  final QuranRepository _repository = QuranRepository();
  late List<TafsirEdition> _availableTafsirs;
  int _selectedTafsirIndex = 0;
  String? _tafsirText;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _availableTafsirs = _getTafsirsForLocale(widget.locale);
    _loadTafsir();
  }

  List<TafsirEdition> _getTafsirsForLocale(String locale) {
    switch (locale) {
      case 'ar':
        return [
          TafsirEdition(key: 'muyassar', name: 'تفسير الميسر', isUmmahApi: true),
          TafsirEdition(key: 'ibn_kathir_ar', name: 'ابن كثير', isUmmahApi: true),
          TafsirEdition(key: 'ar.jalalayn', name: 'الجلالين', isUmmahApi: false),
        ];
      case 'en':
        return [
          TafsirEdition(key: 'ibn_kathir', name: 'Ibn Kathir', isUmmahApi: true),
          TafsirEdition(key: 'maarif', name: 'Maarif ul Quran', isUmmahApi: true),
          TafsirEdition(key: 'en.sahih', name: 'Saheeh Intl', isUmmahApi: false),
        ];
      case 'ur':
        return [
          TafsirEdition(key: 'ur.maududi', name: 'Maududi', isUmmahApi: false),
          TafsirEdition(key: 'ur.jalandhry', name: 'Jalandhry', isUmmahApi: false),
        ];
      case 'fr':
        return [
          TafsirEdition(key: 'fr.hamidullah', name: 'Hamidullah', isUmmahApi: false),
        ];
      case 'fa':
        return [
          TafsirEdition(key: 'fa.makarem', name: 'Makarem', isUmmahApi: false),
          TafsirEdition(key: 'fa.ansarian', name: 'Ansarian', isUmmahApi: false),
        ];
      case 'hi':
        return [
          TafsirEdition(key: 'hi.farooq', name: 'Farooq Khan', isUmmahApi: false),
        ];
      case 'es':
        return [
          TafsirEdition(key: 'es.cortes', name: 'Julio Cortes', isUmmahApi: false),
        ];
      case 'it':
        return [
          TafsirEdition(key: 'it.piccardo', name: 'Piccardo', isUmmahApi: false),
        ];
      default:
        return [
          TafsirEdition(key: 'en.asad', name: 'Asad Translation', isUmmahApi: false),
        ];
    }
  }

  Future<void> _loadTafsir() async {
    setState(() {
      _isLoading = true;
      _tafsirText = null;
    });

    final selected = _availableTafsirs[_selectedTafsirIndex];
    final text = await _repository.getAyahTafsir(
      widget.surah.number,
      widget.ayah.numberInSurah,
      selected.key,
      selected.isUmmahApi,
    );

    if (mounted) {
      setState(() {
        _tafsirText = text;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              
              // Header title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.tafsirOption,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              
              // Tafsir Selection Chips
              SizedBox(
                height: 50,
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
                        label: Text(tafsir.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected && !isSelected) {
                            setState(() {
                              _selectedTafsirIndex = index;
                            });
                            _loadTafsir();
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
              
              const Divider(),
              
              // Scrollable Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Original Ayah
                    Text(
                      '${widget.ayah.text} ﴿${widget.ayah.numberInSurah}﴾',
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 26,
                        height: 1.8,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Selected Tafsir Name
                    Text(
                      _availableTafsirs[_selectedTafsirIndex].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tafsir Content or Loader
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_tafsirText == null)
                      Center(
                        child: Text(
                          'عذراً، التفسير غير متوفر حالياً.',
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      )
                    else
                      Text(
                        _tafsirText!,
                        textAlign: TextAlign.justify,
                        textDirection: widget.locale == 'ar' || widget.locale == 'ur' || widget.locale == 'fa'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                      
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
