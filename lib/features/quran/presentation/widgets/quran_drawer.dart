import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/quran_text_utils.dart';

/// BROWSE ONLY. Works instantly and fully offline — no internet probe, no
/// download buttons, nothing is ever "locked". (Downloading audio lives in
/// [QuranDownloadsScreen].)
class QuranDrawer extends StatefulWidget {
  final int selectedSurah;
  final void Function(int surahNumber, {int? ayahNumber}) onSurahSelected;
  final VoidCallback? onOpenDownloads;

  const QuranDrawer({
    super.key,
    required this.selectedSurah,
    required this.onSurahSelected,
    this.onOpenDownloads,
  });

  @override
  State<QuranDrawer> createState() => _QuranDrawerState();
}

class _QuranDrawerState extends State<QuranDrawer> {
  final QuranRepository _repository = QuranRepository();
  QuranMetaModel? _meta;
  int _tab = 0; // 0 surahs, 1 juz, 2 hizb
  String _query = '';

  @override
  void initState() {
    super.initState();
    _repository.getQuranMetadata().then((m) {
      if (mounted) setState(() => _meta = m);
    });
  }

  String _norm(String s) => QuranText.plain(s).toLowerCase();

  void _go(int surah, {int? ayah}) {
    Navigator.pop(context);
    widget.onSurahSelected(surah, ayahNumber: ayah);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Drawer(
      backgroundColor: cs.surface,
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: l10n.searchSurah,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: cs.onSurface.withValues(alpha: 0.06),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          if (widget.onOpenDownloads != null)
            ListTile(
              dense: true,
              leading: Icon(Icons.download_for_offline_rounded, color: cs.primary),
              title: Text(isAr ? 'التلاوات والتحميل' : 'Audio & Downloads'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                widget.onOpenDownloads!();
              },
            ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _tabButton(l10n.tabSurahs, 0, cs),
            _tabButton(l10n.tabJuzs, 1, cs),
            _tabButton(l10n.tabHizbs, 2, cs),
          ]),
          const Divider(height: 1),
          Expanded(
            child: _meta == null
                ? const Center(child: CircularProgressIndicator())
                : _tab == 0
                    ? _surahList(l10n, cs, isAr)
                    : _positionList(l10n, cs, isAr),
          ),
        ]),
      ),
    );
  }

  Widget _tabButton(String title, int i, ColorScheme cs) {
    final sel = _tab == i;
    return InkWell(
      onTap: () => setState(() => _tab = i),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: sel ? cs.primary : Colors.transparent, width: 2)),
        ),
        child: Text(title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                color: sel ? cs.primary : cs.onSurfaceVariant)),
      ),
    );
  }

  Widget _surahList(AppLocalizations l10n, ColorScheme cs, bool isAr) {
    final q = _norm(_query.trim());
    final surahs = _meta!.surahs.where((s) {
      if (q.isEmpty) return true;
      return s.number.toString() == q ||
          _norm(s.name).contains(q) ||
          s.englishName.toLowerCase().contains(q);
    }).toList();

    return ListView.builder(
      itemCount: surahs.length,
      itemExtent: 72,
      itemBuilder: (context, i) {
        final s = surahs[i];
        final selected = s.number == widget.selectedSurah;
        final revelation = s.revelationType == 'Meccan' ? l10n.meccan : l10n.medinan;
        return InkWell(
          onTap: () => _go(s.number),
          child: Container(
            color: selected ? cs.onSurface.withValues(alpha: 0.07) : null,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(children: [
              SizedBox(
                width: 36,
                child: Text(s.number.toString().padLeft(2, '0'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected ? const Color(0xFFDDA15E) : cs.onSurfaceVariant)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(isAr ? s.name : s.englishName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('$revelation • ${l10n.ayahsCount(s.numberOfAyahs)}',
                      style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
                ]),
              ),
              if (selected)
                Container(width: 4, height: 32, decoration: BoxDecoration(color: const Color(0xFFDDA15E), borderRadius: BorderRadius.circular(4))),
            ]),
          ),
        );
      },
    );
  }

  Widget _positionList(AppLocalizations l10n, ColorScheme cs, bool isAr) {
    final isJuz = _tab == 1;
    final items = isJuz
        ? [for (final j in _meta!.juzs) (j.number, j.surah, j.ayah)]
        : [for (final h in _meta!.hizbs) (h.number, h.surah, h.ayah)];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final (number, surah, ayah) = items[i];
        final sm = _meta!.surahs[surah - 1];
        return ListTile(
          leading: Icon(isJuz ? Icons.menu_book : Icons.star_border, color: const Color(0xFFDDA15E)),
          title: Text('${isJuz ? l10n.tabJuzs : l10n.tabHizbs} $number',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${isAr ? sm.name : sm.englishName} • ${l10n.ayahNumber(ayah.toString())}'),
          onTap: () => _go(surah, ayah: ayah),
        );
      },
    );
  }
}
