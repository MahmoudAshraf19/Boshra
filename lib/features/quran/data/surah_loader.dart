import 'models/quran_models.dart';
import 'repositories/quran_repository.dart';

/// Thin synchronous façade used by the reader widgets.
///
/// The old loader existed to protect the UI from slow disk/network loads
/// (queues, LRU, failure back-off). Text is now bundled and memoised in
/// [QuranTextSource], so none of that machinery is needed: [peek] always
/// returns a surah immediately and the list never shows spinners/placeholders
/// (which also removes the scroll "jumping" caused by placeholder heights).
class SurahLoader {
  SurahLoader(this._repo);
  final QuranRepository _repo;

  SurahModel peek(int n) => _repo.getSurahSync(n);
}
