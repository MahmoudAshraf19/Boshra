// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'بشری';

  @override
  String get onboarding1Title => 'بشری... همراه شما در مسیر خیر';

  @override
  String get onboarding1Desc =>
      'روز خود را به خدا نزدیک‌تر کنید، با قدم‌های ساده.';

  @override
  String get onboarding2Title => 'هر آنچه برای عبادت نیاز دارید، در یک مکان';

  @override
  String get onboarding2Desc => 'قرآن، اوقات شرعی، اذکار، قبله و ادعیه.';

  @override
  String get onboarding3Title => 'یک قدم کوچک هر روز... تاثیر بزرگی می‌گذارد';

  @override
  String get onboarding3Desc => 'عادات ایمانی خود را بسازید.';

  @override
  String get startJourney => 'سفر خود را شروع کنید';

  @override
  String get next => 'بعدی';

  @override
  String get skip => 'رد شدن';

  @override
  String get navHome => 'خانه';

  @override
  String get navQuran => 'قرآن';

  @override
  String get navAzkar => 'اذکار';

  @override
  String get navQibla => 'قبله';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'بیشتر';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'تا نماز $prayerName';
  }

  @override
  String get greeting => 'سلام عليكم👋';

  @override
  String get surahs => 'سوره‌ها';

  @override
  String get juzs => 'جزءها';

  @override
  String get prayerSettingsTitle => 'تنظیمات نماز و اذان';

  @override
  String get prePrayerAlertTitle => 'هشدار قبل از نماز';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes دقیقه قبل از اذان';
  }

  @override
  String get enablePrayerAlertsTitle => 'فعال سازی هشدارهای نماز';

  @override
  String get fajr => 'فجر';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get ayahOfTheDay => 'آیه روز';

  @override
  String get listen => 'گوش دادن';

  @override
  String get tafseer => 'تفسیر';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return 'سوره $surahName • آیه $verseNumber';
  }

  @override
  String get dailyWird => 'ورد روزانه خود را کامل کنید';

  @override
  String get morningAzkar => 'اذکار صبح';

  @override
  String get eveningAzkar => 'اذکار عصر';

  @override
  String get continueReading => 'ادامه';

  @override
  String get morningAzkarNotificationTitle => 'اذکار صبح 🌅';

  @override
  String get morningAzkarNotificationBody => 'روز خود را با یاد خدا آغاز کنید';

  @override
  String get eveningAzkarNotificationTitle => 'اذکار عصر 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'روز خود را با یاد خدا به پایان برسانید';

  @override
  String get quickAccess => 'دسترسی سریع';

  @override
  String get qibla => 'قبله';

  @override
  String get recitation => 'تلاوت';

  @override
  String get quran => 'قرآن';

  @override
  String get quranRadio => 'رادیو قرآن';

  @override
  String get azkar => 'اذکار';

  @override
  String get continueReadingCardTitle => 'ادامه خواندن';

  @override
  String surahName(String surahName) {
    return 'سوره $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'آیه $number';
  }

  @override
  String get selectedRecitationTitle => 'تلاوت منتخب';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'قرآن کریم';

  @override
  String get startQuranJourney => 'سفر خود را با قرآن آغاز کنید';

  @override
  String get openSurahAndRead => 'یک سوره را باز کنید و بخوانید';

  @override
  String get browseSurahs => 'مرور سوره‌ها';

  @override
  String get searchSurah => 'جستجوی سوره...';

  @override
  String get tabSurahs => 'سوره‌ها';

  @override
  String get tabJuzs => 'جزءها';

  @override
  String get tabHizbs => 'حزب‌ها';

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
  String get downloadOption => 'دانلود';

  @override
  String get shareOption => 'اشتراک گذاری';

  @override
  String get infoOption => 'اطلاعات';

  @override
  String get copyOption => 'کپی';

  @override
  String get copiedSuccessfully => 'آیه در کلیپ‌بورد کپی شد';

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
  String get quranMessageNotificationTitle => 'پیامی از قرآن 🌿';
}
