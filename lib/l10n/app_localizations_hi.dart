// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'बुशरा';

  @override
  String get onboarding1Title => 'बुशरा... अच्छाई के मार्ग पर आपका साथी';

  @override
  String get onboarding1Desc =>
      'सरल कदमों के साथ अपने दिन को अल्लाह के करीब लाएं।';

  @override
  String get onboarding2Title =>
      'आपकी इबादत के लिए जो कुछ भी चाहिए, एक ही स्थान पर';

  @override
  String get onboarding2Desc =>
      'कुरान, प्रार्थना का समय, अज़कार, क़िबला, और दुआएं।';

  @override
  String get onboarding3Title => 'हर दिन एक छोटा कदम... बड़ा प्रभाव डालता है';

  @override
  String get onboarding3Desc => 'अपनी आस्था की आदतें बनाएं।';

  @override
  String get startJourney => 'अपनी यात्रा शुरू करें';

  @override
  String get next => 'अगला';

  @override
  String get skip => 'छोड़ें';

  @override
  String get navHome => 'होम';

  @override
  String get navQuran => 'कुरान';

  @override
  String get navAzkar => 'अज़कार';

  @override
  String get navQibla => 'किबला';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'अधिक';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return '$prayerName तक';
  }

  @override
  String get greeting => 'अस्सलामु अलैकुम👋';

  @override
  String get surahs => 'सूरह';

  @override
  String get juzs => 'पारे';

  @override
  String get prayerSettingsTitle => 'प्रार्थना और अज़ान सेटिंग्स';

  @override
  String get prePrayerAlertTitle => 'प्रार्थना से पहले अलर्ट';

  @override
  String minutesBeforeAdhan(int minutes) {
    return 'अज़ान से $minutes मिनट पहले';
  }

  @override
  String get enablePrayerAlertsTitle => 'प्रार्थना अलर्ट सक्षम करें';

  @override
  String get fajr => 'फ़ज्र';

  @override
  String get dhuhr => 'ज़ुहर';

  @override
  String get asr => 'अस्र';

  @override
  String get maghrib => 'मग़रिब';

  @override
  String get isha => 'ईशा';

  @override
  String get ayahOfTheDay => 'आज की आयत';

  @override
  String get listen => 'सुनें';

  @override
  String get tafseer => 'तफ़सीर';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return '$surahName • आयत $verseNumber';
  }

  @override
  String get dailyWird => 'अपना दैनिक विर्द पूरा करें';

  @override
  String get morningAzkar => 'सुबह के अज़कार';

  @override
  String get eveningAzkar => 'शाम के अज़कार';

  @override
  String get continueReading => 'जारी रखें';

  @override
  String get morningAzkarNotificationTitle => 'सुबह के अज़कार 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'अपने दिन की शुरुआत अल्लाह के ज़िक्र से करें';

  @override
  String get eveningAzkarNotificationTitle => 'शाम के अज़कार 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'अपने दिन का अंत अल्लाह के ज़िक्र से करें';

  @override
  String get quickAccess => 'त्वरित पहुँच';

  @override
  String get qibla => 'किबला';

  @override
  String get recitation => 'तिलावत';

  @override
  String get quran => 'क़ुरान';

  @override
  String get quranRadio => 'क़ुरान रेडियो';

  @override
  String get azkar => 'अज़कार';

  @override
  String get continueReadingCardTitle => 'पढ़ना जारी रखें';

  @override
  String surahName(String surahName) {
    return 'सूरह $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'आयत $number';
  }

  @override
  String get selectedRecitationTitle => 'चयनित कुरान पाठ';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'पवित्र कुरान';

  @override
  String get startQuranJourney => 'कुरान के साथ अपनी यात्रा शुरू करें';

  @override
  String get openSurahAndRead => 'एक सूरह खोलें और पढ़ना शुरू करें';

  @override
  String get browseSurahs => 'सूरह ब्राउज़ करें';

  @override
  String get searchSurah => 'सूरह खोजें...';

  @override
  String get tabSurahs => 'सूरह';

  @override
  String get tabJuzs => 'पारे';

  @override
  String get tabHizbs => 'हिज्ब';

  @override
  String get meccan => 'मक्की';

  @override
  String get medinan => 'मदनी';

  @override
  String ayahsCount(Object count) {
    return '$count आयतें';
  }

  @override
  String get tafsirOption => 'तफ़्सीर';

  @override
  String get recitationOption => 'तिलावत';

  @override
  String get downloadOption => 'डाउनलोड';

  @override
  String get shareOption => 'साझा करें';

  @override
  String get infoOption => 'जानकारी';

  @override
  String get copyOption => 'कॉपी';

  @override
  String get copiedSuccessfully => 'आयत क्लिपबोर्ड पर कॉपी हो गई';

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
  String get quranMessageNotificationTitle => 'कुरान से संदेश 🌿';

  @override
  String get saveBookmark => 'बुकमार्क सहेजें';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'सूरह $surahName आयत $ayahNumber पर बुकमार्क सहेजा गया';
  }

  @override
  String get qiblaDirection => 'किबला की दिशा';

  @override
  String get qiblaAccurate => 'किबला सटीक है';

  @override
  String get youAreFacingQibla => 'अब आपका मुख किबला की ओर है';

  @override
  String get qiblaCalibration => 'किबला कैलिब्रेशन';

  @override
  String get qiblaCalibrationDesc =>
      'कंपास को कैलिब्रेट करने के लिए कृपया अपने फोन को 8 की आकृति में धीरे-धीरे घुमाएं।';

  @override
  String get findingLocation => 'स्थान खोजा जा रहा है...';

  @override
  String get locationPermissionError =>
      'स्थान तक पहुंचने में असमर्थ। कृपया GPS चालू करें।';

  @override
  String get locationPermissionTitle => 'Allow Location Access';

  @override
  String get locationPermissionDesc =>
      'We need your location to accurately calculate the Qibla direction based on your current position.';

  @override
  String get preciseQibla => 'सटीक क़िबला';

  @override
  String get exactLocation => 'आपका सटीक स्थान';

  @override
  String get alwaysUpToDate => 'हमेशा अपडेट';

  @override
  String get allowLocationBtn => 'अनुमति दें';

  @override
  String get notNow => 'अभी नहीं';

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
  String get moreScreenTitle => 'अधिक';

  @override
  String get generalSettings => 'सामान्य';

  @override
  String get appearance => 'दिखावट';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get appLanguage => 'ऐप की भाषा';

  @override
  String get alertsSettings => 'अलर्ट';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get adhanAndReminders => 'अज़ान और रिमाइंडर';

  @override
  String get dataAndStorage => 'डेटा और स्टोरेज';

  @override
  String get storage => 'स्टोरेज';

  @override
  String get storageDesc => 'डाउनलोड किए गए सूरह प्रबंधित करें';

  @override
  String get infoAndSupport => 'जानकारी और समर्थन';

  @override
  String get privacyAndPermissions => 'गोपनीयता और अनुमतियाँ';

  @override
  String get aboutBoshra => 'बुशरा के बारे में';

  @override
  String get downloadedOption => 'डाउनलोड किया गया';

  @override
  String get totalUsed => 'कुल उपयोग';

  @override
  String get systemApp => 'सिस्टम (ऐप)';

  @override
  String get downloadedSurahs => 'डाउनलोड किए गए सूरह';

  @override
  String get cache => 'कैश';

  @override
  String get manageDownloads => 'डाउनलोड प्रबंधित करें';

  @override
  String get clearCache => 'कैश साफ़ करें';

  @override
  String get clearAllDownloads => 'सभी डाउनलोड साफ़ करें';

  @override
  String get clearWarning => 'इससे सभी डाउनलोड की गई सामग्री हट जाएगी।';

  @override
  String get notEnoughSpace => 'पर्याप्त जगह नहीं है (3GB सीमा)।';

  @override
  String get clearCacheWarning =>
      'क्या आपको यकीन है? अस्थायी डेटा साफ़ हो जाएगा।';

  @override
  String get clearAllData => 'सभी डेटा साफ़ करें';

  @override
  String get clearDataWarning =>
      'क्या आपको यकीन है? ऐप प्रारंभिक स्थिति में वापस आ जाएगा।';

  @override
  String get yesClear => 'हाँ, साफ़ करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get yourPrivacyMatters => 'आपकी गोपनीयता हमारे लिए महत्वपूर्ण है।';

  @override
  String get privacyRequestsDesc =>
      'Boshra केवल उन्हीं अनुमतियों का अनुरोध करता है जो इसकी सुविधाएँ प्रदान करने के लिए आवश्यक हैं।';

  @override
  String get permissions => 'अनुमतियाँ';

  @override
  String get locationPermDesc =>
      'सटीक नमाज़ के समय निर्धारित करने और आपके स्थान के आधार पर क़िबला दिशा पहचानने के लिए उपयोग किया जाता है।';

  @override
  String get statusAllowed => 'अनुमति दी गई';

  @override
  String get statusDenied => 'अस्वीकृत';

  @override
  String get notificationsPermDesc =>
      'नमाज़ के समय, अज़ान अलर्ट और अज़कार रिमाइंडर भेजने के लिए उपयोग की जाती हैं।';

  @override
  String get yourData => 'आपका डेटा';

  @override
  String get yourDataDesc1 =>
      'Boshra के लिए किसी खाते या साइन-इन की आवश्यकता नहीं है।';

  @override
  String get yourDataDesc2 =>
      'आपकी पसंद, डाउनलोड की गई सामग्री और स्थानीय सेटिंग्स ऐप की सुविधाएँ प्रदान करने के लिए आपके डिवाइस पर स्थानीय रूप से संग्रहीत की जा सकती हैं।';

  @override
  String get privacy => 'गोपनीयता';

  @override
  String get privacyPolicyDesc =>
      'जानें कि Boshra जानकारी को कैसे एकत्र, उपयोग, संग्रहीत और सुरक्षित करता है।';

  @override
  String get termsAndConditions => 'नियम और शर्तें';

  @override
  String get termsDesc => 'Boshra के उपयोग से संबंधित नियम और शर्तें पढ़ें।';

  @override
  String get dataAndPrivacy => 'डेटा और गोपनीयता';

  @override
  String get dataPrivacyDesc =>
      'Boshra द्वारा संसाधित किए जाने वाले डेटा और आपके गोपनीयता विकल्पों के बारे में जानें।';

  @override
  String get permissionManagement => 'अनुमतियों का प्रबंधन';

  @override
  String get manageLocationPerm => 'स्थान अनुमति प्रबंधित करें';

  @override
  String get manageLocationDesc =>
      'स्थान तक पहुँच बदलने के लिए डिवाइस की सेटिंग्स खोलें।';

  @override
  String get manageNotificationsPerm => 'सूचना अनुमति प्रबंधित करें';

  @override
  String get manageNotificationsDesc =>
      'सूचनाओं तक पहुँच बदलने के लिए डिवाइस की सेटिंग्स खोलें।';

  @override
  String get localData => 'स्थानीय डेटा';

  @override
  String get clearLocalDataDesc =>
      'इस डिवाइस पर संग्रहीत Boshra का स्थानीय डेटा हटाएँ।';

  @override
  String get clearDownloadsDesc =>
      'डाउनलोड की गई क़ुरआन की तिलावत और अन्य ऑफ़लाइन सामग्री हटाएँ।';

  @override
  String get privacyNote => 'गोपनीयता नोट';

  @override
  String get privacyNoteDesc =>
      'Boshra स्थान की जानकारी का उपयोग केवल उन सुविधाओं के लिए करता है जिन्हें इसकी आवश्यकता होती है, जैसे नमाज़ के समय और क़िबला दिशा।';

  @override
  String get boshraTagline => 'क़ुरआन, नमाज़ और ज़िक्र के लिए आपका दैनिक साथी।';

  @override
  String get boshraAboutDesc =>
      'Boshra एक इस्लामिक ऐप है जिसे दैनिक इबादत को अधिक सरल, शांत और सुलभ बनाने के लिए डिज़ाइन किया गया है।';

  @override
  String get whatYouCanDo => 'Boshra के साथ आप क्या कर सकते हैं?';

  @override
  String get quranDesc => 'एक साफ़ और आरामदायक अनुभव के साथ क़ुरआन पढ़ें।';

  @override
  String get quranRecitation => 'क़ुरआन की तिलावत';

  @override
  String get quranRecitationDesc => 'अपने पसंदीदा क़ारी की तिलावत सुनें।';

  @override
  String get azkarDesc =>
      'अपने दैनिक अज़कार को व्यवस्थित और आसानी से जारी रखें।';

  @override
  String get prayerTimesDesc =>
      'अपने स्थान के आधार पर सटीक नमाज़ के समय प्राप्त करें।';

  @override
  String get qiblaDesc =>
      'अपने डिवाइस के स्थान और कम्पास का उपयोग करके काबा की दिशा खोजें।';

  @override
  String get reminders => 'रिमाइंडर';

  @override
  String get remindersDesc =>
      'दिनभर अपनी इबादत से जुड़े रहने के लिए समय पर रिमाइंडर प्राप्त करें।';

  @override
  String get appInfo => 'ऐप की जानकारी';

  @override
  String get version => 'वर्ज़न';

  @override
  String get buildNumber => 'बिल्ड';

  @override
  String get moreOptions => 'अधिक';

  @override
  String get rateBoshra => 'Boshra को रेट करें';

  @override
  String get rateBoshraDesc => 'अपनी समीक्षा देकर Boshra का समर्थन करें।';

  @override
  String get shareBoshra => 'Boshra साझा करें';

  @override
  String get shareBoshraDesc => 'Boshra को परिवार और दोस्तों के साथ साझा करें।';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String get contactUsDesc => 'Mahmoud Ashraf से संपर्क करें।';

  @override
  String get openSourceLicenses => 'ओपन-सोर्स लाइसेंस';

  @override
  String get openSourceDesc =>
      'Boshra में उपयोग किए गए तृतीय-पक्ष ओपन-सोर्स सॉफ़्टवेयर के लाइसेंस देखें।';

  @override
  String get madeWithCare =>
      'उन सभी लोगों के लिए ध्यान और प्रेम से बनाया गया है जो क़ुरआन और ज़िक्र से और करीब होना चाहते हैं।';

  @override
  String get locationText => 'स्थान';

  @override
  String get privacyPolicyText => 'गोपनीयता नीति';

  @override
  String get clearLocalDataText => 'स्थानीय डेटा साफ़ करें';

  @override
  String get prayerTimesText => 'प्रार्थना का समय';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeLightDesc => 'साफ और हल्का इंटरफ़ेस';

  @override
  String get themeDark => 'गहरा';

  @override
  String get themeDarkDesc => 'गहरा और आरामदायक इंटरफ़ेस';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeSystemDesc => 'डिवाइस सेटिंग्स का पालन करें';

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
