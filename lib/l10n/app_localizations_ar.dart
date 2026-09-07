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
  String get testNotificationNow => 'إرسال إشعار تجريبي الآن';

  @override
  String get prePrayerAlertDesc => 'نبهني قبل الأذان بـ';
}
