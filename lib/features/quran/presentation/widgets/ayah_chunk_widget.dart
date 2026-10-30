import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../data/models/quran_models.dart';
import '../../data/quran_text_utils.dart';
import '../../data/reader_settings.dart';
import '../../data/surah_loader.dart';
import 'ayah_actions_sheet.dart';

/// Ayahs per list row. Small chunks keep every layout pass cheap
/// (Al-Baqarah has 286 ayahs — one giant RichText used to freeze the UI).
const int kAyahsPerChunk = 10;

/// Surah title banner (+ Bismillah when applicable). Fully synchronous.
class SurahHeaderItem extends StatelessWidget {
  final int surahNumber;
  final SurahLoader loader;
  const SurahHeaderItem({super.key, required this.surahNumber, required this.loader});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final surah = loader.peek(surahNumber);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.primary, width: 2),
          ),
          child: Center(
            child: Text(surah.name,
                style: TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: cs.onPrimaryContainer)),
          ),
        ),
        if (surah.number != 1 && surah.number != 9) ...[
          const SizedBox(height: 20),
          Text('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'AmiriQuran', fontSize: 24, color: cs.onSurface)),
        ],
      ]),
    );
  }
}

/// A block of up to [kAyahsPerChunk] consecutive ayahs as Mushaf-style text.
class AyahChunkItem extends StatefulWidget {
  final int surahNumber;
  final int startAyah; // 1-based, inclusive
  final int endAyah; // inclusive
  final SurahLoader loader;
  final int? highlightAyah;
  const AyahChunkItem({
    super.key,
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
    required this.loader,
    this.highlightAyah,
  });

  @override
  State<AyahChunkItem> createState() => _AyahChunkItemState();
}

class _AyahChunkItemState extends State<AyahChunkItem> {
  late final SurahModel _surah;
  late final List<AyahModel> _ayahs;
  late final List<String> _texts;
  late final List<TapGestureRecognizer> _recognizers;
  int? _selected;
  int? _flash;
  Timer? _flashTimer;

  @override
  void initState() {
    super.initState();
    _surah = widget.loader.peek(widget.surahNumber);
    _ayahs = _surah.ayahs.sublist(widget.startAyah - 1, widget.endAyah);
    _texts = [
      for (final a in _ayahs)
        QuranText.stripBismillah(a.text,
            surahNumber: _surah.number, ayahNumber: a.numberInSurah),
    ];
    _recognizers = [for (final a in _ayahs) TapGestureRecognizer()..onTap = () => _open(a)];
    _startFlash();
  }

  @override
  void didUpdateWidget(AyahChunkItem old) {
    super.didUpdateWidget(old);
    if (old.highlightAyah != widget.highlightAyah) _startFlash();
  }

  void _startFlash() {
    final h = widget.highlightAyah;
    if (h == null || h < widget.startAyah || h > widget.endAyah) return;
    _flash = h;
    _flashTimer?.cancel();
    _flashTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _flash = null);
    });
  }

  @override
  void dispose() {
    _flashTimer?.cancel();
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  Future<void> _open(AyahModel ayah) async {
    setState(() => _selected = ayah.numberInSurah);
    await showAyahActionsSheet(context, ayah: ayah, surah: _surah);
    if (mounted) setState(() => _selected = null);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<double>(
      valueListenable: ReaderSettings.fontSize,
      builder: (context, fontSize, _) {
        final spans = <InlineSpan>[];
        for (var i = 0; i < _ayahs.length; i++) {
          final a = _ayahs[i];
          final marked = _selected == a.numberInSurah || _flash == a.numberInSurah;
          spans.add(TextSpan(
            text: '${_texts[i]} ',
            recognizer: _recognizers[i],
            style: TextStyle(
              fontFamily: 'AmiriQuran',
              fontSize: fontSize,
              height: 1.8,
              color: cs.onSurface,
              backgroundColor: marked ? cs.primary.withValues(alpha: 0.2) : null,
            ),
          ));
          spans.add(WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () => _open(a),
              child: _EndMarker(number: a.numberInSurah, highlighted: marked, color: cs.primary),
            ),
          ));
          spans.add(const TextSpan(text: ' '));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: spans),
            ),
          ),
        );
      },
    );
  }
}

class _EndMarker extends StatelessWidget {
  final int number;
  final bool highlighted;
  final Color color;
  const _EndMarker({required this.number, required this.highlighted, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: highlighted ? color.withValues(alpha: 0.2) : null,
        border: Border.all(color: const Color(0xFFDDA15E), width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(number.toString(),
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'IBMPlexSansArabic',
              color: Color(0xFFDDA15E),
              fontWeight: FontWeight.bold)),
    );
  }
}
