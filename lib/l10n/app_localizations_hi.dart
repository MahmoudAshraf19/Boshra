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
}
