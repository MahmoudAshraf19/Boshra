import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../../../core/constants/adhan_reciters.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/prayer_settings.dart';

/// Lets the user pick the Muadhin whose Adhan plays at prayer time,
/// with a play/stop preview for each one. Default: Mohammed Refat.
class AdhanReciterScreen extends StatefulWidget {
  const AdhanReciterScreen({super.key});

  @override
  State<AdhanReciterScreen> createState() => _AdhanReciterScreenState();
}

class _AdhanReciterScreenState extends State<AdhanReciterScreen> {
  final AudioPlayer _player = AudioPlayer();
  PrayerSettings? _settings;
  String? _playingId;
  bool _loadingPreview = false;

  @override
  void initState() {
    super.initState();
    PrayerSettings.load().then((s) {
      if (mounted) setState(() => _settings = s);
    });
    _player.playerStateStream.listen((st) {
      if (st.processingState == ProcessingState.completed && mounted) {
        setState(() => _playingId = null);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _select(AdhanReciter r) async {
    final s = _settings;
    if (s == null || s.adhanReciter == r.id) return;
    final next = s.copyWith(adhanReciter: r.id);
    setState(() => _settings = next);
    await next.save();
    await NotificationCoordinator.instance.rescheduleAll(force: true);
  }

  Future<void> _togglePreview(AdhanReciter r) async {
    try {
      if (_playingId == r.id) {
        await _player.stop();
        if (mounted) setState(() => _playingId = null);
        return;
      }
      setState(() {
        _playingId = r.id;
        _loadingPreview = true;
      });
      await _player.stop();
      await _player.setAudioSource(AudioSource.asset(
        r.assetPath,
        tag: MediaItem(id: 'adhan_${r.id}', title: r.nameEn),
      ));
      if (mounted) setState(() => _loadingPreview = false);
      await _player.play();
    } catch (e, s) {
      AppLogger.e('AdhanPreview', e, s);
      if (mounted) {
        setState(() {
          _playingId = null;
          _loadingPreview = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final selected = _settings?.adhanReciter ?? AdhanReciters.defaultId;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(ar ? 'اختيار المؤذن' : 'Choose Muadhin',
            style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.primary),
      ),
      body: _settings == null
          ? Center(child: CircularProgressIndicator(color: cs.primary))
          : ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              cacheExtent: 600,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              itemCount: AdhanReciters.all.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      ar
                          ? 'يُشغَّل الأذان بصوت المؤذن المختار عند دخول وقت الصلاة.'
                          : 'The selected Muadhin plays when the prayer time arrives.',
                      style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
                    ),
                  );
                }
                final r = AdhanReciters.all[i - 1];
                final isSel = r.id == selected;
                final isPlaying = _playingId == r.id;
                return Material(
                  color: isSel ? cs.primaryContainer.withValues(alpha: 0.35) : cs.surface,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: isSel ? cs.primary : cs.outlineVariant,
                      width: isSel ? 1.8 : 1,
                    ),
                  ),
                  child: ListTile(
                    onTap: () => _select(r),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: IconButton.filledTonal(
                      onPressed: () => _togglePreview(r),
                      icon: (isPlaying && _loadingPreview)
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Icon(isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded),
                    ),
                    title: Text(
                      r.name(ar),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSel ? cs.primary : cs.onSurface,
                      ),
                    ),
                    subtitle: (r.id == AdhanReciters.defaultId)
                        ? Text(ar ? 'الافتراضي' : 'Default')
                        : null,
                    trailing: Icon(
                      isSel ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                      color: isSel ? cs.primary : cs.outline,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
