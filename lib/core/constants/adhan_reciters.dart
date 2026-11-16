/// Every Muadhin available for the prayer-time Adhan notification.
///
/// [rawName] is the Android `res/raw` / iOS bundle file name (lower-case letters,
/// digits and `_` only – Android rejects anything else). The original files live in
/// `assets/audio/azan_normal/` (used for the in-app preview); the setup script
/// `tools/setup_adhan.sh` copies them to the native folders under [rawName].
class AdhanReciter {
  final String id;
  final String nameAr;
  final String nameEn;
  final String assetFile; // file name inside assets/audio/azan_normal/
  const AdhanReciter(this.id, this.nameAr, this.nameEn, this.assetFile);

  String get rawName => 'azan_$id';
  String get assetPath => 'assets/audio/azan_normal/$assetFile';
  String get channelId => 'adhan_${id}_v5';
  String get iosSound => '$rawName.mp3';
  String name(bool arabic) => arabic ? nameAr : nameEn;
}

class AdhanReciters {
  AdhanReciters._();

  static const String defaultId = 'mohammed_refat';

  static const List<AdhanReciter> all = [
    AdhanReciter('mohammed_refat', 'الشيخ محمد رفعت', 'Mohammed Refat', 'mohammed_refat.mp3'),
    AdhanReciter('abdul_basit', 'الشيخ عبد الباسط عبد الصمد', 'Abdul Basit Abdul Samad', 'abdul-basit_abdul-samad.mp3'),
    AdhanReciter('al_hussary', 'الشيخ محمود خليل الحصري', 'Al-Hussary', 'al_hussary.mp3'),
    AdhanReciter('ali_mulla', 'الشيخ علي أحمد ملا', 'Ali Ahmed Mulla', 'ali_ahmed_mulla.mp3'),
    AdhanReciter('minshawi', 'الشيخ محمد صديق المنشاوي', 'Al-Minshawi', 'El-Minshawi.mp3'),
    AdhanReciter('essam_bukhari', 'الشيخ عصام بخاري', 'Essam Bukhari', 'essam-bukhari.MP3'),
    AdhanReciter('naji_qazzaz', 'الشيخ ناجي قزاز', 'Naji Qazzaz', 'naji-qazzaz.mp3'),
    AdhanReciter('naqshabandy', 'الشيخ سيد النقشبندي', 'Sayed El-Naqshabandy', 'naqshabandy.mp3'),
    AdhanReciter('nayef_fida', 'الشيخ نايف فدا', 'Nayef Fida', 'nayef_fida.mp3'),
  ];

  static AdhanReciter byId(String? id) =>
      all.firstWhere((r) => r.id == id, orElse: () => all.first);
}
