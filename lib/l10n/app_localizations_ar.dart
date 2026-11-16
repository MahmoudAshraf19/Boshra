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

  @override
  String get qiblaDirection => 'اتجاه القبلة';

  @override
  String get qiblaAccurate => 'القبلة صحيحة';

  @override
  String get youAreFacingQibla => 'أنت متجه الآن إلى قبلة المسلمين';

  @override
  String get qiblaCalibration => 'معايرة القبلة';

  @override
  String get qiblaCalibrationDesc =>
      'يرجى تحريك الهاتف ببطء في شكل رقم 8 حتى تتم معايرة البوصلة';

  @override
  String get findingLocation => 'تحديد الموقع...';

  @override
  String get locationPermissionError =>
      'تعذر الوصول للموقع. يرجى تفعيل الـ GPS.';

  @override
  String get locationPermissionTitle => 'السماح بالوصول للموقع';

  @override
  String get locationPermissionDesc =>
      'نحتاج إلى موقعك الجغرافي لنتمكن من حساب اتجاه القبلة بدقة متناهية بناءً على مكانك الحالي.';

  @override
  String get preciseQibla => 'قبلة دقيقة';

  @override
  String get exactLocation => 'موقعك الفعلي';

  @override
  String get alwaysUpToDate => 'تحديث مستمر';

  @override
  String get allowLocationBtn => 'السماح بالوصول للموقع';

  @override
  String get notNow => 'ليس الآن';

  @override
  String get startupLocationTitle => 'السماح بالوصول للموقع';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'نحتاج إلى موقعك الجغرافي لتحديد مواقيت الصلاة واتجاه القبلة بدقة فائقة.\n\nإذا لم تسمح بذلك، سنستخدم آخر موقع محفوظ لك وهو: $locationName.';
  }

  @override
  String get startupLocationDescDefault =>
      'نحن بحاجة إلى موقعك لتحديد مواقيت الصلاة واتجاه القبلة بدقة.\n\nإذا اخترت عدم السماح، سنستخدم الموقع الافتراضي: مكة المكرمة، المملكة العربية السعودية.';

  @override
  String get moreScreenTitle => 'المزيد';

  @override
  String get generalSettings => 'الإعدادات العامة';

  @override
  String get appearance => 'المظهر';

  @override
  String get systemDefault => 'النظام الافتراضي';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get alertsSettings => 'الإشعارات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get adhanAndReminders => 'الأذان وتنبيهات الصلاة';

  @override
  String get dataAndStorage => 'البيانات والتخزين';

  @override
  String get storage => 'التخزين والتحميلات';

  @override
  String get storageDesc => 'إدارة السور المحملة';

  @override
  String get infoAndSupport => 'معلومات إضافية';

  @override
  String get privacyAndPermissions => 'الخصوصية والصلاحيات';

  @override
  String get aboutBoshra => 'عن تطبيق بشرى';

  @override
  String get downloadedOption => 'تم التحميل';

  @override
  String get totalUsed => 'المساحة المستخدمة';

  @override
  String get systemApp => 'نظام التطبيق';

  @override
  String get downloadedSurahs => 'السور المحملة';

  @override
  String get cache => 'الذاكرة المؤقتة';

  @override
  String get manageDownloads => 'إدارة التحميلات';

  @override
  String get clearCache => 'مسح الذاكرة المؤقتة';

  @override
  String get clearAllDownloads => 'مسح جميع التحميلات';

  @override
  String get clearWarning =>
      'هذا الإجراء سيقوم بحذف جميع الملفات المحملة ولا يمكن التراجع عنه.';

  @override
  String get notEnoughSpace =>
      'لا توجد مساحة تخزين كافية (تم الوصول للحد الأقصى 3 جيجا).';

  @override
  String get clearCacheWarning =>
      'هل أنت متأكد؟ سيؤدي ذلك إلى مسح بعض البيانات المؤقتة مثل موقعك الجغرافي.';

  @override
  String get clearAllData => 'مسح كل بيانات التطبيق';

  @override
  String get clearDataWarning =>
      'هل أنت متأكد؟ سيؤدي ذلك إلى مسح جميع البيانات والإعدادات والتحميلات، وسيعود التطبيق لشكله الأول كأنك قمت بتنزيله للتو.';

  @override
  String get yesClear => 'نعم، مسح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get yourPrivacyMatters => 'خصوصيتك تهمنا.';

  @override
  String get privacyRequestsDesc =>
      'يطلب بشرى فقط الأذونات اللازمة لتوفير ميزاته.';

  @override
  String get permissions => 'الأذونات';

  @override
  String get locationPermDesc =>
      'يُستخدم لحساب مواقيت الصلاة بدقة وتحديد اتجاه القبلة بناءً على موقعك.';

  @override
  String get statusAllowed => 'مسموح';

  @override
  String get statusDenied => 'مرفوض';

  @override
  String get notificationsPermDesc =>
      'تُستخدم لإرسال مواقيت الصلاة وتنبيهات الأذان وتذكيرات الأذكار.';

  @override
  String get yourData => 'بياناتك';

  @override
  String get yourDataDesc1 => 'لا يحتاج بشرى إلى إنشاء حساب أو تسجيل الدخول.';

  @override
  String get yourDataDesc2 =>
      'قد يتم حفظ تفضيلاتك والمحتوى الذي تم تنزيله وإعدادات التطبيق محليًا على جهازك لتوفير ميزات التطبيق.';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get privacyPolicyDesc =>
      'تعرّف على كيفية جمع المعلومات واستخدامها وتخزينها وحمايتها في بشرى.';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get termsDesc => 'اطلع على الشروط المنظمة لاستخدامك لتطبيق بشرى.';

  @override
  String get dataAndPrivacy => 'البيانات والخصوصية';

  @override
  String get dataPrivacyDesc =>
      'تعرّف على المعلومات التي تتم معالجتها في بشرى وخيارات الخصوصية المتاحة لك.';

  @override
  String get permissionManagement => 'إدارة الأذونات';

  @override
  String get manageLocationPerm => 'إدارة إذن الموقع';

  @override
  String get manageLocationDesc =>
      'افتح إعدادات الجهاز لتغيير صلاحية الوصول إلى الموقع.';

  @override
  String get manageNotificationsPerm => 'إدارة إذن الإشعارات';

  @override
  String get manageNotificationsDesc =>
      'افتح إعدادات الجهاز لتغيير صلاحية الإشعارات.';

  @override
  String get localData => 'البيانات المحلية';

  @override
  String get clearLocalDataDesc =>
      'حذف بيانات بشرى المخزنة محليًا على هذا الجهاز.';

  @override
  String get clearDownloadsDesc =>
      'حذف التلاوات والمحتوى الآخر الذي تم تنزيله للاستخدام دون اتصال.';

  @override
  String get privacyNote => 'ملاحظة الخصوصية';

  @override
  String get privacyNoteDesc =>
      'يستخدم بشرى الموقع فقط للميزات التي تحتاج إليه، مثل مواقيت الصلاة واتجاه القبلة.';

  @override
  String get boshraTagline => 'رفيقك اليومي للقرآن والصلاة والذكر.';

  @override
  String get boshraAboutDesc =>
      'بشرى تطبيق إسلامي صُمم ليجعل عبادتك اليومية أسهل وأكثر هدوءًا وسهولة في الوصول.';

  @override
  String get whatYouCanDo => 'ماذا يمكنك أن تفعل مع بشرى؟';

  @override
  String get quranDesc => 'اقرأ القرآن الكريم بتجربة قراءة مريحة وواضحة.';

  @override
  String get quranRecitation => 'تلاوة القرآن';

  @override
  String get quranRecitationDesc =>
      'استمع إلى تلاوات القرآن الكريم بصوت القارئ المفضل لديك.';

  @override
  String get azkarDesc =>
      'حافظ على أذكارك اليومية بطريقة منظمة وسهلة الاستخدام.';

  @override
  String get prayerTimesDesc => 'احصل على مواقيت صلاة دقيقة بناءً على موقعك.';

  @override
  String get qiblaDesc => 'حدد اتجاه الكعبة باستخدام موقع جهازك والبوصلة.';

  @override
  String get reminders => 'التذكيرات';

  @override
  String get remindersDesc =>
      'استقبل التذكيرات في الوقت المناسب لتبقى قريبًا من عبادتك طوال اليوم.';

  @override
  String get appInfo => 'معلومات التطبيق';

  @override
  String get version => 'الإصدار';

  @override
  String get buildNumber => 'رقم البناء';

  @override
  String get moreOptions => 'المزيد';

  @override
  String get rateBoshra => 'قيّم بشرى';

  @override
  String get rateBoshraDesc => 'ادعم بشرى من خلال ترك تقييمك.';

  @override
  String get shareBoshra => 'شارك بشرى';

  @override
  String get shareBoshraDesc => 'شارك بشرى مع العائلة والأصدقاء.';

  @override
  String get contactUs => 'تواصل معنا';

  @override
  String get contactUsDesc => 'تواصل مع Mahmoud Ashraf.';

  @override
  String get openSourceLicenses => 'تراخيص المصادر المفتوحة';

  @override
  String get openSourceDesc =>
      'اطلع على تراخيص البرمجيات مفتوحة المصدر المستخدمة في بشرى.';

  @override
  String get madeWithCare =>
      'صُمم بعناية لكل من يبحث عن علاقة أقرب بالقرآن والذكر.';

  @override
  String get locationText => 'الموقع';

  @override
  String get privacyPolicyText => 'سياسة الخصوصية';

  @override
  String get clearLocalDataText => 'مسح البيانات المحلية';

  @override
  String get prayerTimesText => 'مواقيت الصلاة';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeLightDesc => 'واجهة بيضاء دافئة ونظيفة';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeDarkDesc => 'واجهة ليلية مريحة للعين';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeSystemDesc => 'متابعة إعدادات الجهاز';

  @override
  String get soundType => 'نوع الإشعار';

  @override
  String get soundSilent => 'صامت (بدون صوت)';

  @override
  String get soundShort => 'تنبيه قصير';

  @override
  String get soundAdhan => 'أذان كامل';

  @override
  String get prePrayerAlertDesc => 'نبهني قبل الأذان بـ';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'حان الآن موعد صلاة $prayerName';
  }

  @override
  String get prayerNotifBody => 'حيّ على الصلاة';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return 'صلاة $prayerName قريبًا';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'باقي $minutes دقيقة على الأذان';
  }

  @override
  String get notifDisabledTitle => 'الإشعارات متوقفة';

  @override
  String get notifDisabledDesc =>
      'فعّل الإشعارات ليصلك الأذان والتذكيرات في وقتها.';

  @override
  String get exactAlarmTitle => 'التنبيهات الدقيقة متوقفة';

  @override
  String get exactAlarmDesc =>
      'اسمح بـ «المنبهات والتذكيرات» حتى يصل الأذان في وقته بالضبط.';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get errorGeneric => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get errorNoInternet =>
      'لا يوجد اتصال بالإنترنت. تحقق من الاتصال وحاول مجددًا.';

  @override
  String get errorLoadFailed => 'تعذّر تحميل المحتوى.';

  @override
  String get downloadingProgress => 'جارٍ التحميل...';

  @override
  String get downloadSuccess => 'تم التحميل بنجاح';

  @override
  String get downloadFailed => 'فشل التحميل. حاول مرة أخرى.';

  @override
  String get shareFailed => 'تعذّر إنشاء الصورة. حاول مرة أخرى.';

  @override
  String get audioLoadFailed => 'تعذّر تشغيل الصوت. تحقق من الاتصال.';

  @override
  String get radioLoadFailed => 'تعذّر جلب الإذاعات';

  @override
  String get continueReadingBtn => 'متابعة القراءة';

  @override
  String get permSetupTitle => 'لا تفوّت أي صلاة';

  @override
  String get permSetupSubtitle =>
      'اسمح ببعض الأذونات مرة واحدة ليصلك الأذان والتذكيرات في وقتها بالضبط، حتى لو كان التطبيق مغلقًا.';

  @override
  String get permNotifTitle => 'الإشعارات';

  @override
  String get permNotifDesc =>
      'لعرض الأذان وتذكيرات الصلاة والأذكار ورسائل القرآن.';

  @override
  String get permExactTitle => 'المنبهات والتذكيرات';

  @override
  String get permExactDesc =>
      'يسمح لأندرويد بإطلاق الأذان في الدقيقة المحددة بالضبط.';

  @override
  String get permBatteryTitle => 'بطارية غير مقيّدة';

  @override
  String get permBatteryDesc =>
      'يمنع النظام من إيقاف التطبيق وإسقاط الإشعارات لتوفير الطاقة.';

  @override
  String get permAutostartTitle => 'التشغيل التلقائي والخلفية';

  @override
  String permAutostartDesc(String brand) {
    return 'هاتفك ($brand) قد يمنع التطبيقات في الخلفية. اسمح لبشرى بالتشغيل التلقائي والعمل في الخلفية.';
  }

  @override
  String get permChannelsTitle => 'أقسام الإشعارات والصوت';

  @override
  String get permChannelsDesc =>
      'بعض أقسام الإشعارات متوقفة. فعّلها لتسمع الأذان.';

  @override
  String get permAllowAll => 'السماح بالكل';

  @override
  String get permAllow => 'سماح';

  @override
  String get permGranted => 'تم السماح';

  @override
  String get permContinue => 'متابعة';

  @override
  String get permLater => 'لاحقًا';

  @override
  String get permAllSet => 'كل شيء جاهز! ستصلك الإشعارات بشكل موثوق.';

  @override
  String get permMissingNote =>
      'بعض الأذونات ما زالت متوقفة، وقد تتأخر الإشعارات أو لا تصل.';

  @override
  String get permFix => 'إصلاح الآن';

  @override
  String get adhanStopAction => 'إيقاف الأذان';

  @override
  String get adhanBannerTitle => 'شريط الأذان العلوي';

  @override
  String get adhanBannerDesc =>
      'يظهر أعلى الشاشة وعلى شاشة القفل وقت الأذان، مع زر لإيقافه.';

  @override
  String get adhanBannerPreview => 'معاينة الشريط';

  @override
  String get adhanBannerVerse =>
      '﴿ إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَّوْقُوتًا ﴾';

  @override
  String get notifSettingsTitle => 'الإشعارات والأذان';

  @override
  String get modeSilent => 'صامت';

  @override
  String get modeShort => 'تنبيه قصير';

  @override
  String get modeAdhan => 'أذان كامل';

  @override
  String get modeSilentDesc => 'إشعار بدون صوت';

  @override
  String get modeShortDesc => 'صوت إشعار عادي';

  @override
  String get modeAdhanDesc => 'الأذان كاملاً مع زر إيقاف';

  @override
  String minutesShort(int minutes) {
    return '$minutes د';
  }

  @override
  String get remindersSection => 'التذكيرات اليومية';

  @override
  String afterFajrDesc(int minutes) {
    return 'بعد الفجر بـ $minutes دقيقة';
  }

  @override
  String afterAsrDesc(int minutes) {
    return 'بعد العصر بـ $minutes دقيقة (قبل الغروب)';
  }

  @override
  String get ayahReminderTitle => 'آية اليوم';

  @override
  String get ayahReminderDesc => 'آية جديدة كل يوم في الوقت الذي تختاره';

  @override
  String get reminderTime => 'الوقت';

  @override
  String get muadhinTitle => 'المؤذن';

  @override
  String get atAdhanTime => 'مع الأذان مباشرة';

  @override
  String get advancedSection => 'الدقة والحساب';

  @override
  String get calcMethodTitle => 'طريقة حساب المواقيت';

  @override
  String get calcMethodAuto => 'تلقائي (حسب موقعك)';

  @override
  String get asrSchoolTitle => 'حساب العصر';

  @override
  String get asrStandard => 'الجمهور (الشافعي والمالكي والحنبلي)';

  @override
  String get asrHanafi => 'الحنفي';

  @override
  String get adjustTimesTitle => 'ضبط دقيق للمواقيت (بالدقائق)';

  @override
  String get testAdhanButton => 'جرّب الأذان الآن';

  @override
  String get locationFallbackWarning =>
      'تعذّر تحديد موقعك، فالمواقيت محسوبة لمكة المكرمة. فعّل الموقع للحصول على مواقيت دقيقة.';

  @override
  String get sadaqaJariyaTitle => 'صدقة جارية';

  @override
  String get sadaqaHadith =>
      '«مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»';

  @override
  String get narratedByMuslim => 'رواه مسلم';

  @override
  String get yourInviteCode => 'كود الدعوة الخاص بك';

  @override
  String get codeCopied => 'تم نسخ الكود';

  @override
  String get shareAppButton => 'شارك التطبيق';

  @override
  String get shareViaWhatsApp => 'مشاركة عبر واتساب';

  @override
  String get startFirstShare => 'ابدأ أول مشاركة لك 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'شاركت التطبيق $count مرة — تقبّل الله منك';
  }

  @override
  String get haveFriendCode => 'عندك كود دعوة من صديق؟';

  @override
  String recordedInviteFrom(Object code) {
    return 'تم تسجيل دعوة $code — جزاه الله خيرًا';
  }

  @override
  String get invalidInviteCode => 'الكود غير صحيح (مثال: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'ده كودك أنت 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'حمّلت تطبيق «بُشرى» للأذان والقرآن والأذكار وأنصحك به 🌙\nانشره صدقة جارية — «مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»\n\n$link\nكود الدعوة: $code';
  }

  @override
  String get diagTitle => 'هل الأذان هيشتغل؟';

  @override
  String get diagAllGood => 'كل شيء سليم — الأذان هيشتغل في وقته إن شاء الله';

  @override
  String diagCanImprove(Object count) {
    return 'الأذان غالبًا هيشتغل، لكن في $count نقطة تحسين';
  }

  @override
  String diagProblemsFound(Object count) {
    return 'في $count مشكلة ممكن تمنع الأذان — صلّحها بالأزرار تحت';
  }

  @override
  String get diagFix => 'إصلاح';

  @override
  String get diagTestAdhanNow => 'تجربة الأذان الآن';

  @override
  String get diagReschedule => 'إعادة الجدولة';

  @override
  String get diagRecentEvents => 'آخر الأحداث';

  @override
  String get diagNoEvents => 'لا توجد أحداث بعد';

  @override
  String get diagCopyReport => 'نسخ تقرير للدعم الفني';

  @override
  String get diagReportCopied => 'تم نسخ تقرير الدعم — الصقه في واتساب';

  @override
  String get diagNotifications => 'الإشعارات';

  @override
  String get diagNotifEnabled => 'مفعّلة';

  @override
  String get diagNotifBlocked => 'مقفولة — الأذان مش هيظهر';

  @override
  String get diagEnable => 'تفعيل';

  @override
  String get diagChannels => 'قنوات الإشعار';

  @override
  String get diagChannelsAllEnabled => 'كلها شغالة';

  @override
  String get diagChannelMuted => 'في قناة مكتومة من إعدادات الموبايل';

  @override
  String get diagOpenSettings => 'فتح الإعدادات';

  @override
  String get diagExactAlarms => 'المنبّهات الدقيقة';

  @override
  String get diagExactAlarmsAllowed => 'مسموحة — الأذان في الثانية المضبوطة';

  @override
  String get diagExactAlarmsNotAllowed => 'غير مسموحة — الأذان ممكن يتأخر';

  @override
  String get diagAllow => 'السماح';

  @override
  String get diagBattery => 'تحسين البطارية';

  @override
  String get diagBatteryExempt => 'التطبيق مستثنى';

  @override
  String get diagBatteryMayKill => 'النظام ممكن يوقف التطبيق في الخلفية';

  @override
  String get diagExempt => 'استثناء';

  @override
  String get diagPrayerMode => 'وضع الصلاة';

  @override
  String get diagPrayerModeFullSilence =>
      'الكتم الكامل جاهز (عدم الإزعاج مسموح)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'بدون صلاحية «عدم الإزعاج» هنكتفي بوضع الاهتزاز';

  @override
  String get diagGrantPermission => 'منح الصلاحية';

  @override
  String get diagAutostart => 'التشغيل التلقائي';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'تم ضبطه ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return 'جهاز $brand بيقفل التطبيقات — فعّل التشغيل التلقائي';
  }

  @override
  String get diagOpen => 'فتح';

  @override
  String get diagLocation => 'الموقع';

  @override
  String diagLocationManual(Object city) {
    return 'مدينة مختارة يدويًا: $city';
  }

  @override
  String get diagLocationApprox => 'تقريبي';

  @override
  String get diagLocationUnknown => 'مش متحدد — بنستخدم مدينة افتراضية';

  @override
  String get diagLocationGpsOff => 'خدمة الموقع (GPS) مقفولة';

  @override
  String get diagLocationDenied => 'إذن الموقع مرفوض';

  @override
  String get diagLocationPermanentlyDenied =>
      'إذن الموقع مرفوض نهائيًا — افتحه من الإعدادات';

  @override
  String get diagLocationNoFix =>
      'الجهاز ما قدرش يحدد موقعك (إشارة ضعيفة / دقة الموقع مقفولة)';

  @override
  String get diagLocationMock => 'في موقع وهمي مفعّل على الجهاز — بنتجاهله';

  @override
  String get diagLocationTzMismatch =>
      'الموقع متعارض مع المنطقة الزمنية للجهاز (موقع وهمي؟)';

  @override
  String get diagFixLocation => 'تحديد دقيق';

  @override
  String get diagSetLocation => 'تحديد';

  @override
  String get diagLastScheduling => 'آخر جدولة';

  @override
  String get diagNeverScheduled => 'لسه ما اتجدولش';

  @override
  String get diagScheduleNow => 'جدولة الآن';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count تنبيه';
  }

  @override
  String get diagScheduleIncomplete => 'ناقصة (اتحسب أوفلاين)';

  @override
  String get diagScheduleError => 'حصل خطأ';

  @override
  String get diagNextAdhan => 'الأذان القادم';

  @override
  String get diagAllPrayersSilent =>
      'كل الصلوات مضبوطة على إشعار قصير/صامت (مش أذان كامل)';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count أذان مجدول في النظام';
  }

  @override
  String get diagNoAdhanArmed => 'مفيش أذان مجدول في المنبّه! اضغط جدولة';

  @override
  String get diagOfflineMode => 'الوضع الأوفلاين';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count أشهر محفوظة — يشتغل بدون إنترنت';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'محفوظ $count شهر فقط (هيتكمّل تلقائيًا مع الإنترنت)';
  }

  @override
  String get diagInternet => 'الإنترنت';

  @override
  String get diagInternetConnected => 'متصل بخادم المواعيد';

  @override
  String get diagInternetUnavailable =>
      'غير متاح الآن — مش مشكلة، المواعيد المحفوظة تكفي';

  @override
  String get diagTestAdhanTitle => 'تجربة الأذان';

  @override
  String get diagTestAdhanBody => 'لو سمعت الأذان يبقى كل حاجة تمام';

  @override
  String get diagStop => 'إيقاف';

  @override
  String get diagAgoJustNow => 'الآن';

  @override
  String diagAgoMinutes(Object m) {
    return 'من $m دقيقة';
  }

  @override
  String diagAgoHours(Object h) {
    return 'من $h ساعة';
  }

  @override
  String diagAgoDays(Object d) {
    return 'من $d يوم';
  }

  @override
  String get zakatCalculatorTitle => 'حاسبة الزكاة';

  @override
  String get zakatCurrency => 'العملة';

  @override
  String get zakatTodayPricesGram => 'أسعار اليوم (للجرام)';

  @override
  String get zakatRefresh => 'تحديث';

  @override
  String get zakatEditManually => 'تعديل يدوي';

  @override
  String get zakatCouldNotLoadPrices =>
      'تعذّر جلب الأسعار (لا إنترنت). اضغط ✏️ لإدخال سعر الجرام يدويًا.';

  @override
  String get zakatGold24 => 'ذهب عيار 24';

  @override
  String get zakatGold21 => 'ذهب عيار 21';

  @override
  String get zakatGold18 => 'ذهب عيار 18';

  @override
  String get zakatSilver => 'فضة';

  @override
  String get zakatGram => 'جرام';

  @override
  String get zakatUsingManualPrices => '✏️ تستخدم أسعارك اليدوية';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'سعر عالمي × سعر الصرف — محدّث $date';
  }

  @override
  String get zakatPriceOld => ' (قديم)';

  @override
  String get zakatNisab => 'النصاب';

  @override
  String get zakatGoldNisab => 'ذهب (85 جم)';

  @override
  String get zakatSilverNisab => 'فضة (595 جم)';

  @override
  String get zakatNisabExplanation =>
      'اعتمد النصاب الذي تفتي به الجهة التي تثق بها (دار الإفتاء في بلدك). نصاب الفضة أقل قيمة فيشمل عددًا أكبر من الناس.';

  @override
  String get zakatYourWealth => 'أموالك';

  @override
  String get zakatCashSavings => 'النقد والمدخرات والحسابات البنكية';

  @override
  String get zakatSharesInvestments => 'أسهم واستثمارات وصناديق';

  @override
  String get zakatTradeGoods => 'بضاعة تجارة (بسعر السوق)';

  @override
  String get zakatMoneyOwedToYou => 'ديون لك مضمونة السداد';

  @override
  String get zakatDebtsDue => 'ديون عليك مستحقة الآن (تُخصم)';

  @override
  String get zakatJewelleryNote =>
      'اختلف العلماء في زكاة الحلي المستعمل للزينة؛ الحاسبة تحسبه، فإن كان رأي من تقلّده عدم الزكاة فيه فاترك خانات الذهب فارغة.';

  @override
  String get zakatTotalZakatableWealth => 'إجمالي المال الخاضع للزكاة';

  @override
  String get zakatEnterPriceForNisab => 'أدخل سعر الذهب/الفضة لحساب النصاب';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'النصاب: $amount $cur';
  }

  @override
  String get zakatDue25 => 'الزكاة الواجبة (2.5%)';

  @override
  String get zakatHawlCondition =>
      'بشرط أن يمرّ على مالك حَوْل كامل (سنة هجرية).';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'لم يبلغ مالك النصاب (ينقصك $amount $cur) فلا زكاة عليك الآن.';
  }

  @override
  String get zakatCopyResult => 'نسخ النتيجة';

  @override
  String get zakatResultCopied => 'تم نسخ النتيجة';

  @override
  String get zakatYearlyReminder => 'تذكير سنوي بالزكاة';

  @override
  String get zakatReminderExplanation =>
      'اختر تاريخ ما بلغ مالك النصاب، وسنذكّرك قبل تمام الحول بأسبوع ويوم تمامه كل عام (سنة قمرية تقريبية 354 يومًا).';

  @override
  String get zakatSetDate => 'تحديد التاريخ';

  @override
  String zakatNextDue(Object date) {
    return 'الحَوْل القادم: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'تنبيه: الحاسبة للإرشاد العام. للحالات الخاصة (أسهم، شركات، ديون، عقارات للتجارة…) راجع أهل العلم في بلدك.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'أسعار محلية يدوية ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'سعر جرام السوق عندك قد يختلف عن السعر العالمي (علاوة الصاغة وفرق سعر الصرف). اكتب سعر الجرام من محلات الصاغة لو حبيت. اتركه فارغًا لاستخدام السعر التلقائي.';

  @override
  String get zakatGold24PerGram => 'جرام الذهب عيار 24';

  @override
  String get zakatSilverPerGram => 'جرام الفضة';

  @override
  String get zakatPickHawlHelp => 'تاريخ ما بلغ مالك النصاب';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'زكاة المال — بُشرى\nإجمالي المال الخاضع للزكاة: $total $cur\nالنصاب ($nisabType): $nisabVal $cur\nالزكاة الواجبة (2.5%): $due $cur';
  }

  @override
  String get trackerTitle => 'متتبّع الصلوات';

  @override
  String get trackerTimeNotStarted => 'لسه ما دخلش وقتها 🌙';

  @override
  String get trackerLearningHabits => '🧠 بنتعرّف على أنماطك';

  @override
  String get trackerLearningDesc =>
      'سجّل صلواتك 5 أيام على الأقل، وهنقترح عليك تحسينات تناسبك أنت (كل التحليل على جهازك فقط).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 الفجر بيفوتك: $missed من آخر $days يوم';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'تذكير النوم المبكر شغال الساعة $time كل ليلة. الله يعينك 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'أغلب اللي بيفوّتوا الفجر بيكون السبب السهر. تحب نذكّرك كل ليلة تنام بدري؟';

  @override
  String trackerTurnOnTime(Object time) {
    return 'فعّل ($time)';
  }

  @override
  String get trackerNotNow => 'مش دلوقتي';

  @override
  String get trackerChangeTime => 'غيّر الوقت';

  @override
  String get trackerTurnOff => 'إيقاف';

  @override
  String get trackerPickAnotherTime => 'اختر وقتًا آخر';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer غالبًا في آخر وقتها';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'خلّينا التذكير اللطيف لـ $prayer يجيلك أبكر من المعتاد (منتصف الوقت بدل آخره).';
  }

  @override
  String get trackerGreatConsistency => '✨ مواظبتك ممتازة';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 أضعف صلواتك: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping => 'مفيش صلاة بتفوتك بشكل متكرر. استمر!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'فاتتك $missed مرات في آخر $days يوم. التذكير اللطيف بيساعدك عليها.';
  }

  @override
  String get trackerTurnOffNudge => 'إيقاف التذكير اللطيف';

  @override
  String get trackerTurnOnNudge => 'تفعيل التذكير اللطيف';

  @override
  String get trackerStopLearning => 'إيقاف تعلّم أنماطي';

  @override
  String get trackerStartLearning => 'تفعيل تعلّم أنماطي';

  @override
  String get trackerStartStreakToday => 'ابدأ سلسلتك اليوم';

  @override
  String trackerStreakDays(Object count) {
    return '$count أيام متتالية بكل الصلوات';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'أفضل سلسلة: $best — هذا الأسبوع: $pct%';
  }

  @override
  String get trackerToday => 'اليوم';

  @override
  String get trackerYesterday => 'أمس';

  @override
  String get trackerYourGarden => 'حديقتك 🌳';

  @override
  String get trackerGardenDesc =>
      'كل صلاة ليها شجرة بتكبر مع كل يوم تواظب فيه عليها';

  @override
  String get trackerDayUnit => 'يوم';

  @override
  String get trackerTodayPrayers => 'صلوات اليوم';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'صلوات $date';
  }

  @override
  String get trackerPrayedMark => 'صلّيت ✓';

  @override
  String get trackerNotMarked => 'لم تُسجَّل';

  @override
  String get trackerThisWeek => 'إحصائيات الأسبوع';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'إجمالي ما سجّلته: $count صلاة';
  }

  @override
  String get gardenTitle => 'حديقتي';

  @override
  String get gardenHomeCardTitle => 'حديقة صلواتك 🌳';

  @override
  String get gardenEnterFull => 'ادخل حديقتك الكاملة 🌿';

  @override
  String get gardenTooEarlySeed => 'لسه بدري… البذرة بتستنّاك 🌱';

  @override
  String get gardenChooseMonth => 'اختر الشهر';

  @override
  String get gardenOf => 'حديقة';

  @override
  String get gardenHijriSuffix => 'هـ';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count أيام كاملة';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'أفضل سلسلة $count';
  }

  @override
  String get gardenBlessedForest => 'غابة مباركة';

  @override
  String gardenWeekNumber(Object num) {
    return 'الأسبوع $num';
  }

  @override
  String get gardenMsgFlourishing => 'ما شاء الله! حديقة عامرة مباركة 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing => 'حديقتك جميلة — كمّل وهتبقى غابة 🌿';

  @override
  String get gardenMsgWaterToday => 'كل صلاة بتسقي شجرة. ابدأ من النهارده 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'الحديقة مستنياك… أول صلاة تزرع أول شجرة 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'صلّيتها ✓ الساعة $time';
  }

  @override
  String get plantStatusPrayed => 'صلّيتها ✓';

  @override
  String get plantStatusPending => 'وقتها دخل ولسه ما سجّلتهاش 💧';

  @override
  String get plantStatusMissed => 'لم تُسجَّل — الشجرة محتاجة سقاية';

  @override
  String get plantStatusUpcoming => 'لسه وقتها ما جاش 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'شجرة مثمرة! $streak يوم متواصل على $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return 'أسبوع فأكثر — $streak يوم متواصل على $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'اليوم رقم $streak من مواظبتك على $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'كل صلاة بتكبّر الشجرة — مواظبتك هي مياهها 💧';

  @override
  String get plantUndo => 'إلغاء التسجيل';

  @override
  String get plantWaterAction => 'سجّلتها — اسقِ الشجرة 💧';

  @override
  String get plantStageSeed => 'بذرة';

  @override
  String get plantStageSprout => 'برعم';

  @override
  String get plantStageSapling => 'شتلة';

  @override
  String get plantStageYoungTree => 'شجرة صغيرة';

  @override
  String get plantStageTree => 'شجرة';

  @override
  String get plantStageFruitTree => 'شجرة مثمرة';

  @override
  String get treeCherryBlossom => 'شجرة الكرز';

  @override
  String get treeDatePalm => 'النخلة';

  @override
  String get treeOrangeTree => 'شجرة البرتقال';

  @override
  String get treePomegranate => 'شجرة الرمان';

  @override
  String get treeCypress => 'السروة';

  @override
  String get weeklySummaryTitle => 'ملخّصك الأسبوعي';

  @override
  String get weeklyShareAsImage => 'مشاركة كصورة';

  @override
  String get weeklyNoPrayersLogged =>
      'لسه ما سجّلتش صلوات هذا الأسبوع. ابدأ من «حديقة صلواتك» في الرئيسية 🌱';

  @override
  String get weeklyShareYourTree => 'شارك شجرة أسبوعك';

  @override
  String get weeklyNotificationHint =>
      'كل جمعة بعد العشاء بيجيلك إشعار بملخّص أسبوعك. تقدر تشاركه صدقة جارية لتشجيع غيرك.';

  @override
  String get weeklyImageError => 'تعذّر إنشاء الصورة، حاول مرة أخرى';

  @override
  String get weeklyCardTitle => 'ملخّصي الأسبوعي';

  @override
  String get weeklyCardTreeSubtitle => 'شجرة صلواتي هذا الأسبوع 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% من صلواتي في وقتها بإذن الله';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'أفضل صلاة: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'أضعفها: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 $count أيام متتالية بكل الصلوات';
  }

  @override
  String get weeklyCardAppBranding => 'تطبيق بُشرى — الأذان والأذكار والقرآن';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'صليت $total من $max';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'أفضل صلاة عندك: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'وأضعفها: $prayer';
  }

  @override
  String get amLabel => 'ص';

  @override
  String get pmLabel => 'م';
}
