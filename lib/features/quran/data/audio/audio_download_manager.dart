import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/utils/app_logger.dart';
import '../quran_meta.dart';

/// Progress of one (reciter, surah) download.
class DownloadJob {
  DownloadJob(this.reciterId, this.surah, this.total, this.done);
  final String reciterId;
  final int surah;
  final int total;
  int done;
  bool running = false;
  bool failed = false;
  bool cancelled = false;
  String? error;
  String get key => '$reciterId|$surah';
  double get progress => total == 0 ? 1 : done / total;
}

/// Real offline audio. Text is bundled with the app, so "download" means
/// "store the recitation (mp3 per ayah) on the device".
///
/// * Files:  <documents>/quran_audio/<reciterId>/<globalAyah>.mp3
/// * Atomic: written to `.part`, renamed when complete (no corrupt files).
/// * Resumable: already-present ayahs are skipped on retry / next launch.
/// * Parallel (4 ayahs at once), retried with back-off, cancellable.
/// * State = what's on disk (no manifest to get out of sync).
class AudioDownloadManager extends ChangeNotifier {
  AudioDownloadManager._();
  static final AudioDownloadManager instance = AudioDownloadManager._();

  static const int _parallel = 4;
  static const int _retries = 3;
  static const String _cdn = 'https://cdn.islamic.network/quran/audio/64';
  /// Rough size of one ayah at 64 kbps, used only for the free-space check.
  static const int estimatedBytesPerAyah = 70 * 1024;

  final HttpClient _client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15)
    ..maxConnectionsPerHost = 6;

  String? _root;
  Future<void>? _initFuture;
  final Map<String, Set<int>> _have = {};
  final Map<String, Future<void>> _scans = {};
  final Map<String, DownloadJob> _jobs = {};
  final Queue<DownloadJob> _queue = Queue();
  bool _pumping = false;
  Timer? _notifyTimer;

  // ───────────────────────── setup ─────────────────────────
  Future<void> init() => _initFuture ??= () async {
        final docs = await getApplicationDocumentsDirectory();
        _root = '${docs.path}/quran_audio';
        await Directory(_root!).create(recursive: true);
      }();

  Future<void> ensureReciter(String reciterId) async {
    await init();
    await (_scans[reciterId] ??= _scan(reciterId));
  }

  Future<void> _scan(String reciterId) async {
    final set = <int>{};
    final dir = Directory('$_root/$reciterId');
    try {
      if (await dir.exists()) {
        await for (final e in dir.list()) {
          if (e is! File) continue;
          final name = e.uri.pathSegments.last;
          if (name.endsWith('.part')) {
            unawaited(e.delete().catchError((_) => e));
            continue;
          }
          if (!name.endsWith('.mp3')) continue;
          final n = int.tryParse(name.substring(0, name.length - 4));
          if (n != null && await e.length() > 0) set.add(n);
        }
      }
    } catch (e, s) {
      AppLogger.e('AudioDownload', e, s, 'scan $reciterId');
    }
    _have[reciterId] = set;
  }

  // ───────────────────────── queries (sync, after ensureReciter) ─────────────────────────
  static String urlFor(String reciterId, int globalAyah) => '$_cdn/$reciterId/$globalAyah.mp3';

  File _file(String reciterId, int global) => File('$_root/$reciterId/$global.mp3');

  /// The local file for this ayah if it is on the device, else null.
  File? localFile(String reciterId, int global) {
    if (_root == null) return null;
    final have = _have[reciterId];
    return (have != null && have.contains(global)) ? _file(reciterId, global) : null;
  }

  int downloadedAyahs(String reciterId, int surah) {
    final have = _have[reciterId];
    if (have == null) return 0;
    final start = QuranMeta.globalAyah(surah, 1);
    final n = QuranMeta.ayahCount(surah);
    var c = 0;
    for (var g = start; g < start + n; g++) {
      if (have.contains(g)) c++;
    }
    return c;
  }

  bool isComplete(String reciterId, int surah) =>
      downloadedAyahs(reciterId, surah) == QuranMeta.ayahCount(surah);

  Set<int> completeSurahs(String reciterId) =>
      {for (var s = 1; s <= 114; s++) if (isComplete(reciterId, s)) s};

  DownloadJob? jobFor(String reciterId, int surah) => _jobs['$reciterId|$surah'];
  bool get hasActiveJobs => _jobs.values.any((j) => !j.failed);

  Future<int> bytesUsed(String reciterId) async {
    await init();
    var total = 0;
    final dir = Directory('$_root/$reciterId');
    if (!await dir.exists()) return 0;
    await for (final e in dir.list()) {
      if (e is File) total += await e.length();
    }
    return total;
  }

  // ───────────────────────── commands ─────────────────────────
  Future<void> enqueueSurah(String reciterId, int surah) async {
    await ensureReciter(reciterId);
    final key = '$reciterId|$surah';
    final existing = _jobs[key];
    if (existing != null && !existing.failed) return; // already queued/running
    final total = QuranMeta.ayahCount(surah);
    final done = downloadedAyahs(reciterId, surah);
    if (done == total) return;
    final job = DownloadJob(reciterId, surah, total, done);
    _jobs[key] = job;
    _queue.add(job);
    _notify(now: true);
    unawaited(_pump());
  }

  Future<void> enqueueAll(String reciterId) async {
    for (var s = 1; s <= 114; s++) {
      await enqueueSurah(reciterId, s);
    }
  }

  void cancel(String reciterId, int surah) {
    final job = _jobs['$reciterId|$surah'];
    if (job == null) return;
    job.cancelled = true;
    if (!job.running) {
      _queue.remove(job);
      _jobs.remove(job.key);
    }
    _notify(now: true);
  }

  void cancelAll() {
    for (final j in _jobs.values.toList()) {
      cancel(j.reciterId, j.surah);
    }
  }

  Future<void> deleteSurah(String reciterId, int surah) async {
    cancel(reciterId, surah);
    await ensureReciter(reciterId);
    final have = _have[reciterId]!;
    final start = QuranMeta.globalAyah(surah, 1);
    for (var g = start; g < start + QuranMeta.ayahCount(surah); g++) {
      if (have.remove(g)) {
        try {
          await _file(reciterId, g).delete();
        } catch (_) {}
      }
    }
    _notify(now: true);
  }

  Future<void> deleteReciter(String reciterId) async {
    for (final j in _jobs.values.where((j) => j.reciterId == reciterId).toList()) {
      cancel(j.reciterId, j.surah);
    }
    await init();
    try {
      final dir = Directory('$_root/$reciterId');
      if (await dir.exists()) await dir.delete(recursive: true);
    } catch (e, s) {
      AppLogger.e('AudioDownload', e, s, 'deleteReciter');
    }
    _have[reciterId] = <int>{};
    _scans[reciterId] = Future.value();
    _notify(now: true);
  }

  // ───────────────────────── worker ─────────────────────────
  Future<void> _pump() async {
    if (_pumping) return;
    _pumping = true;
    try {
      while (_queue.isNotEmpty) {
        final job = _queue.removeFirst();
        if (job.cancelled) {
          _jobs.remove(job.key);
          continue;
        }
        job.running = true;
        _notify(now: true);
        await _run(job);
        job.running = false;
        if (job.cancelled || !job.failed) _jobs.remove(job.key);
        _notify(now: true);
      }
    } finally {
      _pumping = false;
    }
  }

  Future<void> _run(DownloadJob job) async {
    final have = _have[job.reciterId]!;
    final start = QuranMeta.globalAyah(job.surah, 1);
    final pending = Queue<int>.from([
      for (var g = start; g < start + job.total; g++) if (!have.contains(g)) g,
    ]);
    try {
      await Directory('$_root/${job.reciterId}').create(recursive: true);
    } catch (e) {
      job.failed = true;
      job.error = '$e';
      return;
    }

    Future<void> worker() async {
      while (!job.cancelled && !job.failed && pending.isNotEmpty) {
        final g = pending.removeFirst();
        final ok = await _downloadAyah(job, g);
        if (ok) {
          have.add(g);
          job.done++;
          _notify();
        } else if (!job.cancelled) {
          job.failed = true;
        }
      }
    }

    await Future.wait(List.generate(_parallel, (_) => worker()));
  }

  Future<bool> _downloadAyah(DownloadJob job, int global) async {
    final file = _file(job.reciterId, global);
    final part = File('${file.path}.part');
    for (var attempt = 0; attempt < _retries; attempt++) {
      if (job.cancelled) return false;
      try {
        final req = await _client
            .getUrl(Uri.parse(urlFor(job.reciterId, global)))
            .timeout(const Duration(seconds: 15));
        final res = await req.close().timeout(const Duration(seconds: 20));
        if (res.statusCode != 200) {
          await res.drain<void>();
          throw HttpException('HTTP ${res.statusCode}', uri: req.uri);
        }
        final sink = part.openWrite();
        var len = 0;
        try {
          await for (final chunk in res.timeout(const Duration(seconds: 20))) {
            sink.add(chunk);
            len += chunk.length;
          }
        } finally {
          await sink.close();
        }
        if (len == 0 || (res.contentLength > 0 && len != res.contentLength)) {
          throw const FormatException('truncated download');
        }
        await part.rename(file.path);
        return true;
      } catch (e, s) {
        try {
          if (await part.exists()) await part.delete();
        } catch (_) {}
        if (attempt == _retries - 1) {
          job.error = '$e';
          AppLogger.e('AudioDownload', e, s, '${job.reciterId} ayah $global');
          return false;
        }
        await Future<void>.delayed(Duration(milliseconds: 500 * (attempt + 1) * (attempt + 1)));
      }
    }
    return false;
  }

  /// Retry a failed surah (keeps what was already downloaded).
  Future<void> retry(String reciterId, int surah) async {
    _jobs.remove('$reciterId|$surah');
    await enqueueSurah(reciterId, surah);
  }

  void _notify({bool now = false}) {
    if (now) {
      _notifyTimer?.cancel();
      _notifyTimer = null;
      notifyListeners();
      return;
    }
    _notifyTimer ??= Timer(const Duration(milliseconds: 150), () {
      _notifyTimer = null;
      notifyListeners();
    });
  }
}
