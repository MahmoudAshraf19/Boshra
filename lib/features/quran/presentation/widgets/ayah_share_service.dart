import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/quran_models.dart';
import '../../data/quran_text_utils.dart';
import 'ayah_share_widget.dart';

/// Renders an ayah to a 1080×1350 PNG and opens the share sheet.
/// (From the share sheet the user can also "Save to Photos / Files".)
///
/// Fixes vs. old inline code:
///  * background image is pre-cached (it used to be captured blank on first use);
///  * pixelRatio = 1 → exact 1080×1350 (old code produced ~3240×4050 → OOM risk);
///  * theme/fonts inherited via `context`; Material ancestor provided;
///  * loading dialog is ALWAYS closed (try/finally) – no stuck spinner;
///  * unique temp file per ayah, timeout, user-visible localized errors;
///  * iPad popover origin supplied.
class AyahShareService {
  AyahShareService._();
  static const _tag = 'AyahShare';

  static Future<void> share(
    BuildContext context, {
    required AyahModel ayah,
    required SurahModel surah,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context, rootNavigator: true);
    final box = context.findRenderObject() as RenderBox?;
    final origin = box != null && box.hasSize
        ? box.localToGlobal(Offset.zero) & box.size
        : const Rect.fromLTWH(0, 0, 10, 10);

    var dialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const PopScope(
        canPop: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    ).whenComplete(() => dialogOpen = false);

    try {
      await precacheImage(const AssetImage('assets/images/share.png'), context);
      if (!context.mounted) return;

      final plainText = QuranText.stripBismillah(ayah.text,
          surahNumber: surah.number, ayahNumber: ayah.numberInSurah);

      final Uint8List bytes = await ScreenshotController()
          .captureFromWidget(
            Material(
              type: MaterialType.transparency,
              child: MediaQuery(
                data: const MediaQueryData(
                    size: Size(1080, 1350), devicePixelRatio: 1.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: AyahShareWidget(
                    ayah: ayah,
                    surah: surah,
                    displayText: plainText,
                    ayahLabel: l10n.ayahNumber(ayah.numberInSurah.toString()),
                  ),
                ),
              ),
            ),
            context: context,
            pixelRatio: 1.0,
            delay: const Duration(milliseconds: 350),
            targetSize: const Size(1080, 1350),
          )
          .timeout(const Duration(seconds: 15));

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/ayah_${surah.number}_${ayah.numberInSurah}.png');
      await file.writeAsBytes(bytes, flush: true);

      if (dialogOpen && navigator.canPop()) navigator.pop();
      dialogOpen = false;

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png')],
        text: '$plainText ﴿${ayah.numberInSurah}﴾\n— ${surah.name}',
        sharePositionOrigin: origin,
      );
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'share failed');
      if (dialogOpen && navigator.canPop()) navigator.pop();
      dialogOpen = false;
      if (context.mounted) AppFeedback.message(context, l10n.shareFailed, isError: true);
    } finally {
      if (dialogOpen && navigator.canPop()) navigator.pop();
    }
  }
}
