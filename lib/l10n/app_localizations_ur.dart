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
  String get navRadio => 'ریڈیو';

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
  String get live => 'براہِ راست';

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
  String get azkarScreenTitle => 'اذکار';

  @override
  String get azkarScreenSubtitle => 'اللہ کے قریب… ہر لمحہ';

  @override
  String get azkarCategoryMorning => 'صبح کے اذکار';

  @override
  String get azkarCategoryMorningSub => 'صبح کے اذکار';

  @override
  String get azkarCategoryEvening => 'شام کے اذکار';

  @override
  String get azkarCategoryEveningSub => 'شام کے اذکار';

  @override
  String get azkarCategoryPrayer => 'نماز کے بعد';

  @override
  String get azkarCategoryPrayerSub => 'نماز کے بعد کے اذکار';

  @override
  String get azkarCategorySleep => 'سونے کے اذکار';

  @override
  String get azkarCategorySleepSub => 'سونے سے پہلے کے اذکار';

  @override
  String get azkarCategoryProtection => 'حفاظت کے اذکار';

  @override
  String get azkarCategoryProtectionSub => 'حفاظت اور سکون کے لیے';

  @override
  String get azkarCategoryDaily => 'روزانہ اذکار';

  @override
  String get azkarCategoryDailySub => 'دن بھر کے لیے مختلف اذکار';

  @override
  String get azkarAllCategories => 'تمام زمرے';

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
  String get locationPermissionTitle => 'لوکیشن تک رسائی کی اجازت دیں';

  @override
  String get locationPermissionDesc =>
      'آپ کی موجودہ جگہ سے قبلے کی درست سمت معلوم کرنے کے لیے ہمیں آپ کی لوکیشن درکار ہے۔';

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
  String get startupLocationTitle => 'لوکیشن تک رسائی';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'درست اوقاتِ نماز اور قبلے کی سمت کے لیے ہمیں آپ کی لوکیشن درکار ہے۔\n\nاجازت نہ دینے کی صورت میں ہم آپ کی آخری محفوظ شدہ لوکیشن استعمال کریں گے: $locationName۔';
  }

  @override
  String get startupLocationDescDefault =>
      'درست اوقاتِ نماز اور قبلے کی سمت کے لیے ہمیں آپ کی لوکیشن درکار ہے۔\n\nاجازت نہ دینے کی صورت میں ہم ڈیفالٹ لوکیشن استعمال کریں گے: مکہ مکرمہ، سعودی عرب۔';

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
  String get soundType => 'اطلاع کی قسم';

  @override
  String get soundSilent => 'خاموش (بغیر آواز)';

  @override
  String get soundShort => 'مختصر آواز';

  @override
  String get soundAdhan => 'مکمل اذان';

  @override
  String get prePrayerAlertDesc => 'اذان سے پہلے مجھے اطلاع دیں';

  @override
  String prayerNotifTitle(String prayerName) {
    return '$prayerName کی نماز کا وقت ہو گیا';
  }

  @override
  String get prayerNotifBody => 'نماز کی طرف آئیے';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return '$prayerName کی نماز قریب ہے';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'اذان میں $minutes منٹ باقی ہیں';
  }

  @override
  String get notifDisabledTitle => 'اطلاعات بند ہیں';

  @override
  String get notifDisabledDesc =>
      'اطلاعات آن کریں تاکہ اذان اور یاد دہانیاں وقت پر ملیں۔';

  @override
  String get exactAlarmTitle => 'درست الارم بند ہیں';

  @override
  String get exactAlarmDesc =>
      '«الارم اور یاد دہانیاں» کی اجازت دیں تاکہ اذان عین وقت پر آئے۔';

  @override
  String get openSettings => 'سیٹنگز کھولیں';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get errorGeneric => 'کچھ غلط ہو گیا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get errorNoInternet =>
      'انٹرنیٹ کنکشن نہیں ہے۔ کنکشن چیک کر کے دوبارہ کوشش کریں۔';

  @override
  String get errorLoadFailed => 'مواد لوڈ نہیں ہو سکا۔';

  @override
  String get downloadingProgress => 'ڈاؤن لوڈ ہو رہا ہے…';

  @override
  String get downloadSuccess => 'کامیابی سے ڈاؤن لوڈ ہو گیا';

  @override
  String get downloadFailed => 'ڈاؤن لوڈ ناکام ہوا۔ دوبارہ کوشش کریں۔';

  @override
  String get shareFailed => 'تصویر نہیں بن سکی۔ دوبارہ کوشش کریں۔';

  @override
  String get audioLoadFailed => 'آڈیو نہیں چل سکی۔ کنکشن چیک کریں۔';

  @override
  String get radioLoadFailed => 'اسٹیشن لوڈ نہیں ہو سکے';

  @override
  String get continueReadingBtn => 'پڑھنا جاری رکھیں';

  @override
  String get permSetupTitle => 'کوئی نماز نہ چھوٹے';

  @override
  String get permSetupSubtitle =>
      'ایک بار چند اجازتیں دے دیں تاکہ اذان اور یاد دہانیاں ہمیشہ عین وقت پر آئیں — ایپ بند ہونے پر بھی۔';

  @override
  String get permNotifTitle => 'اطلاعات';

  @override
  String get permNotifDesc =>
      'اذان، نماز کی یاد دہانی، اذکار اور قرآنی پیغامات دکھانے کے لیے۔';

  @override
  String get permExactTitle => 'الارم اور یاد دہانیاں';

  @override
  String get permExactDesc =>
      'اینڈرائیڈ کو عین مقررہ منٹ پر اذان دینے کی اجازت دیتا ہے۔';

  @override
  String get permBatteryTitle => 'بغیر پابندی بیٹری';

  @override
  String get permBatteryDesc =>
      'سسٹم کو ایپ سلانے اور اطلاعات گرانے سے روکتا ہے۔';

  @override
  String get permAutostartTitle => 'آٹو اسٹارٹ اور بیک گراؤنڈ';

  @override
  String permAutostartDesc(String brand) {
    return 'آپ کا فون ($brand) بیک گراؤنڈ ایپس روک سکتا ہے۔ بشریٰ کو آٹو اسٹارٹ اور بیک گراؤنڈ میں چلنے دیں۔';
  }

  @override
  String get permChannelsTitle => 'اطلاعی زمرے اور آواز';

  @override
  String get permChannelsDesc =>
      'کچھ اطلاعی زمرے بند ہیں۔ اذان سننے کے لیے انہیں آن کریں۔';

  @override
  String get permAllowAll => 'سب کی اجازت دیں';

  @override
  String get permAllow => 'اجازت';

  @override
  String get permGranted => 'اجازت مل گئی';

  @override
  String get permContinue => 'جاری رکھیں';

  @override
  String get permLater => 'بعد میں';

  @override
  String get permAllSet => 'سب تیار! اطلاعات بھروسے سے ملیں گی۔';

  @override
  String get permMissingNote =>
      'کچھ اجازتیں ابھی بند ہیں۔ اطلاعات دیر سے آ سکتی ہیں یا نہیں آئیں گی۔';

  @override
  String get permFix => 'ابھی درست کریں';

  @override
  String get adhanStopAction => 'اذان بند کریں';

  @override
  String get adhanBannerTitle => 'اذان بینر';

  @override
  String get adhanBannerDesc =>
      'اذان کے وقت اسکرین کے اوپر اور لاک اسکرین پر ظاہر ہوتا ہے، جس میں اذان بند کرنے کا بٹن ہوتا ہے۔';

  @override
  String get adhanBannerPreview => 'بینر کا پیش منظر';

  @override
  String get adhanBannerVerse =>
      'بے شک نماز مومنوں پر مقررہ اوقات میں فرض کی گئی ہے۔';

  @override
  String get notifSettingsTitle => 'اطلاعات اور اذان';

  @override
  String get modeSilent => 'خاموش';

  @override
  String get modeShort => 'مختصر الرٹ';

  @override
  String get modeAdhan => 'مکمل اذان';

  @override
  String get modeSilentDesc => 'بغیر آواز کی اطلاع';

  @override
  String get modeShortDesc => 'عام اطلاع کی آواز';

  @override
  String get modeAdhanDesc => 'مکمل اذان، روکنے کے بٹن کے ساتھ';

  @override
  String minutesShort(int minutes) {
    return '$minutes منٹ';
  }

  @override
  String get remindersSection => 'روزانہ یاددہانیاں';

  @override
  String afterFajrDesc(int minutes) {
    return 'فجر کے $minutes منٹ بعد';
  }

  @override
  String afterAsrDesc(int minutes) {
    return 'عصر کے $minutes منٹ بعد (غروب سے پہلے)';
  }

  @override
  String get ayahReminderTitle => 'آج کی آیت';

  @override
  String get ayahReminderDesc => 'ہر روز آپ کے منتخب وقت پر ایک نئی آیت';

  @override
  String get reminderTime => 'وقت';

  @override
  String get muadhinTitle => 'مؤذن';

  @override
  String get atAdhanTime => 'اذان کے وقت';

  @override
  String get advancedSection => 'درستگی اور حساب';

  @override
  String get calcMethodTitle => 'حساب کا طریقہ';

  @override
  String get calcMethodAuto => 'خودکار (آپ کے مقام کے مطابق)';

  @override
  String get asrSchoolTitle => 'عصر کا حساب';

  @override
  String get asrStandard => 'معیاری (شافعی، مالکی، حنبلی)';

  @override
  String get asrHanafi => 'حنفی';

  @override
  String get adjustTimesTitle => 'اوقات کی باریک ترتیب (منٹ)';

  @override
  String get testAdhanButton => 'ابھی اذان آزمائیں';

  @override
  String get locationFallbackWarning =>
      'آپ کا مقام دستیاب نہیں، اس لیے اوقات مکہ کے لیے شمار کیے گئے ہیں۔ درست اوقات کے لیے لوکیشن آن کریں۔';

  @override
  String get sadaqaJariyaTitle => 'صدقۂ جاریہ';

  @override
  String get sadaqaHadith =>
      '«جس نے کسی نیکی کی رہنمائی کی اسے نیکی کرنے والے کے برابر اجر ملے گا»';

  @override
  String get narratedByMuslim => 'روایت: مسلم';

  @override
  String get yourInviteCode => 'آپ کا دعوتی کوڈ';

  @override
  String get codeCopied => 'کوڈ کاپی ہو گیا';

  @override
  String get shareAppButton => 'ایپ شیئر کریں';

  @override
  String get shareViaWhatsApp => 'واٹس ایپ پر شیئر کریں';

  @override
  String get startFirstShare => 'اپنی پہلی شیئرنگ شروع کریں 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'آپ نے $count بار ایپ شیئر کی — اللہ قبول فرمائے';
  }

  @override
  String get haveFriendCode => 'کیا دوست کا دعوتی کوڈ ہے؟';

  @override
  String recordedInviteFrom(Object code) {
    return 'دعوت نامہ $code درج ہو گیا — جزاکم اللہ خیراً';
  }

  @override
  String get invalidInviteCode => 'غلط کوڈ (مثال: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'یہ آپ کا اپنا کوڈ ہے 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'میں نے اذان، قرآن اور اذکار کے لیے «بشریٰ» ایپ استعمال کی اور اس کی سفارش کرتا ہوں 🌙\nاسے صدقۂ جاریہ کے طور پر شیئر کریں — «جس نے کسی نیکی کی رہنمائی کی اسے نیکی کرنے والے کے برابر اجر ملے گا»\n\n$link\nدعوتی کوڈ: $code';
  }

  @override
  String get diagTitle => 'کیا اذان کی آواز آئے گی؟';

  @override
  String get diagAllGood => 'سب کچھ درست ہے — اذان ان شاء اللہ وقت پر بجے گی';

  @override
  String diagCanImprove(Object count) {
    return 'اذان غالبًا بجے گی، لیکن $count چیزوں کو بہتر کیا جا سکتا ہے';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count مسائل اذان کو روک سکتے ہیں — نیچے بٹنوں سے حل کریں';
  }

  @override
  String get diagFix => 'درست کریں';

  @override
  String get diagTestAdhanNow => 'ابھی اذان کا ٹیسٹ کریں';

  @override
  String get diagReschedule => 'دوبارہ شیڈول کریں';

  @override
  String get diagRecentEvents => 'حالیہ واقعات';

  @override
  String get diagNoEvents => 'ابھی تک کوئی واقعہ نہیں ہے';

  @override
  String get diagCopyReport => 'سپورٹ کے لیے رپورٹ کاپی کریں';

  @override
  String get diagReportCopied =>
      'سپورٹ رپورٹ کاپی ہو گئی — واٹس ایپ میں پیسٹ کریں';

  @override
  String get diagNotifications => 'اطلاعات (نوٹیفکیشن)';

  @override
  String get diagNotifEnabled => 'فعال';

  @override
  String get diagNotifBlocked => 'بند ہیں — اذان ظاہر نہیں ہو سکے گی';

  @override
  String get diagEnable => 'فعال کریں';

  @override
  String get diagChannels => 'نوٹیفکیشن چینلز';

  @override
  String get diagChannelsAllEnabled => 'تمام فعال ہیں';

  @override
  String get diagChannelMuted => 'موبائل کی ترتیبات میں ایک چینل خاموش ہے';

  @override
  String get diagOpenSettings => 'سیٹنگز کھولیں';

  @override
  String get diagExactAlarms => 'درست الارم';

  @override
  String get diagExactAlarmsAllowed => 'اجازت ہے — اذان بالکل وقت پر بجے گی';

  @override
  String get diagExactAlarmsNotAllowed =>
      'اجازت نہیں — اذان تاخیر سے ہو سکتی ہے';

  @override
  String get diagAllow => 'اجازت دیں';

  @override
  String get diagBattery => 'بیٹری آپٹیمائزیشن';

  @override
  String get diagBatteryExempt => 'ایپ مستثنیٰ ہے';

  @override
  String get diagBatteryMayKill => 'سسٹم بیک گراؤنڈ میں ایپ بند کر سکتا ہے';

  @override
  String get diagExempt => 'استثناء دیں';

  @override
  String get diagPrayerMode => 'نماز موڈ';

  @override
  String get diagPrayerModeFullSilence =>
      'مکمل خاموشی تیار ہے (Do Not Disturb کی اجازت ہے)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'بغیر اجازت ہم صرف وائبریشن موڈ پر جا سکتے ہیں';

  @override
  String get diagGrantPermission => 'اجازت دیں';

  @override
  String get diagAutostart => 'خودکار آغاز (Auto-start)';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'ترتیب دیا گیا ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return '$brand ڈیوائس ایپس کو بند کر دیتی ہے — آٹو سٹارٹ فعال کریں';
  }

  @override
  String get diagOpen => 'کھولیں';

  @override
  String get diagLocation => 'مقام';

  @override
  String diagLocationManual(Object city) {
    return 'دستی منتخب شدہ شہر: $city';
  }

  @override
  String get diagLocationApprox => 'تخمینی';

  @override
  String get diagLocationUnknown =>
      'نامعلوم — پہلے سے طے شدہ شہر استعمال ہو رہا ہے';

  @override
  String get diagLocationGpsOff => 'مقام کی سروس (GPS) بند ہے';

  @override
  String get diagLocationDenied => 'مقام کی اجازت مسترد ہے';

  @override
  String get diagLocationPermanentlyDenied =>
      'اجازت مستقل طور پر مسترد — ترتیبات کھولیں';

  @override
  String get diagLocationNoFix =>
      'ڈیوائس مقام کا تعین نہیں کر سکی (کمزور سگنل)';

  @override
  String get diagLocationMock => 'فرضی لوکیشن فعال ہے — نظر انداز کیا گیا';

  @override
  String get diagLocationTzMismatch => 'مقام ڈیوائس کے ٹائم زون سے متصادم ہے';

  @override
  String get diagFixLocation => 'مقام درست کریں';

  @override
  String get diagSetLocation => 'متعین کریں';

  @override
  String get diagLastScheduling => 'آخری شیڈولنگ';

  @override
  String get diagNeverScheduled => 'ابھی تک شیڈول نہیں ہوا';

  @override
  String get diagScheduleNow => 'ابھی شیڈول کریں';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count تنبیہات';
  }

  @override
  String get diagScheduleIncomplete => 'نامکمل (آف لائن حساب)';

  @override
  String get diagScheduleError => 'خرابی پیش آگئی';

  @override
  String get diagNextAdhan => 'اگلی اذان';

  @override
  String get diagAllPrayersSilent =>
      'تمام نمازیں مختصر/خاموش پر سیٹ ہیں (مکمل اذان نہیں)';

  @override
  String diagArmedAdhansCount(Object count) {
    return 'سسٹم میں $count اذانیں شیڈول ہیں';
  }

  @override
  String get diagNoAdhanArmed =>
      'الارم میں کوئی اذان شیڈول نہیں! شیڈول پر ٹیپ کریں';

  @override
  String get diagOfflineMode => 'آف لائن موڈ';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count ماہ محفوظ ہیں — انٹرنیٹ کے بغیر کام کرے گا';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'صرف $count ماہ محفوظ ہے (آن لائن ہونے پر مکمل ہوگا)';
  }

  @override
  String get diagInternet => 'انٹرنیٹ';

  @override
  String get diagInternetConnected => 'نماز کے اوقات کے سرور سے منسلک ہے';

  @override
  String get diagInternetUnavailable =>
      'ابھی دستیاب نہیں — محفوظ شدہ اوقات کافی ہیں';

  @override
  String get diagTestAdhanTitle => 'اذان کا ٹیسٹ';

  @override
  String get diagTestAdhanBody => 'اگر آپ نے آواز سنی تو سب درست ہے';

  @override
  String get diagStop => 'روکیں';

  @override
  String get diagAgoJustNow => 'ابھی';

  @override
  String diagAgoMinutes(Object m) {
    return '$m منٹ پہلے';
  }

  @override
  String diagAgoHours(Object h) {
    return '$h گھنٹے پہلے';
  }

  @override
  String diagAgoDays(Object d) {
    return '$d دن پہلے';
  }

  @override
  String get zakatCalculatorTitle => 'زکوٰۃ کیلکولیٹر';

  @override
  String get zakatCurrency => 'کرنسی';

  @override
  String get zakatTodayPricesGram => 'آج کی قیمتیں (فی گرام)';

  @override
  String get zakatRefresh => 'تازہ کریں';

  @override
  String get zakatEditManually => 'دستی ترمیم';

  @override
  String get zakatCouldNotLoadPrices =>
      'قیمتیں لوڈ نہیں ہو سکیں (انٹرنیٹ نہیں ہے)۔ فی گرام قیمت درج کرنے کے لیے ✏️ دبائیں۔';

  @override
  String get zakatGold24 => '24 قیراط سونا';

  @override
  String get zakatGold21 => '21 قیراط سونا';

  @override
  String get zakatGold18 => '18 قیراط سونا';

  @override
  String get zakatSilver => 'چاندی';

  @override
  String get zakatGram => 'گرام';

  @override
  String get zakatUsingManualPrices =>
      '✏️ آپ کی دستی درج کردہ قیمتیں استعمال ہو رہی ہیں';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'عالمی قیمت × شرح تبادلہ — اپ ڈیٹ: $date';
  }

  @override
  String get zakatPriceOld => ' (پرانا)';

  @override
  String get zakatNisab => 'نصاب';

  @override
  String get zakatGoldNisab => 'سونا (85 گرام)';

  @override
  String get zakatSilverNisab => 'چاندی (595 گرام)';

  @override
  String get zakatNisabExplanation =>
      'اپنے معتبر دارالافتاء کے فتوے کے مطابق نصاب منتخب کریں۔ چاندی کا نصاب کم قیمت ہے اس لیے زیادہ مستحقین کو فائدہ پہنچاتا ہے۔';

  @override
  String get zakatYourWealth => 'آپ کا مال و دولت';

  @override
  String get zakatCashSavings => 'نقدی، بچت اور بینک اکاؤنٹس';

  @override
  String get zakatSharesInvestments => 'حصص (شیئرز)، سرمایہ کاری اور فنڈز';

  @override
  String get zakatTradeGoods => 'مالِ تجارت (مارکیٹ ویلیو کے مطابق)';

  @override
  String get zakatMoneyOwedToYou => 'وہ قرض جو آپ کو واپس ملنے کی امید ہے';

  @override
  String get zakatDebtsDue =>
      'وہ قرض جو آپ پر ابھی واجب الادا ہیں (منہا کیے جائیں گے)';

  @override
  String get zakatJewelleryNote =>
      'استعمالی زیورات کی زکوٰۃ میں علماء کا اختلاف ہے؛ اگر آپ کے مسلک میں زکوٰۃ نہیں ہے تو سونے کے خانے خالی چھوڑ دیں۔';

  @override
  String get zakatTotalZakatableWealth => 'کل قابلِ زکوٰۃ مال';

  @override
  String get zakatEnterPriceForNisab =>
      'نصاب کا حساب لگانے کے لیے سونے/چاندی کی قیمت درج کریں';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'نصاب: $amount $cur';
  }

  @override
  String get zakatDue25 => 'واجب الادا زکوٰۃ (2.5%)';

  @override
  String get zakatHawlCondition =>
      'بشرطیکہ اس مال پر پورا ایک قمری سال (حول) گزر چکا ہو۔';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'مال نصاب تک نہیں پہنچا ($amount $cur کم ہے) — فی الحال زکوٰۃ واجب نہیں۔';
  }

  @override
  String get zakatCopyResult => 'نتیجہ کاپی کریں';

  @override
  String get zakatResultCopied => 'نتیجہ کاپی ہو گیا';

  @override
  String get zakatYearlyReminder => 'سالانہ زکوٰۃ یاد دہانی';

  @override
  String get zakatReminderExplanation =>
      'وہ تاریخ منتخب کریں جب آپ کا مال نصاب کو پہنچا تھا۔ ہم سال مکمل ہونے سے ایک ہفتہ قبل اور اسی دن یاد دلائیں گے۔';

  @override
  String get zakatSetDate => 'تاریخ منتخب کریں';

  @override
  String zakatNextDue(Object date) {
    return 'اگلا حول: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'تنبیہ: یہ کیلکولیٹر عمومی رہنمائی کے لیے ہے۔ خصوصی معاملات (کمپنی شیئرز، جائیدادِ تجارت وغیرہ) کے لیے علماء سے رجوع فرمائیں۔';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'مقامی دستی قیمتیں ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'آپ کے مقامی صرافہ بازار کی قیمت عالمی قیمت سے مختلف ہو سکتی ہے۔ فی گرام قیمت خود درج کریں یا خودکار رہنے دیں۔';

  @override
  String get zakatGold24PerGram => '24 قیراط سونا فی گرام';

  @override
  String get zakatSilverPerGram => 'چاندی فی گرام';

  @override
  String get zakatPickHawlHelp => 'وہ تاریخ جب آپ کا مال نصاب تک پہنچا';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'زکوٰۃ کیلکولیشن — بُشریٰ ایپ\nکل قابلِ زکوٰۃ مال: $total $cur\nنصاب ($nisabType): $nisabVal $cur\nواجب الادا زکوٰۃ (2.5%): $due $cur';
  }

  @override
  String get trackerTitle => 'نماز ٹریکر';

  @override
  String get trackerTimeNotStarted => 'ابھی اس نماز کا وقت شروع نہیں ہوا 🌙';

  @override
  String get trackerLearningHabits => '🧠 آپ کی عادات کا تجزیہ';

  @override
  String get trackerLearningDesc =>
      'کم از کم 5 دن تک اپنی نمازیں درج کریں، ہم آپ کے مطابق تجاویز دیں گے (سارا تجزیہ صرف آپ کے فون پر ہوتا ہے)۔';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 فجر قضا ہو رہی ہے: آخری $days دنوں میں سے $missed بار';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'جلدی سونے کی یاد دہانی ہر رات $time بجے فعال ہے۔ اللہ مدد فرمائے 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'فجر چھوٹنے کی عام وجہ دیر سے سونا ہے۔ کیا آپ چاہتے ہیں کہ ہم روزانہ رات کو جلدی سونے کی یاد دلائیں؟';

  @override
  String trackerTurnOnTime(Object time) {
    return 'فعال کریں ($time)';
  }

  @override
  String get trackerNotNow => 'ابھی نہیں';

  @override
  String get trackerChangeTime => 'وقت بدلیں';

  @override
  String get trackerTurnOff => 'بند کریں';

  @override
  String get trackerPickAnotherTime => 'کوئی دوسرا وقت منتخب کریں';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer اکثر آخری وقت میں ادا ہو رہی ہے';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'ہم نے $prayer کی ہلکی یاد دہانی کو وقت کے درمیان میں کر دیا تاکہ نماز قضا نہ ہو۔';
  }

  @override
  String get trackerGreatConsistency => '✨ آپ کی پابندی شاندار ہے';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 سب سے زیادہ قضا ہونے والی نماز: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'کوئی نماز بار بار نہیں چھوٹ رہی۔ ماشاءاللہ جاری رکھیں!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'آخری $days دنوں میں $missed بار چھوٹ گئی۔ نرم یاد دہانی اس میں مدد کرے گی۔';
  }

  @override
  String get trackerTurnOffNudge => 'نرم یاد دہانی بند کریں';

  @override
  String get trackerTurnOnNudge => 'نرم یاد دہانی چالو کریں';

  @override
  String get trackerStopLearning => 'میری عادات کا تجزیہ بند کریں';

  @override
  String get trackerStartLearning => 'میری عادات کا تجزیہ فعال کریں';

  @override
  String get trackerStartStreakToday => 'آج سے اپنا سلسلہ شروع کریں';

  @override
  String trackerStreakDays(Object count) {
    return 'مسلسل $count دن تمام پانچوں نمازیں';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'بہترین سلسلہ: $best — اس ہفتے: $pct%';
  }

  @override
  String get trackerToday => 'آج';

  @override
  String get trackerYesterday => 'کل (گزشتہ)';

  @override
  String get trackerYourGarden => 'آپ کا باغ 🌳';

  @override
  String get trackerGardenDesc =>
      'ہر نماز کا ایک درخت ہے جو آپ کی پابندی کے ساتھ بڑھتا ہے';

  @override
  String get trackerDayUnit => 'دن';

  @override
  String get trackerTodayPrayers => 'آج کی نمازیں';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'نمازیں $date';
  }

  @override
  String get trackerPrayedMark => 'پڑھ لی ✓';

  @override
  String get trackerNotMarked => 'درج نہیں ہوئی';

  @override
  String get trackerThisWeek => 'اس ہفتے کے اعداد و شمار';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'کل درج شدہ نمازیں: $count';
  }

  @override
  String get gardenTitle => 'میرا باغ';

  @override
  String get gardenHomeCardTitle => 'آپ کا نماز کا باغ 🌳';

  @override
  String get gardenEnterFull => 'اپنے مکمل باغ میں داخل ہوں 🌿';

  @override
  String get gardenTooEarlySeed => 'ابھی وقت باقی ہے… بیج منتظر ہے 🌱';

  @override
  String get gardenChooseMonth => 'مہینہ منتخب کریں';

  @override
  String get gardenOf => 'باغِ';

  @override
  String get gardenHijriSuffix => 'ھ';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count مکمل دن';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'بہترین سلسلہ $count';
  }

  @override
  String get gardenBlessedForest => 'ایک بابرکت جنگل';

  @override
  String gardenWeekNumber(Object num) {
    return 'ہفتہ $num';
  }

  @override
  String get gardenMsgFlourishing => 'ماشاءاللہ! ایک سرسبز و شاداب باغ 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'آپ کا باغ خوبصورت ہے — جاری رکھیں، یہ ایک بڑا باغ بن جائے گا 🌿';

  @override
  String get gardenMsgWaterToday =>
      'ہر نماز درخت کو پانی دیتی ہے۔ آج ہی سے شروع کریں 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'باغ منتظر ہے… پہلی نماز پہلا پودا لگائے گی 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'پڑھ لی ✓ $time پر';
  }

  @override
  String get plantStatusPrayed => 'پڑھ لی ✓';

  @override
  String get plantStatusPending => 'وقت شروع ہو گیا ہے — ابھی درج نہیں کی 💧';

  @override
  String get plantStatusMissed => 'درج نہیں ہوئی — درخت کو پانی کی ضرورت ہے';

  @override
  String get plantStatusUpcoming => 'ابھی وقت نہیں ہوا 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'پھلدار درخت! $prayer پر مسلسل $streak دن 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return 'ایک ہفتہ یا زائد — $prayer پر مسلسل $streak دن 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return '$prayer کی پابندی کا دن نمبر $streak';
  }

  @override
  String get plantWaterConsistency =>
      'ہر نماز درخت کو بڑا کرتی ہے — آپ کی پابندی اس کا پانی ہے 💧';

  @override
  String get plantUndo => 'منسوخ کریں';

  @override
  String get plantWaterAction => 'میں نے پڑھ لی — پودے کو پانی دیں 💧';

  @override
  String get plantStageSeed => 'بیج';

  @override
  String get plantStageSprout => 'کونپل';

  @override
  String get plantStageSapling => 'پودا';

  @override
  String get plantStageYoungTree => 'چھوٹا درخت';

  @override
  String get plantStageTree => 'درخت';

  @override
  String get plantStageFruitTree => 'پھلدار درخت';

  @override
  String get treeCherryBlossom => 'چیری کا درخت';

  @override
  String get treeDatePalm => 'کھجور کا درخت';

  @override
  String get treeOrangeTree => 'مالٹے کا درخت';

  @override
  String get treePomegranate => 'انار کا درخت';

  @override
  String get treeCypress => 'سرو کا درخت';

  @override
  String get weeklySummaryTitle => 'ہفتہ وار خلاصہ';

  @override
  String get weeklyShareAsImage => 'تصویر کے طور پر شیئر کریں';

  @override
  String get weeklyNoPrayersLogged =>
      'اس ہفتے ابھی تک کوئی نماز درج نہیں ہوئی۔ ہوم اسکرین کے باغیچے سے آغاز کریں 🌱';

  @override
  String get weeklyShareYourTree => 'اپنے ہفتے کا درخت شیئر کریں';

  @override
  String get weeklyNotificationHint =>
      'ہر جمعہ عشاء کے بعد آپ کو ہفتہ وار خلاصے کی اطلاع ملتی ہے۔ دوسروں کی ترغیب کے لیے اسے شیئر کریں۔';

  @override
  String get weeklyImageError => 'تصویر بنانے میں ناکامی، دوبارہ کوشش کریں';

  @override
  String get weeklyCardTitle => 'میرا ہفتہ وار خلاصہ';

  @override
  String get weeklyCardTreeSubtitle => 'اس ہفتے میرا نماز کا درخت 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return 'ان شاء اللہ $pct% نمازیں وقت پر ادا ہوئیں';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'سب سے پابند نماز: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'کمزور ترین: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 مسلسل $count دن تمام نمازیں';
  }

  @override
  String get weeklyCardAppBranding => 'بشریٰ ایپ — اذان، اذکار اور قرآن';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'آپ نے $max میں سے $total نمازیں پڑھیں';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'آپ کی بہترین نماز: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'اور سب سے کمزور: $prayer';
  }

  @override
  String get amLabel => 'صبح';

  @override
  String get pmLabel => 'شام';
}
