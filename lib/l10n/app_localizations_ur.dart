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

  @override
  String get saveBookmark => 'بک مارک محفوظ کریں';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'سورہ $surahName آیت $ayahNumber پر بک مارک محفوظ کیا گیا';
  }

  @override
  String get qiblaDirection => 'قبلہ کی سمت';

  @override
  String get qiblaAccurate => 'قبلہ درست ہے';

  @override
  String get youAreFacingQibla => 'اب آپ قبلہ کی طرف رخ کیے ہوئے ہیں';

  @override
  String get qiblaCalibration => 'قبلہ کیلیبریشن';

  @override
  String get qiblaCalibrationDesc =>
      'براہ کرم قطب نما کو کیلیبریٹ کرنے کے لیے اپنے فون کو آہستہ آہستہ 8 کی شکل میں حرکت دیں۔';

  @override
  String get findingLocation => 'مقام تلاش کیا جا رہا ہے...';

  @override
  String get locationPermissionError =>
      'مقام تک رسائی حاصل کرنے سے قاصر۔ براہ کرم GPS آن کریں۔';

  @override
  String get locationPermissionTitle => 'Allow Location Access';

  @override
  String get locationPermissionDesc =>
      'We need your location to accurately calculate the Qibla direction based on your current position.';

  @override
  String get preciseQibla => 'درست قبلہ';

  @override
  String get exactLocation => 'آپ کا درست مقام';

  @override
  String get alwaysUpToDate => 'ہمیشہ اپ ڈیٹ';

  @override
  String get allowLocationBtn => 'اجازت دیں';

  @override
  String get notNow => 'ابھی نہیں';

  @override
  String get startupLocationTitle => 'Location Access';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'We need your location for accurate Prayer Times and Qibla direction.\n\nIf you choose not to allow, we will use your last saved location: $locationName.';
  }

  @override
  String get startupLocationDescDefault =>
      'We need your location for accurate Prayer Times and Qibla direction.\n\nIf you choose not to allow, we will use the default location: Mecca, Saudi Arabia.';

  @override
  String get moreScreenTitle => 'مزید';

  @override
  String get generalSettings => 'عمومی';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get appLanguage => 'ایپ کی زبان';

  @override
  String get alertsSettings => 'انتباہات';

  @override
  String get notifications => 'اطلاعات';

  @override
  String get adhanAndReminders => 'اذان اور یاددہانی';

  @override
  String get dataAndStorage => 'ڈیٹا اور اسٹوریج';

  @override
  String get storage => 'اسٹوریج';

  @override
  String get storageDesc => 'ڈاؤن لوڈ کردہ سورتوں کا نظم کریں';

  @override
  String get infoAndSupport => 'معلومات اور تعاون';

  @override
  String get privacyAndPermissions => 'رازداری اور اجازتیں';

  @override
  String get aboutBoshra => 'بشری کے بارے میں';

  @override
  String get downloadedOption => 'ڈاؤن لوڈ کیا گیا';

  @override
  String get totalUsed => 'کل استعمال شدہ';

  @override
  String get systemApp => 'سسٹم (ایپ)';

  @override
  String get downloadedSurahs => 'ڈاؤن لوڈ کردہ سورتیں';

  @override
  String get cache => 'کیشے';

  @override
  String get manageDownloads => 'ڈاؤن لوڈز کا نظم کریں';

  @override
  String get clearCache => 'کیشے صاف کریں';

  @override
  String get clearAllDownloads => 'تمام ڈاؤن لوڈز صاف کریں';

  @override
  String get clearWarning => 'اس سے تمام ڈاؤن لوڈ کردہ مواد حذف ہو جائے گا۔';

  @override
  String get notEnoughSpace => 'کافی جگہ نہیں ہے (3 جی بی کی حد تک پہنچ گیا)۔';

  @override
  String get clearCacheWarning =>
      'کیا آپ کو یقین ہے؟ عارضی ڈیٹا صاف ہو جائے گا۔';

  @override
  String get clearAllData => 'تمام ڈیٹا صاف کریں';

  @override
  String get clearDataWarning =>
      'کیا آپ کو یقین ہے؟ ایپ ابتدائی حالت میں واپس آ جائے گی۔';

  @override
  String get yesClear => 'جی ہاں، صاف کریں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get yourPrivacyMatters => 'آپ کی رازداری ہمارے لیے اہم ہے۔';

  @override
  String get privacyRequestsDesc =>
      'بشرى صرف ان اجازتوں کی درخواست کرتا ہے جو اس کی خصوصیات فراہم کرنے کے لیے ضروری ہیں۔';

  @override
  String get permissions => 'اجازتیں';

  @override
  String get locationPermDesc =>
      'درست نماز کے اوقات معلوم کرنے اور آپ کے مقام کی بنیاد پر قبلہ کی سمت متعین کرنے کے لیے استعمال ہوتا ہے۔';

  @override
  String get statusAllowed => 'اجازت ہے';

  @override
  String get statusDenied => 'انکار';

  @override
  String get notificationsPermDesc =>
      'نماز کے اوقات، اذان کی اطلاعات اور اذکار کی یاد دہانیوں کے لیے استعمال ہوتی ہیں۔';

  @override
  String get yourData => 'آپ کا ڈیٹا';

  @override
  String get yourDataDesc1 => 'بشرى کے لیے اکاؤنٹ یا سائن اِن ضروری نہیں ہے۔';

  @override
  String get yourDataDesc2 =>
      'آپ کی ترجیحات، ڈاؤن لوڈ کیا گیا مواد اور مقامی ترتیبات ایپ کی خصوصیات فراہم کرنے کے لیے آپ کے آلے پر محفوظ کی جا سکتی ہیں۔';

  @override
  String get privacy => 'رازداری';

  @override
  String get privacyPolicyDesc =>
      'جانیں کہ بشرى معلومات کو کیسے جمع، استعمال، محفوظ اور محفوظ رکھتا ہے۔';

  @override
  String get termsAndConditions => 'شرائط و ضوابط';

  @override
  String get termsDesc => 'بشرى کے استعمال سے متعلق شرائط پڑھیں۔';

  @override
  String get dataAndPrivacy => 'ڈیٹا اور رازداری';

  @override
  String get dataPrivacyDesc =>
      'بشرى کے ذریعے پراسیس کیے جانے والے ڈیٹا اور آپ کے رازداری کے اختیارات کے بارے میں جانیں۔';

  @override
  String get permissionManagement => 'اجازتوں کا انتظام';

  @override
  String get manageLocationPerm => 'مقام کی اجازت کا انتظام کریں';

  @override
  String get manageLocationDesc =>
      'مقام تک رسائی تبدیل کرنے کے لیے ڈیوائس کی سیٹنگز کھولیں۔';

  @override
  String get manageNotificationsPerm => 'اطلاعات کی اجازت کا انتظام کریں';

  @override
  String get manageNotificationsDesc =>
      'اطلاعات تک رسائی تبدیل کرنے کے لیے ڈیوائس کی سیٹنگز کھولیں۔';

  @override
  String get localData => 'مقامی ڈیٹا';

  @override
  String get clearLocalDataDesc =>
      'اس ڈیوائس پر محفوظ بشرى کا مقامی ڈیٹا حذف کریں۔';

  @override
  String get clearDownloadsDesc =>
      'قرآن کی ڈاؤن لوڈ کی گئی تلاوتیں اور دیگر آف لائن مواد حذف کریں۔';

  @override
  String get privacyNote => 'رازداری کا نوٹ';

  @override
  String get privacyNoteDesc =>
      'بشرى مقام کی معلومات صرف ان خصوصیات کے لیے استعمال کرتا ہے جنہیں اس کی ضرورت ہوتی ہے، جیسے نماز کے اوقات اور قبلہ کی سمت۔';

  @override
  String get boshraTagline => 'قرآن، نماز اور ذکر کے لیے آپ کا روزانہ ساتھی۔';

  @override
  String get boshraAboutDesc =>
      'بشرى ایک اسلامی ایپ ہے جسے روزمرہ عبادت کو آسان، پُرسکون اور قابلِ رسائی بنانے کے لیے تیار کیا گیا ہے۔';

  @override
  String get whatYouCanDo => 'بشرى کے ساتھ آپ کیا کر سکتے ہیں؟';

  @override
  String get quranDesc => 'صاف اور آرام دہ تجربے کے ساتھ قرآن پڑھیں۔';

  @override
  String get quranRecitation => 'قرآن کی تلاوت';

  @override
  String get quranRecitationDesc => 'اپنے پسندیدہ قاری کی تلاوت سنیں۔';

  @override
  String get azkarDesc =>
      'اپنے روزانہ کے اذکار کو منظم اور آسان انداز میں جاری رکھیں۔';

  @override
  String get prayerTimesDesc =>
      'اپنے مقام کے مطابق درست نماز کے اوقات حاصل کریں۔';

  @override
  String get qiblaDesc =>
      'اپنے آلے کے مقام اور کمپاس کا استعمال کرتے ہوئے خانہ کعبہ کی سمت معلوم کریں۔';

  @override
  String get reminders => 'یاد دہانیاں';

  @override
  String get remindersDesc =>
      'دن بھر اپنی عبادت سے جڑے رہنے کے لیے بروقت یاد دہانیاں حاصل کریں۔';

  @override
  String get appInfo => 'ایپ کی معلومات';

  @override
  String get version => 'ورژن';

  @override
  String get buildNumber => 'Build';

  @override
  String get moreOptions => 'مزید';

  @override
  String get rateBoshra => 'بشرى کو ریٹ کریں';

  @override
  String get rateBoshraDesc => 'اپنا جائزہ دے کر بشرى کی حمایت کریں۔';

  @override
  String get shareBoshra => 'بشرى شیئر کریں';

  @override
  String get shareBoshraDesc => 'بشرى کو خاندان اور دوستوں کے ساتھ شیئر کریں۔';

  @override
  String get contactUs => 'ہم سے رابطہ کریں';

  @override
  String get contactUsDesc => 'Mahmoud Ashraf سے رابطہ کریں۔';

  @override
  String get openSourceLicenses => 'اوپن سورس لائسنسز';

  @override
  String get openSourceDesc =>
      'بشرى میں استعمال ہونے والے تھرڈ پارٹی اوپن سورس سافٹ ویئر کے لائسنس دیکھیں۔';

  @override
  String get madeWithCare =>
      'ان لوگوں کے لیے محبت اور توجہ کے ساتھ بنایا گیا جو قرآن اور ذکر سے مزید قریب ہونا چاہتے ہیں۔';

  @override
  String get locationText => 'مقام';

  @override
  String get privacyPolicyText => 'رازداری کی پالیسی';

  @override
  String get clearLocalDataText => 'مقامی ڈیٹا صاف کریں';

  @override
  String get prayerTimesText => 'نماز کے اوقات';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeLightDesc => 'صاف اور روشن انٹرفیس';

  @override
  String get themeDark => 'تاریک';

  @override
  String get themeDarkDesc => 'گہرا اور تاریک انٹرفیس';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get themeSystemDesc => 'ڈیوائس کی ترتیبات کے مطابق';

  @override
  String get soundType => 'Notification Type';

  @override
  String get soundSilent => 'Silent (No sound)';

  @override
  String get soundShort => 'Short Beep';

  @override
  String get soundAdhan => 'Full Adhan';

  @override
  String get testNotificationNow => 'Test Notification Now';

  @override
  String get prePrayerAlertDesc => 'Alert me before Adhan by';
}
