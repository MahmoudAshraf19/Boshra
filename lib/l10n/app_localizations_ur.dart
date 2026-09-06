// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'بشریٰ';

  @override
  String get onboarding1Title => 'بشریٰ... نیکی کی راہ میں آپ کا ساتھی';

  @override
  String get onboarding1Desc =>
      'اپنے دن کو اللہ کے قریب کریں، سادہ اقدامات کے ساتھ۔';

  @override
  String get onboarding2Title => 'آپ کی عبادت کے لیے درکار ہر چیز، ایک جگہ';

  @override
  String get onboarding2Desc => 'قرآن، نماز کے اوقات، اذکار، قبلہ، اور دعائیں۔';

  @override
  String get onboarding3Title => 'ہر روز ایک چھوٹا قدم... بڑا اثر ڈالتا ہے';

  @override
  String get onboarding3Desc =>
      'اپنی ایمانی عادات بنائیں، اور اپنے دن کے لمحات سے فائدہ اٹھائیں۔';

  @override
  String get startJourney => 'اپنا سفر شروع کریں';

  @override
  String get next => 'اگلا';

  @override
  String get skip => 'چھوڑیں';

  @override
  String get navHome => 'ہوم';

  @override
  String get navQuran => 'قرآن';

  @override
  String get navAzkar => 'اذکار';

  @override
  String get navQibla => 'قبلہ';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'مزید';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return '$prayerName تک';
  }

  @override
  String get greeting => 'السلام علیکم👋';

  @override
  String get surahs => 'سورتیں';

  @override
  String get juzs => 'سپارے';

  @override
  String get prayerSettingsTitle => 'نماز اور اذان کی ترتیبات';

  @override
  String get prePrayerAlertTitle => 'نماز سے پہلے الرٹ';

  @override
  String minutesBeforeAdhan(int minutes) {
    return 'اذان سے $minutes منٹ پہلے';
  }

  @override
  String get enablePrayerAlertsTitle => 'نماز کے الرٹس آن کریں';

  @override
  String get fajr => 'فجر';

  @override
  String get dhuhr => 'ظہر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get ayahOfTheDay => 'آج کی آیت';

  @override
  String get listen => 'سنیں';

  @override
  String get tafseer => 'تفسیر';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return 'سورہ $surahName • آیت $verseNumber';
  }

  @override
  String get dailyWird => 'اپنا روزانہ کا ورد مکمل کریں';

  @override
  String get morningAzkar => 'صبح کے اذکار';

  @override
  String get eveningAzkar => 'شام کے اذکار';

  @override
  String get continueReading => 'جاری رکھیں';

  @override
  String get morningAzkarNotificationTitle => 'صبح کے اذکار 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'اپنے دن کا آغاز اللہ کے ذکر سے کریں';

  @override
  String get eveningAzkarNotificationTitle => 'شام کے اذکار 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'اپنے دن کا اختتام اللہ کے ذکر سے کریں';

  @override
  String get quickAccess => 'فوری رسائی';

  @override
  String get qibla => 'قبلہ';

  @override
  String get recitation => 'تلاوت';

  @override
  String get quran => 'قرآن';

  @override
  String get quranRadio => 'قرآن ریڈیو';

  @override
  String get azkar => 'اذکار';

  @override
  String get continueReadingCardTitle => 'پڑھنا جاری رکھیں';

  @override
  String surahName(String surahName) {
    return 'سورۃ $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'آیت $number';
  }

  @override
  String get selectedRecitationTitle => 'منتخب تلاوت';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'قرآن مجید';

  @override
  String get startQuranJourney => 'قرآن کے ساتھ اپنے سفر کا آغاز کریں';

  @override
  String get openSurahAndRead => 'کوئی سورت کھولیں اور پڑھنا شروع کریں';

  @override
  String get browseSurahs => 'سورتیں براؤز کریں';

  @override
  String get searchSurah => 'سورہ تلاش کریں...';

  @override
  String get tabSurahs => 'سورتیں';

  @override
  String get tabJuzs => 'پارے';

  @override
  String get tabHizbs => 'حزب';

  @override
  String get meccan => 'مکی';

  @override
  String get medinan => 'مدنی';

  @override
  String ayahsCount(Object count) {
    return '$count آیات';
  }

  @override
  String get tafsirOption => 'تفسیر';

  @override
  String get recitationOption => 'تلاوت';

  @override
  String get downloadOption => 'ڈاؤن لوڈ';

  @override
  String get shareOption => 'شیئر کریں';

  @override
  String get infoOption => 'معلومات';

  @override
  String get copyOption => 'کاپی';

  @override
  String get copiedSuccessfully => 'آیت کلپ بورڈ پر کاپی ہو گئی';

  @override
  String get azkarScreenTitle => 'Azkar';

  @override
  String get azkarScreenSubtitle => 'Close to Allah... in every moment';

  @override
  String get azkarCategoryMorning => 'Morning Azkar';

  @override
  String get azkarCategoryMorningSub => 'Remembrances for the morning';

  @override
  String get azkarCategoryEvening => 'Evening Azkar';

  @override
  String get azkarCategoryEveningSub => 'Remembrances for the evening';

  @override
  String get azkarCategoryPrayer => 'After Prayer';

  @override
  String get azkarCategoryPrayerSub => 'Remembrances after prayer';

  @override
  String get azkarCategorySleep => 'Sleep Azkar';

  @override
  String get azkarCategorySleepSub => 'Remembrances before sleep';

  @override
  String get azkarCategoryProtection => 'Protection Azkar';

  @override
  String get azkarCategoryProtectionSub => 'For protection and tranquility';

  @override
  String get azkarCategoryDaily => 'Daily Azkar';

  @override
  String get azkarCategoryDailySub => 'Various remembrances for the day';

  @override
  String get azkarAllCategories => 'All Categories';

  @override
  String get quranMessageNotificationTitle => 'قرآن کا پیغام 🌿';
}
