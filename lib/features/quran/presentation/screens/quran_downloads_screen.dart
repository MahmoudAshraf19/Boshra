import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/audio/audio_download_manager.dart';
import '../../data/models/quran_models.dart';
import '../../data/models/reciter_model.dart';
import '../../data/repositories/quran_repository.dart';

/// OFFLINE AUDIO manager (separate from browsing/reading).
/// Pick a reciter → download / pause / delete any surah or all 114.
class QuranDownloadsScreen extends StatefulWidget {
  const QuranDownloadsScreen({super.key});
  @override
  State<QuranDownloadsScreen> createState() => _QuranDownloadsScreenState();
}

class _QuranDownloadsScreenState extends State<QuranDownloadsScreen> {
  final _mgr = AudioDownloadManager.instance;
  final _repo = QuranRepository();
  ReciterModel _reciter = availableReciters.first;
  QuranMetaModel? _meta;
  bool _ready = false;
  int _bytes = 0;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    _mgr.addListener(_onChange);
    _init();
  }

  Future<void> _init() async {
    final p = await SharedPreferences.getInstance();
    final id = p.getString('selected_reciter_id');
    _reciter = availableReciters.firstWhere((r) => r.id == id, orElse: () => availableReciters.first);
    _meta = await _repo.getQuranMetadata();
    await _mgr.ensureReciter(_reciter.id);
    _bytes = await _mgr.bytesUsed(_reciter.id);
    if (mounted) setState(() => _ready = true);
  }

  @override
  void dispose() {
    _mgr.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (!mounted) return;
    setState(() {});
    if (!_mgr.hasActiveJobs) _refreshBytes();
  }

  Future<void> _refreshBytes() async {
    final b = await _mgr.bytesUsed(_reciter.id);
    if (mounted) setState(() => _bytes = b);
  }

  Future<void> _pickReciter() async {
    final r = await showModalBottomSheet<ReciterModel>(
      context: context,
      builder: (ctx) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          for (final r in availableReciters)
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(_ar ? r.nameAr : r.nameEn),
              trailing: r.id == _reciter.id ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(ctx, r),
            ),
        ]),
      ),
    );
    if (r == null) return;
    final p = await SharedPreferences.getInstance();
    await p.setString('selected_reciter_id', r.id);
    await _mgr.ensureReciter(r.id);
    _reciter = r;
    await _refreshBytes();
  }

  Future<bool> _checkSpace(int ayahs) async {
    final ok = await StorageService().hasEnoughSpace(ayahs * AudioDownloadManager.estimatedBytesPerAyah);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_ar ? 'المساحة غير كافية' : 'Not enough storage space'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
    return ok;
  }

  Future<void> _download(int surah, int ayahs) async {
    if (!await _checkSpace(ayahs)) return;
    await _mgr.enqueueSurah(_reciter.id, surah);
  }

  Future<void> _downloadAll() async {
    if (!await _checkSpace(6236)) return;
    await _mgr.enqueueAll(_reciter.id);
  }

  Future<void> _deleteAll() async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_ar ? 'حذف كل التحميلات؟' : 'Delete all downloads?'),
        content: Text(_ar ? 'سيتم حذف تلاوات هذا القارئ من الجهاز.' : 'This reciter\'s audio will be removed from the device.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(_ar ? 'إلغاء' : 'Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(_ar ? 'حذف' : 'Delete')),
        ],
      ),
    );
    if (sure != true) return;
    await _mgr.deleteReciter(_reciter.id);
    await _refreshBytes();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final done = _ready ? _mgr.completeSurahs(_reciter.id).length : 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(_ar ? 'التلاوات والتحميل' : 'Audio & Downloads'),
        actions: [
          if (_ready && _mgr.hasActiveJobs)
            IconButton(
                tooltip: _ar ? 'إيقاف الكل' : 'Stop all',
                icon: const Icon(Icons.pause_circle_outline),
                onPressed: _mgr.cancelAll),
          if (_ready)
            PopupMenuButton<String>(
              onSelected: (v) => v == 'all' ? _downloadAll() : _deleteAll(),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'all', child: Text(_ar ? 'تحميل كل السور' : 'Download all surahs')),
                PopupMenuItem(value: 'del', child: Text(_ar ? 'حذف كل التحميلات' : 'Delete all downloads')),
              ],
            ),
        ],
      ),
      body: !_ready
          ? const Center(child: CircularProgressIndicator())
          : Column(children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: cs.primary.withValues(alpha: 0.15), child: Icon(Icons.person, color: cs.primary)),
                  title: Text(_ar ? _reciter.nameAr : _reciter.nameEn, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_ar
                      ? '$done / 114 سورة • ${(_bytes / (1024 * 1024)).toStringAsFixed(1)} م.ب'
                      : '$done / 114 surahs • ${(_bytes / (1024 * 1024)).toStringAsFixed(1)} MB'),
                  trailing: const Icon(Icons.keyboard_arrow_down),
                  onTap: _pickReciter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _ar
                      ? 'القراءة والتصفح يعملان بدون إنترنت دائماً. التحميل هنا للتلاوة الصوتية فقط.'
                      : 'Reading & browsing always work offline. Downloads here are for recitation audio only.',
                  style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 114,
                  itemBuilder: (context, i) => _tile(_meta!.surahs[i], cs),
                ),
              ),
            ]),
    );
  }

  Widget _tile(SurahMetaModel s, ColorScheme cs) {
    final job = _mgr.jobFor(_reciter.id, s.number);
    final have = _mgr.downloadedAyahs(_reciter.id, s.number);
    final complete = have == s.numberOfAyahs;

    Widget trailing;
    String? sub;
    if (job != null && !job.failed) {
      trailing = Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3, value: job.running ? job.progress : null)),
        IconButton(icon: const Icon(Icons.close), onPressed: () => _mgr.cancel(_reciter.id, s.number)),
      ]);
      sub = '${job.done}/${job.total}';
    } else if (job != null && job.failed) {
      trailing = IconButton(
          icon: Icon(Icons.refresh, color: cs.error),
          onPressed: () => _mgr.retry(_reciter.id, s.number));
      sub = _ar ? 'فشل التحميل — اضغط لإعادة المحاولة' : 'Failed — tap to retry';
    } else if (complete) {
      trailing = IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          await _mgr.deleteSurah(_reciter.id, s.number);
          _refreshBytes();
        },
      );
      sub = _ar ? 'محمّلة' : 'Downloaded';
    } else {
      trailing = IconButton(
          icon: const Icon(Icons.download_rounded),
          onPressed: () => _download(s.number, s.numberOfAyahs));
      if (have > 0) sub = '$have/${s.numberOfAyahs}';
    }

    return ListTile(
      leading: complete
          ? CircleAvatar(radius: 14, backgroundColor: const Color(0xFF354823), child: const Icon(Icons.check, size: 16, color: Colors.white))
          : Text(s.number.toString().padLeft(3, '0'), style: TextStyle(color: cs.onSurfaceVariant)),
      title: Text(_ar ? s.name : s.englishName),
      subtitle: sub == null ? null : Text(sub),
      trailing: trailing,
    );
  }
}
