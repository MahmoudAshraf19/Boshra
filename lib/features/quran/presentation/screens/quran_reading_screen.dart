import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import '../widgets/surah_item_widget.dart';

class QuranReadingWidget extends StatefulWidget {
  final int initialSurah;
  final int? initialAyah;
  final double initialAlignment;
  final Function(SurahMetaModel?) onVisibleSurahChanged;

  const QuranReadingWidget({
    super.key, 
    required this.initialSurah, 
    this.initialAyah,
    this.initialAlignment = 0.0,
    required this.onVisibleSurahChanged,
  });

  @override
  State<QuranReadingWidget> createState() => _QuranReadingWidgetState();
}

class _QuranReadingWidgetState extends State<QuranReadingWidget> {
  final QuranRepository _repository = QuranRepository();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  
  int _currentSurahIndex = 1; 
  QuranMetaModel? _metaData;

  @override
  void initState() {
    super.initState();
    _currentSurahIndex = widget.initialSurah;
    _initializeData();
    
    _itemPositionsListener.itemPositions.addListener(_onItemPositionsChanged);
    
    // Jump to the selected Surah immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_itemScrollController.isAttached) {
        _itemScrollController.jumpTo(
          index: widget.initialSurah - 1, 
          alignment: widget.initialAlignment,
        );
      }
    });
  }
  
  @override
  void didUpdateWidget(QuranReadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSurah != widget.initialSurah || oldWidget.initialAyah != widget.initialAyah) {
      _currentSurahIndex = widget.initialSurah;
      if (_itemScrollController.isAttached) {
        _itemScrollController.jumpTo(
          index: widget.initialSurah - 1, 
          alignment: widget.initialAlignment,
        );
      }
    }
  }

  Future<void> _initializeData() async {
    _saveLastReadSurah(_currentSurahIndex, widget.initialAlignment);
    _metaData = await _repository.getQuranMetadata();

    if (_metaData != null && _metaData!.surahs.isNotEmpty) {
      final index = _currentSurahIndex - 1;
      if (index >= 0 && index < _metaData!.surahs.length) {
        widget.onVisibleSurahChanged(_metaData!.surahs[index]);
      }
    }
    
    if (mounted) setState(() {}); // re-render to pass metaData if needed (though not strictly necessary)
  }

  void _onItemPositionsChanged() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      // Find the item that occupies the top half of the screen
      int? visibleIndex;
      double minLeadingEdge = double.infinity;
      
      for (final position in positions) {
        // We consider an item "visible" as the main one if its leading edge is closest to 0
        // or if it covers the 0 point (leading < 0 and trailing > 0)
        if (position.itemTrailingEdge > 0.1) { // It has to be somewhat visible on screen
           if (position.itemLeadingEdge < minLeadingEdge && position.itemLeadingEdge < 0.5) {
             minLeadingEdge = position.itemLeadingEdge;
             visibleIndex = position.index;
           }
        }
      }
      
      if (visibleIndex != null) {
        final surahNumber = visibleIndex + 1;
        
        // Find exact alignment (itemLeadingEdge) of the visible item
        final position = positions.firstWhere((p) => p.index == visibleIndex);
        
        if (_currentSurahIndex != surahNumber) {
           _currentSurahIndex = surahNumber;
           
           if (_metaData != null && _metaData!.surahs.isNotEmpty) {
             widget.onVisibleSurahChanged(_metaData!.surahs[visibleIndex]);
           }
        }
        
        // Save the surah AND the exact scroll percentage
        _saveLastReadSurah(surahNumber, position.itemLeadingEdge);
      }
    }
  }

  Future<void> _saveLastReadSurah(int surahNumber, double alignment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_surah', surahNumber);
    await prefs.setDouble('last_read_alignment', alignment);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).languageCode;

    return ScrollablePositionedList.builder(
      itemCount: 114,
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      initialScrollIndex: widget.initialSurah - 1,
      itemBuilder: (context, index) {
        final surahNumber = index + 1;
        return SurahItemWidget(
          surahNumber: surahNumber,
          targetAyahToScroll: surahNumber == widget.initialSurah ? widget.initialAyah : null,
          repository: _repository,
          theme: theme,
          isDark: isDark,
          l10n: l10n,
          locale: locale,
        );
      },
    );
  }
}
