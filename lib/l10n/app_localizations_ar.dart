// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بشرى';

  @override
  String get onboarding1Title => 'بُشرى… رفيقك في طريق الخير';

  @override
  String get onboarding1Desc =>
      'اجعل يومك أقرب إلى الله، بخطوات بسيطة وعبادات حاضرة معك في كل وقت.';

  @override
  String get onboarding2Title => 'كل ما تحتاجه لعبادتك، في مكان واحد';

  @override
  String get onboarding2Desc =>
      'القرآن، أوقات الصلاة، الأذكار، القبلة، والأدعية… بتجربة بسيطة تساعدك على الاستمرار.';

  @override
  String get onboarding3Title => 'خطوة صغيرة كل يوم… تصنع أثرًا كبيرًا';

  @override
  String get onboarding3Desc =>
      'ابنِ عاداتك الإيمانية، واغتنم لحظات يومك بما يقربك إلى الله.';

  @override
  String get startJourney => 'ابدأ رحلتك';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navQuran => 'القرآن';

  @override
  String get navAzkar => 'الأذكار';

  @override
  String get navQibla => 'القبلة';

  @override
  String get navRadio => 'الإذاعة';

  @override
  String get navMore => 'المزيد';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'حتى صلاة $prayerName';
  }

  @override
  String get greeting => 'السلام عليكم👋';

  @override
  String get surahs => 'السور';

  @override
  String get juzs => 'الأجزاء';

  @override
  String get prayerSettingsTitle => 'إعدادات الصلاة والأذان';

  @override
  String get prePrayerAlertTitle => 'التنبيه المسبق (قبل الصلاة)';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes دقيقة قبل الأذان';
  }

  @override
  String get enablePrayerAlertsTitle => 'تفعيل التنبيهات للصلوات';

  @override
  String get fajr => 'الفجر';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get ayahOfTheDay => 'آية اليوم';

  @override
  String get listen => 'استماع';

  @override
  String get tafseer => 'تفسير';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return 'سورة $surahName • الآية $verseNumber';
  }

  @override
  String get dailyWird => 'أكمل وردك اليومي';

  @override
  String get morningAzkar => 'أذكار الصباح';

  @override
  String get eveningAzkar => 'أذكار المساء';

  @override
  String get continueReading => 'متابعة';

  @override
  String get morningAzkarNotificationTitle => 'أذكار الصباح 🌅';

  @override
  String get morningAzkarNotificationBody => 'ابدأ يومك بذكر الله وتوفيقه';

  @override
  String get eveningAzkarNotificationTitle => 'أذكار المساء 🌙';

  @override
  String get eveningAzkarNotificationBody => 'اختم يومك بذكر الله وطمأنينة';

  @override
  String get quickAccess => 'الوصول السريع';

  @override
  String get qibla => 'القبلة';

  @override
  String get recitation => 'التلاوة';

  @override
  String get quran => 'القرآن';

  @override
  String get quranRadio => 'إذاعة القرآن';

  @override
  String get azkar => 'الأذكار';

  @override
  String get continueReadingCardTitle => 'متابعة القراءة';

  @override
  String surahName(String surahName) {
    return 'سورة $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'الآية $number';
  }

  @override
  String get selectedRecitationTitle => 'تلاوة مختارة';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'القرآن الكريم';

  @override
  String get startQuranJourney => 'ابدأ رحلتك مع القرآن';

  @override
  String get openSurahAndRead => 'افتح سورة وابدأ القراءة';

  @override
  String get browseSurahs => 'تصفح السور';

  @override
  String get searchSurah => 'البحث عن سورة...';

  @override
  String get tabSurahs => 'السور';

  @override
  String get tabJuzs => 'الأجزاء';

  @override
  String get tabHizbs => 'الأحزاب';

  @override
  String get meccan => 'مكية';

  @override
  String get medinan => 'مدنية';

  @override
  String ayahsCount(Object count) {
    return '$count آيات';
  }

  @override
  String get tafsirOption => 'تفسير';

  @override
  String get recitationOption => 'تلاوة';

  @override
  String get downloadOption => 'تنزيل';

  @override
  String get shareOption => 'مشاركة';

  @override
  String get infoOption => 'معلومات';

  @override
  String get copyOption => 'نسخ';

  @override
  String get copiedSuccessfully => 'تم نسخ الآية للحافظة';

  @override
  String get azkarScreenTitle => 'أذكار';

  @override
  String get azkarScreenSubtitle => 'قرب من الله... في كل لحظة';

  @override
  String get azkarCategoryMorning => 'أذكار الصباح';

  @override
  String get azkarCategoryMorningSub => 'أذكار و أذكار الصباح';

  @override
  String get azkarCategoryEvening => 'أذكار المساء';

  @override
  String get azkarCategoryEveningSub => 'أذكار و أذكار المساء';

  @override
  String get azkarCategoryPrayer => 'بعد الصلاة';

  @override
  String get azkarCategoryPrayerSub => 'أذكار بعد الصلاة';

  @override
  String get azkarCategorySleep => 'أذكار النوم';

  @override
  String get azkarCategorySleepSub => 'أذكار قبل النوم';

  @override
  String get azkarCategoryProtection => 'أذكار الحماية';

  @override
  String get azkarCategoryProtectionSub => 'أذكار للحماية والطمأنينة';

  @override
  String get azkarCategoryDaily => 'أذكار يومية';

  @override
  String get azkarCategoryDailySub => 'أذكار متنوعة لليوم';

  @override
  String get azkarAllCategories => 'كل الأقسام';

  @override
  String get quranMessageNotificationTitle => 'رسالة من القرآن 🌿';

  @override
  String get saveBookmark => 'حفظ العلامة';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'تم حفظ العلامة عند سورة $surahName آية $ayahNumber';
  }
}
