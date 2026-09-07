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

  @override
  String get saveBookmark => 'ذخیره نشانک';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'نشانک در سوره $surahName آیه $ayahNumber ذخیره شد';
  }

  @override
  String get qiblaDirection => 'جهت قبله';

  @override
  String get qiblaAccurate => 'قبله دقیق است';

  @override
  String get youAreFacingQibla => 'اکنون رو به قبله هستید';

  @override
  String get qiblaCalibration => 'کالیبراسیون قبله';

  @override
  String get qiblaCalibrationDesc =>
      'لطفاً تلفن خود را به آرامی به شکل 8 حرکت دهید تا قطب نما کالیبره شود.';

  @override
  String get findingLocation => 'در حال یافتن مکان...';

  @override
  String get locationPermissionError =>
      'امکان دسترسی به مکان وجود ندارد. لطفاً GPS را فعال کنید.';

  @override
  String get locationPermissionTitle => 'Allow Location Access';

  @override
  String get locationPermissionDesc =>
      'We need your location to accurately calculate the Qibla direction based on your current position.';

  @override
  String get preciseQibla => 'قبله دقیق';

  @override
  String get exactLocation => 'مکان دقیق شما';

  @override
  String get alwaysUpToDate => 'همیشه به‌روز';

  @override
  String get allowLocationBtn => 'اجازه دسترسی';

  @override
  String get notNow => 'الان نه';

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
  String get moreScreenTitle => 'بیشتر';

  @override
  String get generalSettings => 'عمومی';

  @override
  String get appearance => 'ظاهر';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

  @override
  String get appLanguage => 'زبان برنامه';

  @override
  String get alertsSettings => 'هشدارها';

  @override
  String get notifications => 'اعلان‌ها';

  @override
  String get adhanAndReminders => 'اذان و یادآوری‌ها';

  @override
  String get dataAndStorage => 'داده‌ها و ذخیره‌سازی';

  @override
  String get storage => 'ذخیره‌سازی';

  @override
  String get storageDesc => 'مدیریت سوره‌های دانلود شده';

  @override
  String get infoAndSupport => 'اطلاعات و پشتیبانی';

  @override
  String get privacyAndPermissions => 'حریم خصوصی و مجوزها';

  @override
  String get aboutBoshra => 'درباره بشری';

  @override
  String get downloadedOption => 'دانلود شده';

  @override
  String get totalUsed => 'کل استفاده شده';

  @override
  String get systemApp => 'سیستم (برنامه)';

  @override
  String get downloadedSurahs => 'سوره‌های دانلود شده';

  @override
  String get cache => 'حافظه پنهان';

  @override
  String get manageDownloads => 'مدیریت دانلودها';

  @override
  String get clearCache => 'پاک کردن حافظه پنهان';

  @override
  String get clearAllDownloads => 'پاک کردن تمام دانلودها';

  @override
  String get clearWarning => 'این کار تمام محتوای دانلود شده را حذف می‌کند.';

  @override
  String get notEnoughSpace => 'فضای کافی وجود ندارد (محدودیت ۳ گیگابایت).';

  @override
  String get clearCacheWarning =>
      'آیا مطمئن هستید؟ داده‌های موقت پاک خواهند شد.';

  @override
  String get clearAllData => 'پاک کردن تمام داده‌ها';

  @override
  String get clearDataWarning =>
      'آیا مطمئن هستید؟ برنامه به حالت اولیه باز می‌گردد.';

  @override
  String get yesClear => 'بله، پاک کن';

  @override
  String get cancel => 'لغو';

  @override
  String get yourPrivacyMatters => 'حریم خصوصی شما برای ما مهم است.';

  @override
  String get privacyRequestsDesc =>
      'بشرى فقط مجوزهای موردنیاز برای ارائه قابلیت‌های خود را درخواست می‌کند.';

  @override
  String get permissions => 'مجوزها';

  @override
  String get locationPermDesc =>
      'برای محاسبه دقیق اوقات نماز و تعیین جهت قبله بر اساس موقعیت شما استفاده می‌شود.';

  @override
  String get statusAllowed => 'مجاز';

  @override
  String get statusDenied => 'رد شده';

  @override
  String get notificationsPermDesc =>
      'برای ارسال اوقات نماز، اعلان اذان و یادآوری اذکار استفاده می‌شوند.';

  @override
  String get yourData => 'داده‌های شما';

  @override
  String get yourDataDesc1 =>
      'بشرى به ایجاد حساب کاربری یا ورود به حساب نیاز ندارد.';

  @override
  String get yourDataDesc2 =>
      'تنظیمات، محتوای دانلودشده و ترجیحات شما ممکن است برای ارائه قابلیت‌های برنامه به‌صورت محلی روی دستگاه ذخیره شوند.';

  @override
  String get privacy => 'حریم خصوصی';

  @override
  String get privacyPolicyDesc =>
      'با نحوه جمع‌آوری، استفاده، ذخیره و حفاظت از اطلاعات در بشرى آشنا شوید.';

  @override
  String get termsAndConditions => 'شرایط و ضوابط';

  @override
  String get termsDesc => 'شرایط استفاده از بشرى را مطالعه کنید.';

  @override
  String get dataAndPrivacy => 'داده‌ها و حریم خصوصی';

  @override
  String get dataPrivacyDesc =>
      'درباره داده‌هایی که توسط بشرى پردازش می‌شوند و گزینه‌های حریم خصوصی خود بیشتر بدانید.';

  @override
  String get permissionManagement => 'مدیریت مجوزها';

  @override
  String get manageLocationPerm => 'مدیریت مجوز موقعیت مکانی';

  @override
  String get manageLocationDesc =>
      'برای تغییر دسترسی به موقعیت مکانی، تنظیمات دستگاه را باز کنید.';

  @override
  String get manageNotificationsPerm => 'مدیریت مجوز اعلان‌ها';

  @override
  String get manageNotificationsDesc =>
      'برای تغییر دسترسی به اعلان‌ها، تنظیمات دستگاه را باز کنید.';

  @override
  String get localData => 'داده‌های محلی';

  @override
  String get clearLocalDataDesc =>
      'داده‌های محلی بشرى را از این دستگاه حذف کنید.';

  @override
  String get clearDownloadsDesc =>
      'تلاوت‌های قرآن و سایر محتوای دانلودشده برای استفاده آفلاین را حذف کنید.';

  @override
  String get privacyNote => 'یادداشت حریم خصوصی';

  @override
  String get privacyNoteDesc =>
      'بشرى از موقعیت مکانی فقط برای قابلیت‌هایی که به آن نیاز دارند، مانند اوقات نماز و جهت قبله، استفاده می‌کند.';

  @override
  String get boshraTagline => 'همراه روزانه شما برای قرآن، نماز و ذکر.';

  @override
  String get boshraAboutDesc =>
      'بشرى یک برنامه اسلامی است که برای ساده‌تر، آرام‌تر و در دسترس‌تر کردن عبادت روزانه طراحی شده است.';

  @override
  String get whatYouCanDo => 'با بشرى چه کارهایی می‌توانید انجام دهید؟';

  @override
  String get quranDesc => 'قرآن را با تجربه‌ای ساده، خوانا و راحت مطالعه کنید.';

  @override
  String get quranRecitation => 'تلاوت قرآن';

  @override
  String get quranRecitationDesc => 'به تلاوت قاری مورد علاقه خود گوش دهید.';

  @override
  String get azkarDesc => 'اذکار روزانه خود را به‌صورت منظم و ساده دنبال کنید.';

  @override
  String get prayerTimesDesc =>
      'اوقات دقیق نماز را بر اساس موقعیت مکانی خود دریافت کنید.';

  @override
  String get qiblaDesc =>
      'با استفاده از موقعیت مکانی و قطب‌نمای دستگاه، جهت کعبه را پیدا کنید.';

  @override
  String get reminders => 'یادآوری‌ها';

  @override
  String get remindersDesc =>
      'برای حفظ ارتباط با عبادت روزانه، یادآوری‌های مناسب دریافت کنید.';

  @override
  String get appInfo => 'اطلاعات برنامه';

  @override
  String get version => 'نسخه';

  @override
  String get buildNumber => 'Build';

  @override
  String get moreOptions => 'بیشتر';

  @override
  String get rateBoshra => 'امتیاز دادن به بشرى';

  @override
  String get rateBoshraDesc => 'با ثبت نظر خود از بشرى حمایت کنید.';

  @override
  String get shareBoshra => 'اشتراک‌گذاری بشرى';

  @override
  String get shareBoshraDesc =>
      'بشرى را با خانواده و دوستان خود به اشتراک بگذارید.';

  @override
  String get contactUs => 'تماس با ما';

  @override
  String get contactUsDesc => 'با Mahmoud Ashraf در ارتباط باشید.';

  @override
  String get openSourceLicenses => 'مجوزهای متن‌باز';

  @override
  String get openSourceDesc =>
      'مجوزهای نرم‌افزارهای متن‌باز استفاده‌شده در بشرى را مشاهده کنید.';

  @override
  String get madeWithCare =>
      'با دقت برای کسانی ساخته شده است که به دنبال ارتباطی نزدیک‌تر با قرآن و ذکر هستند.';

  @override
  String get locationText => 'مکان';

  @override
  String get privacyPolicyText => 'سیاست حفظ حریم خصوصی';

  @override
  String get clearLocalDataText => 'پاک کردن داده‌های محلی';

  @override
  String get prayerTimesText => 'اوقات شرعی';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeLightDesc => 'رابط کاربری تمیز و روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get themeDarkDesc => 'رابط کاربری تاریک و عمیق';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get themeSystemDesc => 'پیروی از تنظیمات دستگاه';

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
