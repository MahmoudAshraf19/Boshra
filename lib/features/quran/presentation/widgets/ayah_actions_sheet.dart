import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/quran_text_utils.dart';
import '../../data/repositories/quran_repository.dart';
import 'ayah_share_service.dart';
import 'recitation_bottom_sheet.dart';
import 'tafsir_bottom_sheet.dart';

/// The action sheet shown when an ayah is tapped.
/// All follow-up UI uses [hostContext] (the reader, which stays mounted) and NOT
/// the sheet's own context, which is already popped when actions run.
Future<void> showAyahActionsSheet(
  BuildContext hostContext, {
  required AyahModel ayah,
  required SurahModel surah,
}) {
  final l10n = AppLocalizations.of(hostContext)!;
  final locale = Localizations.localeOf(hostContext).languageCode;
  final cs = Theme.of(hostContext).colorScheme;

  Widget tile(BuildContext sheetCtx, IconData icon, String title, Future<void> Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: cs.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () async {
        Navigator.pop(sheetCtx);
        if (!hostContext.mounted) return;
        await onTap();
      },
    );
  }

  return showModalBottomSheet<void>(
    context: hostContext,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (sheetCtx) => SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('${surah.name} - ${l10n.ayahNumber(ayah.numberInSurah.toString())}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
        const SizedBox(height: 16),
        tile(sheetCtx, Icons.bookmark_add, l10n.saveBookmark, () async {
          // A bookmark is NOT the "last read" position (they used to overwrite each other).
          await QuranRepository().saveBookmark(surah.number, ayah.numberInSurah);
          if (hostContext.mounted) {
            AppFeedback.message(hostContext,
                l10n.bookmarkSavedSuccessfully(surah.name, ayah.numberInSurah.toString()));
          }
        }),
        tile(sheetCtx, Icons.menu_book, l10n.tafsirOption, () async {
          await showModalBottomSheet<void>(
            context: hostContext,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (_) => TafsirBottomSheet(ayah: ayah, surah: surah, locale: locale),
          );
        }),
        tile(sheetCtx, Icons.headset, l10n.recitationOption, () async {
          await showModalBottomSheet<void>(
            context: hostContext,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (_) => RecitationBottomSheet(initialAyah: ayah, surah: surah, locale: locale),
          );
        }),
        tile(sheetCtx, Icons.share, l10n.shareOption,
            () => AyahShareService.share(hostContext, ayah: ayah, surah: surah)),
        tile(sheetCtx, Icons.copy, l10n.copyOption, () async {
          final text = QuranText.stripBismillah(ayah.text,
              surahNumber: surah.number, ayahNumber: ayah.numberInSurah);
          await Clipboard.setData(ClipboardData(text: '$text ﴿${ayah.numberInSurah}﴾'));
          if (hostContext.mounted) AppFeedback.message(hostContext, l10n.copiedSuccessfully);
        }),
      ]),
    ),
  );
}
