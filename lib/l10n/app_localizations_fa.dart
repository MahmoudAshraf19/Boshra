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
  String get navRadio => 'رادیو';

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
  String get live => 'زنده';

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
  String get azkarScreenTitle => 'اذکار';

  @override
  String get azkarScreenSubtitle => 'نزدیک به خدا… در هر لحظه';

  @override
  String get azkarCategoryMorning => 'اذکار صبحگاه';

  @override
  String get azkarCategoryMorningSub => 'ذکرهای صبحگاهی';

  @override
  String get azkarCategoryEvening => 'اذکار شامگاه';

  @override
  String get azkarCategoryEveningSub => 'ذکرهای شامگاهی';

  @override
  String get azkarCategoryPrayer => 'پس از نماز';

  @override
  String get azkarCategoryPrayerSub => 'ذکرهای پس از نماز';

  @override
  String get azkarCategorySleep => 'اذکار خواب';

  @override
  String get azkarCategorySleepSub => 'ذکرهای پیش از خواب';

  @override
  String get azkarCategoryProtection => 'اذکار حفاظت';

  @override
  String get azkarCategoryProtectionSub => 'برای حفاظت و آرامش';

  @override
  String get azkarCategoryDaily => 'اذکار روزانه';

  @override
  String get azkarCategoryDailySub => 'ذکرهای گوناگون برای روز';

  @override
  String get azkarAllCategories => 'همه دسته‌ها';

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
  String get locationPermissionTitle => 'اجازه دسترسی به موقعیت';

  @override
  String get locationPermissionDesc =>
      'برای محاسبه دقیق جهت قبله از موقعیت فعلی شما به مکان‌یابی نیاز داریم.';

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
  String get startupLocationTitle => 'دسترسی به موقعیت';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'برای دقیق بودن اوقات نماز و جهت قبله به موقعیت شما نیاز داریم.\n\nدر صورت عدم اجازه، از آخرین موقعیت ذخیره‌شده یعنی $locationName استفاده می‌کنیم.';
  }

  @override
  String get startupLocationDescDefault =>
      'برای دقیق بودن اوقات نماز و جهت قبله به موقعیت شما نیاز داریم.\n\nدر صورت عدم اجازه، از موقعیت پیش‌فرض یعنی مکه مکرمه، عربستان سعودی استفاده می‌کنیم.';

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
  String get soundType => 'نوع اعلان';

  @override
  String get soundSilent => 'بی‌صدا';

  @override
  String get soundShort => 'صدای کوتاه';

  @override
  String get soundAdhan => 'اذان کامل';

  @override
  String get prePrayerAlertDesc => 'پیش از اذان به من هشدار بده';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'وقت نماز $prayerName فرا رسید';
  }

  @override
  String get prayerNotifBody => 'به سوی نماز بشتاب';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return 'نماز $prayerName نزدیک است';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return '$minutes دقیقه تا اذان باقی مانده است';
  }

  @override
  String get notifDisabledTitle => 'اعلان‌ها خاموش هستند';

  @override
  String get notifDisabledDesc =>
      'اعلان‌ها را روشن کنید تا اذان و یادآورها به‌موقع برسند.';

  @override
  String get exactAlarmTitle => 'هشدارهای دقیق خاموش است';

  @override
  String get exactAlarmDesc =>
      '«هشدارها و یادآورها» را مجاز کنید تا اذان دقیقاً سر وقت برسد.';

  @override
  String get openSettings => 'باز کردن تنظیمات';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get errorGeneric => 'مشکلی پیش آمد. دوباره تلاش کنید.';

  @override
  String get errorNoInternet =>
      'اتصال اینترنت وجود ندارد. اتصال خود را بررسی و دوباره تلاش کنید.';

  @override
  String get errorLoadFailed => 'بارگذاری محتوا ممکن نشد.';

  @override
  String get downloadingProgress => 'در حال دانلود…';

  @override
  String get downloadSuccess => 'دانلود با موفقیت انجام شد';

  @override
  String get downloadFailed => 'دانلود ناموفق بود. دوباره تلاش کنید.';

  @override
  String get shareFailed => 'ساخت تصویر ممکن نشد. دوباره تلاش کنید.';

  @override
  String get audioLoadFailed => 'پخش صدا ممکن نشد. اتصال را بررسی کنید.';

  @override
  String get radioLoadFailed => 'بارگذاری ایستگاه‌ها ممکن نشد';

  @override
  String get continueReadingBtn => 'ادامه مطالعه';

  @override
  String get permSetupTitle => 'هیچ نمازی را از دست نده';

  @override
  String get permSetupSubtitle =>
      'چند مجوز را یک بار بدهید تا اذان و یادآورها همیشه سر وقت برسند، حتی وقتی برنامه بسته است.';

  @override
  String get permNotifTitle => 'اعلان‌ها';

  @override
  String get permNotifDesc =>
      'برای نمایش اذان، یادآور نماز، اذکار و پیام‌های قرآنی.';

  @override
  String get permExactTitle => 'هشدارها و یادآورها';

  @override
  String get permExactDesc =>
      'به اندروید اجازه می‌دهد اذان را دقیقاً در دقیقهٔ مشخص پخش کند.';

  @override
  String get permBatteryTitle => 'باتری بدون محدودیت';

  @override
  String get permBatteryDesc =>
      'از خواباندن برنامه و حذف اعلان‌ها توسط سیستم جلوگیری می‌کند.';

  @override
  String get permAutostartTitle => 'اجرای خودکار و پس‌زمینه';

  @override
  String permAutostartDesc(String brand) {
    return 'گوشی شما ($brand) ممکن است برنامه‌های پس‌زمینه را مسدود کند. اجازه دهید بشرى خودکار اجرا شود و در پس‌زمینه کار کند.';
  }

  @override
  String get permChannelsTitle => 'دسته‌های اعلان و صدا';

  @override
  String get permChannelsDesc =>
      'برخی دسته‌های اعلان خاموش هستند. برای شنیدن اذان آن‌ها را روشن کنید.';

  @override
  String get permAllowAll => 'اجازه به همه';

  @override
  String get permAllow => 'اجازه';

  @override
  String get permGranted => 'مجاز';

  @override
  String get permContinue => 'ادامه';

  @override
  String get permLater => 'بعداً';

  @override
  String get permAllSet => 'همه چیز آماده است! اعلان‌ها به‌طور مطمئن می‌رسند.';

  @override
  String get permMissingNote =>
      'برخی مجوزها هنوز خاموش‌اند. ممکن است اعلان‌ها دیر برسند یا نرسند.';

  @override
  String get permFix => 'رفع مشکل';

  @override
  String get adhanStopAction => 'توقف اذان';

  @override
  String get adhanBannerTitle => 'نوار اذان';

  @override
  String get adhanBannerDesc =>
      'در زمان اذان، بالای صفحه و روی صفحه قفل نمایش داده می‌شود و دکمه‌ای برای توقف اذان دارد.';

  @override
  String get adhanBannerPreview => 'پیش‌نمایش نوار';

  @override
  String get adhanBannerVerse =>
      'همانا نماز بر مؤمنان در اوقات معیّن واجب شده است.';

  @override
  String get notifSettingsTitle => 'اعلان‌ها و اذان';

  @override
  String get modeSilent => 'بی‌صدا';

  @override
  String get modeShort => 'هشدار کوتاه';

  @override
  String get modeAdhan => 'اذان کامل';

  @override
  String get modeSilentDesc => 'اعلان بدون صدا';

  @override
  String get modeShortDesc => 'صدای معمولی اعلان';

  @override
  String get modeAdhanDesc => 'اذان کامل با دکمه توقف';

  @override
  String minutesShort(int minutes) {
    return '$minutes دقیقه';
  }

  @override
  String get remindersSection => 'یادآوری‌های روزانه';

  @override
  String afterFajrDesc(int minutes) {
    return '$minutes دقیقه پس از فجر';
  }

  @override
  String afterAsrDesc(int minutes) {
    return '$minutes دقیقه پس از عصر (پیش از غروب)';
  }

  @override
  String get ayahReminderTitle => 'آیه امروز';

  @override
  String get ayahReminderDesc =>
      'هر روز یک آیه جدید در زمانی که انتخاب می‌کنید';

  @override
  String get reminderTime => 'زمان';

  @override
  String get muadhinTitle => 'مؤذن';

  @override
  String get atAdhanTime => 'همزمان با اذان';

  @override
  String get advancedSection => 'دقت و محاسبه';

  @override
  String get calcMethodTitle => 'روش محاسبه اوقات';

  @override
  String get calcMethodAuto => 'خودکار (بر اساس موقعیت شما)';

  @override
  String get asrSchoolTitle => 'محاسبه عصر';

  @override
  String get asrStandard => 'استاندارد (شافعی، مالکی، حنبلی)';

  @override
  String get asrHanafi => 'حنفی';

  @override
  String get adjustTimesTitle => 'تنظیم دقیق اوقات (دقیقه)';

  @override
  String get testAdhanButton => 'آزمایش اذان اکنون';

  @override
  String get locationFallbackWarning =>
      'موقعیت شما در دسترس نیست و اوقات برای مکه محاسبه شده است. برای اوقات دقیق، موقعیت‌یابی را روشن کنید.';

  @override
  String get sadaqaJariyaTitle => 'صدقه جاریه';

  @override
  String get sadaqaHadith =>
      '«هر که به کار خیری راهنمایی کند، پاداشی همانند انجام‌دهنده آن دارد»';

  @override
  String get narratedByMuslim => 'روایت از مسلم';

  @override
  String get yourInviteCode => 'کد دعوت شما';

  @override
  String get codeCopied => 'کد کپی شد';

  @override
  String get shareAppButton => 'اشتراک‌گذاری برنامه';

  @override
  String get shareViaWhatsApp => 'اشتراک‌گذاری از طریق واتس‌اپ';

  @override
  String get startFirstShare => 'اولین اشتراک‌گذاری خود را آغاز کنید 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'شما $count بار برنامه را به اشتراک گذاشتید — خداوند قبول فرماید';
  }

  @override
  String get haveFriendCode => 'کد دعوتی از دوستان دارید؟';

  @override
  String recordedInviteFrom(Object code) {
    return 'دعوت $code ثبت شد — جزاه الله خیراً';
  }

  @override
  String get invalidInviteCode => 'کد نامعتبر است (مثال: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'این کد خود شماست 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'من از برنامه «بُشریٰ» برای اذان، قرآن و اذکار استفاده می‌کنم و آن را پیشنهاد می‌کنم 🌙\nآن را به عنوان صدقه جاریه به اشتراک بگذارید — «هر که به کار خیری راهنمایی کند، پاداشی همانند انجام‌دهنده آن دارد»\n\n$link\nکد دعوت: $code';
  }

  @override
  String get diagTitle => 'آیا اذان پخش خواهد شد؟';

  @override
  String get diagAllGood =>
      'همه‌چیز مرتب است — اذان به یاری خدا سر وقت پخش می‌شود';

  @override
  String diagCanImprove(Object count) {
    return 'اذان احتمالاً پخش می‌شود، اما $count مورد قابل بهبود است';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count مشکل ممکن است مانع اذان شود — با دکمه‌های زیر حل کنید';
  }

  @override
  String get diagFix => 'رفع مشکل';

  @override
  String get diagTestAdhanNow => 'آزمایش اذان هم‌اکنون';

  @override
  String get diagReschedule => 'زمان‌بندی مجدد';

  @override
  String get diagRecentEvents => 'رویدادهای اخیر';

  @override
  String get diagNoEvents => 'هنوز رویدادی ثبت نشده است';

  @override
  String get diagCopyReport => 'کپی گزارش برای پشتیبانی';

  @override
  String get diagReportCopied => 'گزارش پشتیبانی کپی شد';

  @override
  String get diagNotifications => 'اعلان‌ها';

  @override
  String get diagNotifEnabled => 'فعال';

  @override
  String get diagNotifBlocked => 'مسدود است — اذان پخش نمی‌شود';

  @override
  String get diagEnable => 'فعال‌سازی';

  @override
  String get diagChannels => 'کانال‌های اعلان';

  @override
  String get diagChannelsAllEnabled => 'همه فعال هستند';

  @override
  String get diagChannelMuted =>
      'یکی از کانال‌ها در تنظیمات گوشی بی‌صدا شده است';

  @override
  String get diagOpenSettings => 'باز کردن تنظیمات';

  @override
  String get diagExactAlarms => 'هشدارهای دقیق';

  @override
  String get diagExactAlarmsAllowed =>
      'مجاز است — اذان دقیقاً در ثانیه مقرر پخش می‌شود';

  @override
  String get diagExactAlarmsNotAllowed =>
      'غیرمجاز است — ممکن است اذان با تأخیر پخش شود';

  @override
  String get diagAllow => 'اجازه‌دادن';

  @override
  String get diagBattery => 'بهینه‌سازی باتری';

  @override
  String get diagBatteryExempt => 'برنامه مستثنی است';

  @override
  String get diagBatteryMayKill =>
      'سیستم ممکن است برنامه را در پس‌زمینه متوقف کند';

  @override
  String get diagExempt => 'مستثنی‌کردن';

  @override
  String get diagPrayerMode => 'حالت نماز';

  @override
  String get diagPrayerModeFullSilence =>
      'سکوت کامل آماده است (مجوز عدم مزاحمت دارد)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'بدون مجوز «عدم مزاحمت» فقط حالت لرزش فعال می‌شود';

  @override
  String get diagGrantPermission => 'اعطای مجوز';

  @override
  String get diagAutostart => 'شروع خودکار';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'تنظیم شده است ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return 'دستگاه $brand برنامه‌ها را می‌بندد — شروع خودکار را روشن کنید';
  }

  @override
  String get diagOpen => 'باز کردن';

  @override
  String get diagLocation => 'موقعیت مکانی';

  @override
  String diagLocationManual(Object city) {
    return 'شهر انتخابی دستی: $city';
  }

  @override
  String get diagLocationApprox => 'تقریبی';

  @override
  String get diagLocationUnknown => 'نامشخص — استفاده از شهر پیش‌فرض';

  @override
  String get diagLocationGpsOff => 'سرویس موقعیت مکانی (GPS) خاموش است';

  @override
  String get diagLocationDenied => 'مجوز موقعیت مکانی رد شد';

  @override
  String get diagLocationPermanentlyDenied =>
      'مجوز به طور دائم رد شده است — تنظیمات را باز کنید';

  @override
  String get diagLocationNoFix =>
      'دستگاه نتوانست موقعیت را تعیین کند (سیگنال ضعیف)';

  @override
  String get diagLocationMock => 'موقعیت مکانی جعلی فعال است — نادیده گرفته شد';

  @override
  String get diagLocationTzMismatch =>
      'موقعیت با منطقه زمانی دستگاه ناسازگار است';

  @override
  String get diagFixLocation => 'تنظیم دقیق موقعیت';

  @override
  String get diagSetLocation => 'تعیین';

  @override
  String get diagLastScheduling => 'آخرین زمان‌بندی';

  @override
  String get diagNeverScheduled => 'هنوز زمان‌بندی نشده است';

  @override
  String get diagScheduleNow => 'زمان‌بندی هم‌اکنون';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count هشدار';
  }

  @override
  String get diagScheduleIncomplete => 'ناقص (محاسبه آفلاین)';

  @override
  String get diagScheduleError => 'خطا رخ داد';

  @override
  String get diagNextAdhan => 'اذان بعدی';

  @override
  String get diagAllPrayersSilent =>
      'همه نمازها روی اعلان کوتاه/بی‌صدا تنظیم شده‌اند';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count اذان در سیستم برنامه‌ریزی شده است';
  }

  @override
  String get diagNoAdhanArmed =>
      'هیچ اذانی در سیستم هشدار تنظیم نشده! زمان‌بندی را بزنید';

  @override
  String get diagOfflineMode => 'حالت آفلاین';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count ماه ذخیره شده — بدون اینترنت کار می‌کند';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'فقط $count ماه ذخیره شده (آنلاین تکمیل می‌شود)';
  }

  @override
  String get diagInternet => 'اینترنت';

  @override
  String get diagInternetConnected => 'متصل به سرور اوقات شرعی';

  @override
  String get diagInternetUnavailable =>
      'هم‌اکنون در دسترس نیست — اوقات ذخیره شده کافی است';

  @override
  String get diagTestAdhanTitle => 'تست اذان';

  @override
  String get diagTestAdhanBody =>
      'اگر صدا را می‌شنوید، همه‌چیز درست کار می‌کند';

  @override
  String get diagStop => 'توقف';

  @override
  String get diagAgoJustNow => 'هم‌اکنون';

  @override
  String diagAgoMinutes(Object m) {
    return '$m دقیقه پیش';
  }

  @override
  String diagAgoHours(Object h) {
    return '$h ساعت پیش';
  }

  @override
  String diagAgoDays(Object d) {
    return '$d روز پیش';
  }

  @override
  String get zakatCalculatorTitle => 'محاسبه‌گر زکات';

  @override
  String get zakatCurrency => 'ارز';

  @override
  String get zakatTodayPricesGram => 'قیمت‌های امروز (هر گرم)';

  @override
  String get zakatRefresh => 'بروزرسانی';

  @override
  String get zakatEditManually => 'ویرایش دستی';

  @override
  String get zakatCouldNotLoadPrices =>
      'بارگذاری قیمت‌ها ممکن نشد (آفلاین). برای وارد کردن دستی قیمت روی ✏️ بزنید.';

  @override
  String get zakatGold24 => 'طلای ۲۴ عیار';

  @override
  String get zakatGold21 => 'طلای ۲۱ عیار';

  @override
  String get zakatGold18 => 'طلای ۱۸ عیار';

  @override
  String get zakatSilver => 'نقره';

  @override
  String get zakatGram => 'گرم';

  @override
  String get zakatUsingManualPrices => '✏️ استفاده از قیمت‌های دستی شما';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'قیمت جهانی × نرخ ارز — بروزرسانی: $date';
  }

  @override
  String get zakatPriceOld => ' (قدیمی)';

  @override
  String get zakatNisab => 'نصاب';

  @override
  String get zakatGoldNisab => 'طلا (۸۵ گرم)';

  @override
  String get zakatSilverNisab => 'نقره (۵۹۵ گرم)';

  @override
  String get zakatNisabExplanation =>
      'نصابی را که مرجع دینی مورد اعتمادتان فتوا داده برگزینید. نصاب نقره کمتر است و افراد بیشتری را شامل می‌شود.';

  @override
  String get zakatYourWealth => 'اموال شما';

  @override
  String get zakatCashSavings => 'پول نقد، پس‌انداز و حساب‌های بانکی';

  @override
  String get zakatSharesInvestments => 'سهام، سرمایه‌گذاری‌ها و صندوق‌ها';

  @override
  String get zakatTradeGoods => 'کالای تجاری (به ارزش بازار)';

  @override
  String get zakatMoneyOwedToYou => 'طلب‌های شما که بازپرداخت آن‌ها قطعی است';

  @override
  String get zakatDebtsDue => 'بدهی‌های فوری شما (کسر می‌شود)';

  @override
  String get zakatJewelleryNote =>
      'علما در مورد زکات زیورآلات مورد استفاده اختلاف دارند؛ در صورت عدم وجوب در مذهب شما، فیلدهای طلا را خالی بگذارید.';

  @override
  String get zakatTotalZakatableWealth => 'کل دارایی مشمول زکات';

  @override
  String get zakatEnterPriceForNisab =>
      'برای محاسبه نصاب، قیمت طلا یا نقره را وارد کنید';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'نصاب: $amount $cur';
  }

  @override
  String get zakatDue25 => 'زکات واجب (۲.۵٪)';

  @override
  String get zakatHawlCondition =>
      'به شرط آنکه یک سال قمری کامل (حول) بر آن گذشته باشد.';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'دارایی شما به نصاب نرسیده ($amount $cur کسری دارید) — در حال حاضر زکاتی واجب نیست.';
  }

  @override
  String get zakatCopyResult => 'کپی نتیجه';

  @override
  String get zakatResultCopied => 'نتیجه کپی شد';

  @override
  String get zakatYearlyReminder => 'یادآوری سالانه زکات';

  @override
  String get zakatReminderExplanation =>
      'تاریخ رسیدن دارایی به حد نصاب را انتخاب کنید تا یک هفته قبل و در روز اتمام سال قمری به شما یادآوری شود.';

  @override
  String get zakatSetDate => 'تعیین تاریخ';

  @override
  String zakatNextDue(Object date) {
    return 'سررسید بعدی: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'تذکر: این محاسبه‌گر صرفاً راهنمای کلی است. برای موارد خاص با علمای دینی مشورت فرمایید.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'قیمت‌های محلی دستی ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'قیمت طلافروشی محلی ممکن است با قیمت جهانی فرق کند. قیمت هر گرم را وارد کنید یا خالی بگذارید تا خودکار باشد.';

  @override
  String get zakatGold24PerGram => 'هر گرم طلای ۲۴ عیار';

  @override
  String get zakatSilverPerGram => 'هر گرم نقره';

  @override
  String get zakatPickHawlHelp => 'تاریخی که داراییتان به نصاب رسید';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'محاسبه زکات — برنامه بُشریٰ\nکل اموال مشمول زکات: $total $cur\nحد نصاب ($nisabType): $nisabVal $cur\nزکات واجب (۲.۵٪): $due $cur';
  }

  @override
  String get trackerTitle => 'پیگیری نمازها';

  @override
  String get trackerTimeNotStarted => 'هنوز وقت این نماز نرسیده است 🌙';

  @override
  String get trackerLearningHabits => '🧠 شناخت الگوهای شما';

  @override
  String get trackerLearningDesc =>
      'نمازهای خود را حداقل ۵ روز ثبت کنید تا پیشنهادهای متناسب با خودتان ارائه دهیم (تمام تحلیل فقط روی دستگاه شماست).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 فجر از دست می‌رود: $missed بار از $days روز گذشته';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'یادآوری خواب زودهنگام هر شب ساعت $time فعال است 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'علت اصلی فوت شدن فجر معمولاً دیر خوابیدن است. آیا مایلید هر شب یادآوری خواب زودهنگام دریافت کنید؟';

  @override
  String trackerTurnOnTime(Object time) {
    return 'فعال‌سازی ($time)';
  }

  @override
  String get trackerNotNow => 'الان نه';

  @override
  String get trackerChangeTime => 'تغییر زمان';

  @override
  String get trackerTurnOff => 'خاموش کردن';

  @override
  String get trackerPickAnotherTime => 'زمان دیگری انتخاب کنید';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer معمولاً در اواخر وقت خوانده می‌شود';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'یادآوری ملایم $prayer را زودتر تنظیم کردیم (میانه وقت به جای پایان).';
  }

  @override
  String get trackerGreatConsistency => '✨ پایداری شما عالی است';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 نیازمند توجه بیشتر: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'هیچ نمازی به طور مکرر قضا نمی‌شود. ادامه دهید!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return '$missed بار در $days روز اخیر از دست رفته. یادآوری ملایم به شما کمک می‌کند.';
  }

  @override
  String get trackerTurnOffNudge => 'خاموش کردن یادآوری ملایم';

  @override
  String get trackerTurnOnNudge => 'فعال کردن یادآوری ملایم';

  @override
  String get trackerStopLearning => 'توقف یادگیری الگوهای من';

  @override
  String get trackerStartLearning => 'یادگیری الگوهای من';

  @override
  String get trackerStartStreakToday => 'زنجیره خود را امروز آغاز کنید';

  @override
  String trackerStreakDays(Object count) {
    return '$count روز متوالی هر پنج نماز';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'بهترین زنجیره: $best — این هفته: $pct%';
  }

  @override
  String get trackerToday => 'امروز';

  @override
  String get trackerYesterday => 'دیروز';

  @override
  String get trackerYourGarden => 'باغ شما 🌳';

  @override
  String get trackerGardenDesc =>
      'هر نماز درختی دارد که با پایبندی روزانه شما رشد می‌کند';

  @override
  String get trackerDayUnit => 'روز';

  @override
  String get trackerTodayPrayers => 'نمازهای امروز';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'نمازهای $date';
  }

  @override
  String get trackerPrayedMark => 'خوانده شد ✓';

  @override
  String get trackerNotMarked => 'ثبت نشده';

  @override
  String get trackerThisWeek => 'آمار این هفته';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'مجموع ثبت شده: $count نماز';
  }

  @override
  String get gardenTitle => 'باغ من';

  @override
  String get gardenHomeCardTitle => 'باغ نمازهای شما 🌳';

  @override
  String get gardenEnterFull => 'ورود به باغ کامل 🌿';

  @override
  String get gardenTooEarlySeed => 'هنوز زود است… بذر منتظر شماست 🌱';

  @override
  String get gardenChooseMonth => 'انتخاب ماه';

  @override
  String get gardenOf => 'باغِ';

  @override
  String get gardenHijriSuffix => 'ق';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count روز کامل';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'بهترین زنجیره $count';
  }

  @override
  String get gardenBlessedForest => 'جنگلی با برکت';

  @override
  String gardenWeekNumber(Object num) {
    return 'هفته $num';
  }

  @override
  String get gardenMsgFlourishing => 'ماشاءالله! باغی سرسبز و پربار 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'باغ زیبایی است — ادامه دهید تا جنگلی انبوه شود 🌿';

  @override
  String get gardenMsgWaterToday =>
      'هر نماز به درختی آب می‌دهد. از امروز شروع کنید 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'باغ منتظر شماست… اولین نماز، کاشت اولین درخت است 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'خوانده شد ✓ ساعت $time';
  }

  @override
  String get plantStatusPrayed => 'خوانده شد ✓';

  @override
  String get plantStatusPending => 'وقتش رسیده و هنوز ثبت نشده 💧';

  @override
  String get plantStatusMissed => 'ثبت نشده — درخت تشنه آب است';

  @override
  String get plantStatusUpcoming => 'هنوز وقتش نرسیده است 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'درخت میوه‌دار! $streak روز متوالی در $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return 'یک هفته یا بیشتر — $streak روز متوالی در $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'روز شماره $streak از پایداری در $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'هر نماز درخت را رشد می‌دهد — پایبندی شما آب حیات آن است 💧';

  @override
  String get plantUndo => 'لغو ثبت';

  @override
  String get plantWaterAction => 'خواندم — آبیاری درخت 💧';

  @override
  String get plantStageSeed => 'بذر';

  @override
  String get plantStageSprout => 'جوانه';

  @override
  String get plantStageSapling => 'نهال';

  @override
  String get plantStageYoungTree => 'درختچه';

  @override
  String get plantStageTree => 'درخت';

  @override
  String get plantStageFruitTree => 'درخت میوه';

  @override
  String get treeCherryBlossom => 'درخت گیلاس';

  @override
  String get treeDatePalm => 'نخل خرما';

  @override
  String get treeOrangeTree => 'درخت پرتقال';

  @override
  String get treePomegranate => 'درخت انار';

  @override
  String get treeCypress => 'سرو';

  @override
  String get weeklySummaryTitle => 'خلاصه هفتگی شما';

  @override
  String get weeklyShareAsImage => 'اشتراک‌گذاری به عنوان تصویر';

  @override
  String get weeklyNoPrayersLogged =>
      'این هفته هنوز نمازی ثبت نشده. از باغچه صفحه اصلی شروع کنید 🌱';

  @override
  String get weeklyShareYourTree => 'درخت هفتگی خود را به اشتراک بگذارید';

  @override
  String get weeklyNotificationHint =>
      'هر جمعه بعد از عشاء اعلانی با خلاصه هفته دریافت می‌کنید.';

  @override
  String get weeklyImageError => 'ایجاد تصویر ممکن نشد، دوباره تلاش کنید';

  @override
  String get weeklyCardTitle => 'خلاصه هفتگی من';

  @override
  String get weeklyCardTreeSubtitle => 'درخت نمازهای من در این هفته 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% از نمازهایم به یاری خدا سر وقت خوانده شد';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'بهترین نماز: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'کمترین پایداری: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 $count روز متوالی تمام نمازها';
  }

  @override
  String get weeklyCardAppBranding => 'برنامه بُشریٰ — اذان، اذکار و قرآن';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'شما $total نماز از $max نماز را خواندید';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'بهترین نماز شما: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'و کمترین: $prayer';
  }

  @override
  String get amLabel => 'ق.ظ';

  @override
  String get pmLabel => 'ب.ظ';
}
