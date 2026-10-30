import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../core/utils/app_logger.dart';
import '../../data/models/quran_models.dart';
import '../../data/quran_meta.dart';
import '../../data/reader_settings.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/surah_loader.dart';
import '../widgets/ayah_chunk_widget.dart';

/// One row of the virtual Mushaf (≈ 800 light rows for the whole Quran).
class _Row {
  final int surah;
  final int startAyah; // 0 → header row
  final int endAyah;
  const _Row.header(this.surah)
      : startAyah = 0,
        endAyah = 0;
  const _Row.chunk(this.surah, this.startAyah, this.endAyah);
  bool get isHeader => startAyah == 0;
}

final List<_Row> _rows = () {
  final rows = <_Row>[];
  for (var s = 1; s <= 114; s++) {
    rows.add(_Row.header(s));
    final n = QuranMeta.ayahCount(s);
    for (var a = 1; a <= n; a += kAyahsPerChunk) {
      rows.add(_Row.chunk(s, a, (a + kAyahsPerChunk - 1).clamp(1, n)));
    }
  }
  return rows;
}();

/// Row index of the first row of each surah (O(1) lookups).
final List<int> _headerIndex = () {
  final idx = List<int>.filled(115, 0);
  for (var i = 0; i < _rows.length; i++) {
    if (_rows[i].isHeader) idx[_rows[i].surah] = i;
  }
  return idx;
}();

int _rowIndexFor(int surah, [int? ayah]) {
  final s = surah.clamp(1, 114);
  final i = _headerIndex[s];
  if (ayah == null || ayah <= 1) return i;
  final a = ayah.clamp(1, QuranMeta.ayahCount(s));
  return i + 1 + (a - 1) ~/ kAyahsPerChunk;
}

class QuranReadingWidget extends StatefulWidget {
  final int initialSurah;
  final int? initialAyah;
  final double initialAlignment; // kept for API compatibility
  /// Change this value to force a jump even when surah/ayah are unchanged.
  final int requestId;
  final Function(SurahMetaModel?) onVisibleSurahChanged;

  const QuranReadingWidget({
    super.key,
    required this.initialSurah,
    this.initialAyah,
    this.initialAlignment = 0.0,
    this.requestId = 0,
    required this.onVisibleSurahChanged,
  });

  @override
  State<QuranReadingWidget> createState() => _QuranReadingWidgetState();
}

class _QuranReadingWidgetState extends State<QuranReadingWidget> {
  final QuranRepository _repository = QuranRepository();
  late final SurahLoader _loader = SurahLoader(_repository);
  final ItemScrollController _scroll = ItemScrollController();
  final ItemPositionsListener _positions = ItemPositionsListener.create();

  late final int _startIndex;
  int _currentSurah = 1;
  int _currentAyah = 1;
  int _lastNotifiedSurah = 0;
  Timer? _saveTimer;
  int? _highlightAyah;

  @override
  void initState() {
    super.initState();
    ReaderSettings.load();
    _currentSurah = widget.initialSurah.clamp(1, 114);
    _currentAyah = widget.initialAyah ?? 1;
    _highlightAyah = widget.initialAyah;
    _startIndex = _rowIndexFor(widget.initialSurah, widget.initialAyah);
    _positions.itemPositions.addListener(_onPositions);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySurah());
  }

  @override
  void didUpdateWidget(QuranReadingWidget old) {
    super.didUpdateWidget(old);
    if (old.initialSurah != widget.initialSurah ||
        old.initialAyah != widget.initialAyah ||
        old.requestId != widget.requestId) {
      _currentSurah = widget.initialSurah.clamp(1, 114);
      _currentAyah = widget.initialAyah ?? 1;
      setState(() => _highlightAyah = widget.initialAyah);
      if (_scroll.isAttached) {
        _scroll.jumpTo(index: _rowIndexFor(widget.initialSurah, widget.initialAyah));
      }
      _notifySurah();
    }
  }

  @override
  void dispose() {
    _positions.itemPositions.removeListener(_onPositions);
    _saveTimer?.cancel();
    _persistNow(); // flush last position
    super.dispose();
  }

  void _notifySurah() {
    if (!mounted || _lastNotifiedSurah == _currentSurah) return;
    _lastNotifiedSurah = _currentSurah;
    widget.onVisibleSurahChanged(_repository.getSurahMeta(_currentSurah));
  }

  void _onPositions() {
    final pos = _positions.itemPositions.value;
    if (pos.isEmpty) return;
    ItemPosition? top;
    for (final p in pos) {
      if (p.itemTrailingEdge > 0.05 && (top == null || p.index < top.index)) top = p;
    }
    if (top == null) return;
    final row = _rows[top.index.clamp(0, _rows.length - 1)];
    _currentAyah = row.isHeader ? 1 : row.startAyah;
    if (row.surah != _currentSurah) {
      _currentSurah = row.surah;
      _notifySurah();
    }
    _scheduleSave();
  }

  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 900), _persistNow);
  }

  Future<void> _persistNow() async {
    try {
      await _repository.saveLastRead(_currentSurah, _currentAyah);
    } catch (e, s) {
      AppLogger.e('QuranReader', e, s, 'save position');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: _rows.length,
      itemScrollController: _scroll,
      itemPositionsListener: _positions,
      initialScrollIndex: _startIndex,
      padding: const EdgeInsets.only(bottom: 48),
      itemBuilder: (context, index) {
        final r = _rows[index];
        if (r.isHeader) {
          return SurahHeaderItem(key: ValueKey('h${r.surah}'), surahNumber: r.surah, loader: _loader);
        }
        return AyahChunkItem(
          key: ValueKey('c${r.surah}_${r.startAyah}'),
          surahNumber: r.surah,
          startAyah: r.startAyah,
          endAyah: r.endAyah,
          loader: _loader,
          highlightAyah: (r.surah == widget.initialSurah) ? _highlightAyah : null,
        );
      },
    );
  }
}
