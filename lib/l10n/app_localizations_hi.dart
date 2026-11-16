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
  String get navRadio => 'रेडियो';

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
  String get live => 'लाइव';

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
  String get azkarScreenTitle => 'अज़कार';

  @override
  String get azkarScreenSubtitle => 'अल्लाह के क़रीब… हर पल';

  @override
  String get azkarCategoryMorning => 'सुबह के अज़कार';

  @override
  String get azkarCategoryMorningSub => 'सुबह के ज़िक्र';

  @override
  String get azkarCategoryEvening => 'शाम के अज़कार';

  @override
  String get azkarCategoryEveningSub => 'शाम के ज़िक्र';

  @override
  String get azkarCategoryPrayer => 'नमाज़ के बाद';

  @override
  String get azkarCategoryPrayerSub => 'नमाज़ के बाद के ज़िक्र';

  @override
  String get azkarCategorySleep => 'सोने के अज़कार';

  @override
  String get azkarCategorySleepSub => 'सोने से पहले के ज़िक्र';

  @override
  String get azkarCategoryProtection => 'सुरक्षा के अज़कार';

  @override
  String get azkarCategoryProtectionSub => 'सुरक्षा और सुकून के लिए';

  @override
  String get azkarCategoryDaily => 'दैनिक अज़कार';

  @override
  String get azkarCategoryDailySub => 'दिनभर के लिए विभिन्न ज़िक्र';

  @override
  String get azkarAllCategories => 'सभी श्रेणियाँ';

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
  String get locationPermissionTitle => 'लोकेशन एक्सेस की अनुमति दें';

  @override
  String get locationPermissionDesc =>
      'आपकी मौजूदा स्थिति से क़िब्ला की सही दिशा निकालने के लिए हमें आपकी लोकेशन चाहिए।';

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
  String get startupLocationTitle => 'लोकेशन एक्सेस';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'सटीक नमाज़ के समय और क़िब्ला दिशा के लिए हमें आपकी लोकेशन चाहिए।\n\nअनुमति न देने पर हम आपकी आख़िरी सहेजी गई लोकेशन इस्तेमाल करेंगे: $locationName।';
  }

  @override
  String get startupLocationDescDefault =>
      'सटीक नमाज़ के समय और क़िब्ला दिशा के लिए हमें आपकी लोकेशन चाहिए।\n\nअनुमति न देने पर हम डिफ़ॉल्ट लोकेशन इस्तेमाल करेंगे: मक्का, सऊदी अरब।';

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
  String get soundType => 'सूचना का प्रकार';

  @override
  String get soundSilent => 'मौन (बिना आवाज़)';

  @override
  String get soundShort => 'छोटी बीप';

  @override
  String get soundAdhan => 'पूरी अज़ान';

  @override
  String get prePrayerAlertDesc => 'अज़ान से पहले मुझे सूचित करें';

  @override
  String prayerNotifTitle(String prayerName) {
    return '$prayerName की नमाज़ का समय हो गया';
  }

  @override
  String get prayerNotifBody => 'नमाज़ की तरफ़ आइए';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return '$prayerName की नमाज़ क़रीब है';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'अज़ान में $minutes मिनट बाक़ी हैं';
  }

  @override
  String get notifDisabledTitle => 'सूचनाएँ बंद हैं';

  @override
  String get notifDisabledDesc =>
      'सूचनाएँ चालू करें ताकि अज़ान और रिमाइंडर समय पर मिलें।';

  @override
  String get exactAlarmTitle => 'सटीक अलार्म बंद हैं';

  @override
  String get exactAlarmDesc =>
      '«अलार्म और रिमाइंडर» की अनुमति दें ताकि अज़ान ठीक समय पर आए।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get retry => 'दोबारा कोशिश करें';

  @override
  String get errorGeneric => 'कुछ गड़बड़ हो गई। कृपया दोबारा कोशिश करें।';

  @override
  String get errorNoInternet =>
      'इंटरनेट कनेक्शन नहीं है। कनेक्शन जाँचकर दोबारा कोशिश करें।';

  @override
  String get errorLoadFailed => 'सामग्री लोड नहीं हो सकी।';

  @override
  String get downloadingProgress => 'डाउनलोड हो रहा है…';

  @override
  String get downloadSuccess => 'सफलतापूर्वक डाउनलोड हुआ';

  @override
  String get downloadFailed => 'डाउनलोड विफल रहा। दोबारा कोशिश करें।';

  @override
  String get shareFailed => 'छवि नहीं बन सकी। दोबारा कोशिश करें।';

  @override
  String get audioLoadFailed => 'ऑडियो नहीं चल सका। कनेक्शन जाँचें।';

  @override
  String get radioLoadFailed => 'स्टेशन लोड नहीं हो सके';

  @override
  String get continueReadingBtn => 'पढ़ना जारी रखें';

  @override
  String get permSetupTitle => 'कोई नमाज़ न छूटे';

  @override
  String get permSetupSubtitle =>
      'एक बार कुछ अनुमतियाँ दे दें ताकि अज़ान और रिमाइंडर हमेशा सही समय पर आएँ — ऐप बंद होने पर भी।';

  @override
  String get permNotifTitle => 'सूचनाएँ';

  @override
  String get permNotifDesc =>
      'अज़ान, नमाज़ के रिमाइंडर, अज़कार और क़ुरआन संदेश दिखाने के लिए।';

  @override
  String get permExactTitle => 'अलार्म और रिमाइंडर';

  @override
  String get permExactDesc =>
      'Android को ठीक उसी मिनट पर अज़ान देने की अनुमति देता है।';

  @override
  String get permBatteryTitle => 'बिना प्रतिबंध बैटरी';

  @override
  String get permBatteryDesc =>
      'सिस्टम को ऐप सुलाने और सूचनाएँ गिराने से रोकता है।';

  @override
  String get permAutostartTitle => 'ऑटो-स्टार्ट और बैकग्राउंड';

  @override
  String permAutostartDesc(String brand) {
    return 'आपका फ़ोन ($brand) बैकग्राउंड ऐप रोक सकता है। बशरा को ऑटो-स्टार्ट और बैकग्राउंड में चलने दें।';
  }

  @override
  String get permChannelsTitle => 'सूचना श्रेणियाँ और आवाज़';

  @override
  String get permChannelsDesc =>
      'कुछ सूचना श्रेणियाँ बंद हैं। अज़ान सुनने के लिए उन्हें चालू करें।';

  @override
  String get permAllowAll => 'सब की अनुमति दें';

  @override
  String get permAllow => 'अनुमति';

  @override
  String get permGranted => 'अनुमति मिली';

  @override
  String get permContinue => 'जारी रखें';

  @override
  String get permLater => 'बाद में';

  @override
  String get permAllSet => 'सब तैयार! सूचनाएँ भरोसेमंद तरीके से आएँगी।';

  @override
  String get permMissingNote =>
      'कुछ अनुमतियाँ अभी बंद हैं। सूचनाएँ देर से आ सकती हैं या नहीं आ सकतीं।';

  @override
  String get permFix => 'अभी ठीक करें';

  @override
  String get adhanStopAction => 'अज़ान रोकें';

  @override
  String get adhanBannerTitle => 'अज़ान बैनर';

  @override
  String get adhanBannerDesc =>
      'अज़ान के समय स्क्रीन के ऊपर और लॉक स्क्रीन पर दिखता है, अज़ान रोकने के बटन के साथ।';

  @override
  String get adhanBannerPreview => 'बैनर पूर्वावलोकन';

  @override
  String get adhanBannerVerse =>
      'निःसंदेह नमाज़ ईमान वालों पर निश्चित समयों में फ़र्ज़ की गई है।';

  @override
  String get notifSettingsTitle => 'सूचनाएँ और अज़ान';

  @override
  String get modeSilent => 'मौन';

  @override
  String get modeShort => 'छोटा अलर्ट';

  @override
  String get modeAdhan => 'पूरी अज़ान';

  @override
  String get modeSilentDesc => 'बिना आवाज़ की सूचना';

  @override
  String get modeShortDesc => 'सामान्य सूचना ध्वनि';

  @override
  String get modeAdhanDesc => 'पूरी अज़ान, रोकने के बटन के साथ';

  @override
  String minutesShort(int minutes) {
    return '$minutes मिनट';
  }

  @override
  String get remindersSection => 'दैनिक अनुस्मारक';

  @override
  String afterFajrDesc(int minutes) {
    return 'फ़ज्र के $minutes मिनट बाद';
  }

  @override
  String afterAsrDesc(int minutes) {
    return 'अस्र के $minutes मिनट बाद (सूर्यास्त से पहले)';
  }

  @override
  String get ayahReminderTitle => 'आज की आयत';

  @override
  String get ayahReminderDesc => 'हर दिन आपके चुने समय पर एक नई आयत';

  @override
  String get reminderTime => 'समय';

  @override
  String get muadhinTitle => 'मुअज़्ज़िन';

  @override
  String get atAdhanTime => 'अज़ान के समय';

  @override
  String get advancedSection => 'सटीकता और गणना';

  @override
  String get calcMethodTitle => 'गणना विधि';

  @override
  String get calcMethodAuto => 'स्वचालित (आपके स्थान के अनुसार)';

  @override
  String get asrSchoolTitle => 'अस्र की गणना';

  @override
  String get asrStandard => 'मानक (शाफ़ई, मालिकी, हंबली)';

  @override
  String get asrHanafi => 'हनफ़ी';

  @override
  String get adjustTimesTitle => 'समय का सूक्ष्म समायोजन (मिनट)';

  @override
  String get testAdhanButton => 'अभी अज़ान आज़माएँ';

  @override
  String get locationFallbackWarning =>
      'आपका स्थान उपलब्ध नहीं है, इसलिए समय मक्का के लिए गणना किए गए हैं। सटीक समय के लिए लोकेशन चालू करें।';

  @override
  String get sadaqaJariyaTitle => 'सदक़ा-ए-जारिया (जारी सदक़ा)';

  @override
  String get sadaqaHadith =>
      '«जो किसी को भलाई की राह दिखाता है, उसे भलाई करने वाले जितना ही सवाब मिलता है»';

  @override
  String get narratedByMuslim => 'हदीस: सहीह मुस्लिम';

  @override
  String get yourInviteCode => 'आपका इनवाइट कोड';

  @override
  String get codeCopied => 'कोड कॉपी हो गया';

  @override
  String get shareAppButton => 'ऐप शेयर करें';

  @override
  String get shareViaWhatsApp => 'व्हाट्सएप पर शेयर करें';

  @override
  String get startFirstShare => 'अपनी पहली शेयरिंग शुरू करें 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'आपने $count बार शेयर किया — अल्लाह क़बूल फ़रमाए';
  }

  @override
  String get haveFriendCode => 'क्या आपके पास दोस्त का इनवाइट कोड है?';

  @override
  String recordedInviteFrom(Object code) {
    return 'इनवाइट $code दर्ज हो गया — जज़ाकल्लाहु खैरा';
  }

  @override
  String get invalidInviteCode => 'अमान्य कोड (उदा: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'यह आपका अपना कोड है 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'मैं अज़ान, क़ुरआन और अज़कार के लिए «बुशरा» ऐप इस्तेमाल करता हूँ — इसे ज़रूर आज़माएँ 🌙\nइसे सदक़ा-ए-जारिया समझकर शेयर करें — «जो किसी को भलाई की राह दिखाता है, उसे भलाई करने वाले जितना ही सवाब मिलता है»\n\n$link\nइनवाइट कोड: $code';
  }

  @override
  String get diagTitle => 'क्या अज़ान बजेगी?';

  @override
  String get diagAllGood => 'सब ठीक है — इंशाअल्लाह अज़ान समय पर बजेगी';

  @override
  String diagCanImprove(Object count) {
    return 'अज़ान बजनी चाहिए, लेकिन $count चीज़ों को ठीक किया जा सकता है';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count दिक्कतें अज़ान रोक सकती हैं — नीचे दिए गए बटनों से ठीक करें';
  }

  @override
  String get diagFix => 'ठीक करें';

  @override
  String get diagTestAdhanNow => 'अभी अज़ान टेस्ट करें';

  @override
  String get diagReschedule => 'फिर से शेड्यूल करें';

  @override
  String get diagRecentEvents => 'हालिया घटनाएं';

  @override
  String get diagNoEvents => 'अभी तक कोई गतिविधि नहीं';

  @override
  String get diagCopyReport => 'सपोर्ट के लिए रिपोर्ट कॉपी करें';

  @override
  String get diagReportCopied => 'सपोर्ट रिपोर्ट कॉपी हो गई';

  @override
  String get diagNotifications => 'नोटिफिकेशन्स';

  @override
  String get diagNotifEnabled => 'चालू हैं';

  @override
  String get diagNotifBlocked => 'बंद हैं — अज़ान स्क्रीन पर नहीं आएगी';

  @override
  String get diagEnable => 'चालू करें';

  @override
  String get diagChannels => 'नोटिफिकेशन चैनल्स';

  @override
  String get diagChannelsAllEnabled => 'सभी चालू हैं';

  @override
  String get diagChannelMuted => 'फ़ोन सेटिंग्स में एक चैनल म्यूट है';

  @override
  String get diagOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get diagExactAlarms => 'सटीक अलार्म';

  @override
  String get diagExactAlarmsAllowed =>
      'अनुमति है — अज़ान बिल्कुल सही सेकंड पर बजेगी';

  @override
  String get diagExactAlarmsNotAllowed =>
      'अनुमति नहीं है — अज़ान देर से हो सकती है';

  @override
  String get diagAllow => 'अनुमति दें';

  @override
  String get diagBattery => 'बैटरी ऑप्टिमाइज़ेशन';

  @override
  String get diagBatteryExempt => 'ऐप छूट प्राप्त है';

  @override
  String get diagBatteryMayKill => 'सिस्टम बैकग्राउंड में ऐप को बंद कर सकता है';

  @override
  String get diagExempt => 'छूट दें';

  @override
  String get diagPrayerMode => 'नमाज़ मोड';

  @override
  String get diagPrayerModeFullSilence =>
      'पूरा साइलेंट तैयार है (DND अनुमति मिली हुई है)';

  @override
  String get diagPrayerModeVibrateOnly =>
      '«DND» अनुमति के बिना केवल वाइब्रेशन ही हो पाएगा';

  @override
  String get diagGrantPermission => 'अनुमति दें';

  @override
  String get diagAutostart => 'ऑटो-स्टार्ट';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'सेट हो गया ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return '$brand डिवाइस बैकग्राउंड ऐप्स बंद करता है — ऑटो-स्टार्ट चालू करें';
  }

  @override
  String get diagOpen => 'खोलें';

  @override
  String get diagLocation => 'स्थान (लोकेशन)';

  @override
  String diagLocationManual(Object city) {
    return 'मैन्युअल चुना गया शहर: $city';
  }

  @override
  String get diagLocationApprox => 'अनुमानित';

  @override
  String get diagLocationUnknown => 'अज्ञात — डिफ़ॉल्ट शहर इस्तेमाल हो रहा है';

  @override
  String get diagLocationGpsOff => 'लोकेशन सेवा (GPS) बंद है';

  @override
  String get diagLocationDenied => 'लोकेशन अनुमति अस्वीकृत है';

  @override
  String get diagLocationPermanentlyDenied =>
      'अनुमति स्थायी रूप से अस्वीकृत — सेटिंग्स खोलें';

  @override
  String get diagLocationNoFix => 'डिवाइस स्थान तय नहीं कर सका (कमज़ोर सिग्नल)';

  @override
  String get diagLocationMock => 'नकली लोकेशन चालू है — अनदेखा किया गया';

  @override
  String get diagLocationTzMismatch => 'लोकेशन टाइमज़ोन से मेल नहीं खाती';

  @override
  String get diagFixLocation => 'लोकेशन सही करें';

  @override
  String get diagSetLocation => 'तय करें';

  @override
  String get diagLastScheduling => 'पिछला शेड्यूल';

  @override
  String get diagNeverScheduled => 'अभी तक शेड्यूल नहीं हुआ';

  @override
  String get diagScheduleNow => 'अभी शेड्यूल करें';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count अलर्ट्स';
  }

  @override
  String get diagScheduleIncomplete => 'अधूरा (ऑफ़लाइन गणना)';

  @override
  String get diagScheduleError => 'त्रुटि हुई';

  @override
  String get diagNextAdhan => 'अगली अज़ान';

  @override
  String get diagAllPrayersSilent =>
      'सभी नमाज़ें शॉर्ट/साइलेंट पर सेट हैं (पूरी अज़ान नहीं)';

  @override
  String diagArmedAdhansCount(Object count) {
    return 'सिस्टम में $count अज़ानें शेड्यूल हैं';
  }

  @override
  String get diagNoAdhanArmed =>
      'अलार्म में कोई अज़ान शेड्यूल नहीं है! शेड्यूल दबाएँ';

  @override
  String get diagOfflineMode => 'ऑफ़लाइन मोड';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count महीने सेव हैं — बिना इंटरनेट काम करेगा';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'केवल $count महीना सेव है (इंटरनेट आने पर पूरा होगा)';
  }

  @override
  String get diagInternet => 'इंटरनेट';

  @override
  String get diagInternetConnected => 'नमाज़ समय सर्वर से जुड़ा है';

  @override
  String get diagInternetUnavailable =>
      'अभी उपलब्ध नहीं — सेव किए गए समय काफ़ी हैं';

  @override
  String get diagTestAdhanTitle => 'अज़ान टेस्ट';

  @override
  String get diagTestAdhanBody => 'अगर आपको आवाज़ आ रही है तो सब ठीक है';

  @override
  String get diagStop => 'रोकें';

  @override
  String get diagAgoJustNow => 'अभी';

  @override
  String diagAgoMinutes(Object m) {
    return '$m मिनट पहले';
  }

  @override
  String diagAgoHours(Object h) {
    return '$h घंटे पहले';
  }

  @override
  String diagAgoDays(Object d) {
    return '$d दिन पहले';
  }

  @override
  String get zakatCalculatorTitle => 'ज़कात कैलकुलेटर';

  @override
  String get zakatCurrency => 'मुद्रा (करेंसी)';

  @override
  String get zakatTodayPricesGram => 'आज के भाव (प्रति ग्राम)';

  @override
  String get zakatRefresh => 'रिफ्रेश';

  @override
  String get zakatEditManually => 'खुद बदलें';

  @override
  String get zakatCouldNotLoadPrices =>
      'भाव लोड नहीं हो सके (ऑफ़लाइन)। प्रति ग्राम भाव डालने के लिए ✏️ पर टैप करें।';

  @override
  String get zakatGold24 => '24 कैरेट सोना';

  @override
  String get zakatGold21 => '21 कैरेट सोना';

  @override
  String get zakatGold18 => '18 कैरेट सोना';

  @override
  String get zakatSilver => 'चांदी';

  @override
  String get zakatGram => 'ग्राम';

  @override
  String get zakatUsingManualPrices =>
      '✏️ आपके दर्ज किए भाव इस्तेमाल हो रहे हैं';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'वैश्विक भाव × विनिमय दर — अपडेट: $date';
  }

  @override
  String get zakatPriceOld => ' (पुराना)';

  @override
  String get zakatNisab => 'निसाब';

  @override
  String get zakatGoldNisab => 'सोना (85 ग्राम)';

  @override
  String get zakatSilverNisab => 'चांदी (595 ग्राम)';

  @override
  String get zakatNisabExplanation =>
      'अपने विश्वस्त उलेमा या दारुल इफ़्ता के अनुसार निसाब चुनें। चांदी का निसाब कम मूल्य का होता है, जिससे अधिक लोग शामिल होते हैं।';

  @override
  String get zakatYourWealth => 'आपकी संपत्ति';

  @override
  String get zakatCashSavings => 'नकद, बचत और बैंक खाते';

  @override
  String get zakatSharesInvestments => 'शेयर और निवेश';

  @override
  String get zakatTradeGoods => 'व्यापार का माल (बाज़ार भाव)';

  @override
  String get zakatMoneyOwedToYou => 'दूसरों पर आपका सुरक्षित क़र्ज़';

  @override
  String get zakatDebtsDue => 'तुरंत चुकाने वाले क़र्ज़ (घटाए जाएंगे)';

  @override
  String get zakatJewelleryNote =>
      'इस्तेमाल के ज़ेवरात पर ज़कात में मतभेद है; अगर आपकी मान्यता में ज़कात नहीं है तो सोने का कॉलम खाली छोड़ दें।';

  @override
  String get zakatTotalZakatableWealth => 'कुल ज़कात योग्य संपत्ति';

  @override
  String get zakatEnterPriceForNisab =>
      'निसाब निकालने के लिए सोने/चांदी का भाव डालें';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'निसाब: $amount $cur';
  }

  @override
  String get zakatDue25 => 'वाजिब ज़कात (2.5%)';

  @override
  String get zakatHawlCondition =>
      'शर्त यह है कि इस माल पर पूरा एक हिजरी साल बीत चुका हो।';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'आपकी संपत्ति निसाब तक नहीं पहुँची ($amount $cur कम है) — अभी ज़कात फ़र्ज़ नहीं है।';
  }

  @override
  String get zakatCopyResult => 'परिणाम कॉपी करें';

  @override
  String get zakatResultCopied => 'परिणाम कॉपी हो गया';

  @override
  String get zakatYearlyReminder => 'सालाना ज़कात रिमाइंडर';

  @override
  String get zakatReminderExplanation =>
      'वह तारीख चुनें जब आपकी संपत्ति निसाब तक पहुँची थी। हम साल पूरा होने से एक हफ़्ते पहले और उस दिन याद दिलाएँगे।';

  @override
  String get zakatSetDate => 'तारीख चुनें';

  @override
  String zakatNextDue(Object date) {
    return 'अगला वर्ष: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'नोट: यह केवल सामान्य मार्गदर्शन के लिए है। विशेष मामलों के लिए अपने स्थानीय उलेमा से संपर्क करें।';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'स्थानीय मैन्युअल भाव ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'आपके स्थानीय सराफ़ा बाज़ार का भाव अलग हो सकता है। अपना प्रति ग्राम भाव डालें या खाली छोड़ दें।';

  @override
  String get zakatGold24PerGram => '24 कैरेट सोना प्रति ग्राम';

  @override
  String get zakatSilverPerGram => 'चांदी प्रति ग्राम';

  @override
  String get zakatPickHawlHelp => 'वह तारीख जब संपत्ति निसाब तक पहुँची';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'ज़कात — बुशरा ऐप\nकुल ज़कात योग्य संपत्ति: $total $cur\nनिसाब ($nisabType): $nisabVal $cur\nवाजिब ज़कात (2.5%): $due $cur';
  }

  @override
  String get trackerTitle => 'नमाज़ ट्रैकर';

  @override
  String get trackerTimeNotStarted => 'अभी इस नमाज़ का वक़्त शुरू नहीं हुआ 🌙';

  @override
  String get trackerLearningHabits => '🧠 आपकी आदतों का विश्लेषण';

  @override
  String get trackerLearningDesc =>
      'कम से कम 5 दिन तक अपनी नमाज़ें दर्ज करें, हम आपके अनुकूल सुझाव देंगे (विश्लेषण केवल आपके फ़ोन पर होगा)।';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 फ़ज्र छूट रही है: पिछले $days दिनों में $missed बार';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'जल्दी सोने का रिमाइंडर हर रात $time बजे चालू है 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'फ़ज्र छूटने की मुख्य वजह देर से सोना है। क्या आप हर रात जल्दी सोने का रिमाइंडर चाहते हैं?';

  @override
  String trackerTurnOnTime(Object time) {
    return 'चालू करें ($time)';
  }

  @override
  String get trackerNotNow => 'अभी नहीं';

  @override
  String get trackerChangeTime => 'समय बदलें';

  @override
  String get trackerTurnOff => 'बंद करें';

  @override
  String get trackerPickAnotherTime => 'दूसरा समय चुनें';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer अक्सर अंतिम समय में पढ़ी जा रही है';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'हमने $prayer का रिमाइंडर पहले (मध्य समय में) कर दिया है ताकि नमाज़ समय पर हो।';
  }

  @override
  String get trackerGreatConsistency => '✨ आपकी पाबंदी बहुत अच्छी है';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 जिस नमाज़ पर ध्यान चाहिए: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'कोई भी नमाज़ बार-बार नहीं छूट रही। बहुत बढ़िया, जारी रखें!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'पिछले $days दिनों में $missed बार छूटी। जेंटल रिमाइंडर आपकी मदद करेगा।';
  }

  @override
  String get trackerTurnOffNudge => 'जेंटल रिमाइंडर बंद करें';

  @override
  String get trackerTurnOnNudge => 'जेंटल रिमाइंडर चालू करें';

  @override
  String get trackerStopLearning => 'मेरी आदतों का विश्लेषण रोकें';

  @override
  String get trackerStartLearning => 'मेरी आदतों का विश्लेषण चालू करें';

  @override
  String get trackerStartStreakToday => 'आज से अपनी लड़ी शुरू करें';

  @override
  String trackerStreakDays(Object count) {
    return 'लगातार $count दिन, सभी पाँचों नमाज़ें';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'सर्वश्रेष्ठ स्ट्रीक: $best — इस सप्ताह: $pct%';
  }

  @override
  String get trackerToday => 'आज';

  @override
  String get trackerYesterday => 'कल (बीता हुआ)';

  @override
  String get trackerYourGarden => 'आपका बाग़ीचा 🌳';

  @override
  String get trackerGardenDesc =>
      'हर नमाज़ का एक पेड़ है जो आपकी पाबंदी के साथ बड़ा होता है';

  @override
  String get trackerDayUnit => 'दिन';

  @override
  String get trackerTodayPrayers => 'आज की नमाज़ें';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'नमाज़ें $date';
  }

  @override
  String get trackerPrayedMark => 'अदा की ✓';

  @override
  String get trackerNotMarked => 'दर्ज नहीं';

  @override
  String get trackerThisWeek => 'इस सप्ताह के आंकड़े';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'कुल दर्ज नमाज़ें: $count';
  }

  @override
  String get gardenTitle => 'मेरा बाग़';

  @override
  String get gardenHomeCardTitle => 'आपका नमाज़ बाग़ीचा 🌳';

  @override
  String get gardenEnterFull => 'अपने पूरे बाग़ीचे में जाएँ 🌿';

  @override
  String get gardenTooEarlySeed => 'अभी समय है… बीज इंतज़ार कर रहा है 🌱';

  @override
  String get gardenChooseMonth => 'महीना चुनें';

  @override
  String get gardenOf => 'बाग़:';

  @override
  String get gardenHijriSuffix => 'हिजरी';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count संपूर्ण दिन';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'सर्वश्रेष्ठ लड़ी $count';
  }

  @override
  String get gardenBlessedForest => 'एक बरकत भरा बाग़';

  @override
  String gardenWeekNumber(Object num) {
    return 'सप्ताह $num';
  }

  @override
  String get gardenMsgFlourishing =>
      'माशाअल्लाह! एक हरा-भरा और सुंदर बाग़ 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'सुंदर बाग़ीचा — ऐसे ही जारी रखें, यह घना बाग़ बनेगा 🌿';

  @override
  String get gardenMsgWaterToday =>
      'हर नमाज़ पेड़ को सींचती है। आज से ही शुरू करें 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'बाग़ीचा इंतज़ार कर रहा है… पहली नमाज़ पहला पौधा रोपेगी 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'अदा की ✓ समय $time';
  }

  @override
  String get plantStatusPrayed => 'अदा की ✓';

  @override
  String get plantStatusPending => 'वक़्त हो चुका है — अभी दर्ज नहीं किया 💧';

  @override
  String get plantStatusMissed => 'दर्ज नहीं — पौधे को पानी की ज़रूरत है';

  @override
  String get plantStatusUpcoming => 'अभी वक़्त नहीं हुआ 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'फलदार पेड़! $prayer पर लगातार $streak दिन 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return '$prayer पर लगातार $streak दिन 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return '$prayer की स्ट्रीक का $streakवां दिन';
  }

  @override
  String get plantWaterConsistency =>
      'हर नमाज़ पौधे को बड़ा करती है — आपकी पाबंदी ही इसका पानी है 💧';

  @override
  String get plantUndo => 'वापस लें';

  @override
  String get plantWaterAction => 'मैंने नमाज़ पढ़ी — पौधे को सींचें 💧';

  @override
  String get plantStageSeed => 'बीज';

  @override
  String get plantStageSprout => 'अंकुर';

  @override
  String get plantStageSapling => 'पौधा';

  @override
  String get plantStageYoungTree => 'छोटा पेड़';

  @override
  String get plantStageTree => 'पेड़';

  @override
  String get plantStageFruitTree => 'फलदार पेड़';

  @override
  String get treeCherryBlossom => 'चेरी ब्लॉसम';

  @override
  String get treeDatePalm => 'खजूर का पेड़';

  @override
  String get treeOrangeTree => 'संतरे का पेड़';

  @override
  String get treePomegranate => 'अनार का पेड़';

  @override
  String get treeCypress => 'सनोबर का पेड़';

  @override
  String get weeklySummaryTitle => 'साप्ताहिक सारांश';

  @override
  String get weeklyShareAsImage => 'फ़ोटो के रूप में शेयर करें';

  @override
  String get weeklyNoPrayersLogged =>
      'इस हफ़्ते अभी तक कोई नमाज़ दर्ज नहीं हुई। होम स्क्रीन के बाग़ीचे से शुरुआत करें 🌱';

  @override
  String get weeklyShareYourTree => 'अपने हफ़्ते का पेड़ शेयर करें';

  @override
  String get weeklyNotificationHint =>
      'हर जुमा ईशा के बाद आपको अपने हफ़्ते का सारांश मिलता है।';

  @override
  String get weeklyImageError =>
      'फ़ोटो तैयार नहीं हो सकी, कृपया दोबारा प्रयास करें';

  @override
  String get weeklyCardTitle => 'मेरा साप्ताहिक सारांश';

  @override
  String get weeklyCardTreeSubtitle => 'इस सप्ताह मेरा नमाज़ का पेड़ 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return 'इंशाअल्लाह मेरी $pct% नमाज़ें समय पर अदा हुईं';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'सबसे पाबंद नमाज़: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'कमज़ोर पाबंदी: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 लगातार $count दिन, सभी पाँचों नमाज़ें';
  }

  @override
  String get weeklyCardAppBranding => 'बुशरा ऐप — अज़ान, अज़कार और क़ुरआन';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'आपने $max में से $total नमाज़ें पढ़ीं';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'आपकी सबसे नियमित नमाज़: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'और सबसे कमज़ोर: $prayer';
  }

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';
}
