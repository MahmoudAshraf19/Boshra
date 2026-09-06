// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Boshra';

  @override
  String get onboarding1Title =>
      'Bushra... Your companion on the path of goodness';

  @override
  String get onboarding1Desc =>
      'Make your day closer to Allah, with simple steps and acts of worship always present with you.';

  @override
  String get onboarding2Title =>
      'Everything you need for your worship, in one place';

  @override
  String get onboarding2Desc =>
      'Quran, prayer times, Adhkar, Qibla, and supplications... in a simple experience.';

  @override
  String get onboarding3Title => 'A small step every day... makes a big impact';

  @override
  String get onboarding3Desc =>
      'Build your faith habits, and seize the moments of your day.';

  @override
  String get startJourney => 'Start your journey';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Quran';

  @override
  String get navAzkar => 'Azkar';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'More';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'Until $prayerName';
  }

  @override
  String get greeting => 'Assalamu Alaikum👋';

  @override
  String get surahs => 'Surahs';

  @override
  String get juzs => 'Juzs';

  @override
  String get prayerSettingsTitle => 'Prayer and Adhan Settings';

  @override
  String get prePrayerAlertTitle => 'Pre-Prayer Alert (Before Adhan)';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes minutes before Adhan';
  }

  @override
  String get enablePrayerAlertsTitle => 'Enable Prayer Alerts';

  @override
  String get fajr => 'Fajr';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get ayahOfTheDay => 'Ayah of the Day';

  @override
  String get listen => 'Listen';

  @override
  String get tafseer => 'Tafseer';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return '$surahName • Verse $verseNumber';
  }

  @override
  String get dailyWird => 'Complete Your Daily Wird';

  @override
  String get morningAzkar => 'Morning Azkar';

  @override
  String get eveningAzkar => 'Evening Azkar';

  @override
  String get continueReading => 'Continue';

  @override
  String get morningAzkarNotificationTitle => 'Morning Azkar 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'Start your day with the remembrance of Allah';

  @override
  String get eveningAzkarNotificationTitle => 'Evening Azkar 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'End your day with the remembrance of Allah';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get qibla => 'Qibla';

  @override
  String get recitation => 'Recitation';

  @override
  String get quran => 'Quran';

  @override
  String get quranRadio => 'Quran Radio';

  @override
  String get azkar => 'Azkar';

  @override
  String get continueReadingCardTitle => 'Continue Reading';

  @override
  String surahName(String surahName) {
    return 'Surah $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'Ayah $number';
  }

  @override
  String get selectedRecitationTitle => 'Selected Recitation';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'The Holy Quran';

  @override
  String get startQuranJourney => 'Start your journey with the Quran';

  @override
  String get openSurahAndRead => 'Open a Surah and start reading';

  @override
  String get browseSurahs => 'Browse Surahs';

  @override
  String get searchSurah => 'Search for a Surah...';

  @override
  String get tabSurahs => 'Surahs';

  @override
  String get tabJuzs => 'Juzs';

  @override
  String get tabHizbs => 'Hizbs';

  @override
  String get meccan => 'Meccan';

  @override
  String get medinan => 'Medinan';

  @override
  String ayahsCount(Object count) {
    return '$count Verses';
  }

  @override
  String get tafsirOption => 'Tafsir';

  @override
  String get recitationOption => 'Recitation';

  @override
  String get downloadOption => 'Download';

  @override
  String get shareOption => 'Share';

  @override
  String get infoOption => 'Information';

  @override
  String get copyOption => 'Copy';

  @override
  String get copiedSuccessfully => 'Ayah copied to clipboard';

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
  String get quranMessageNotificationTitle => 'Message from the Quran 🌿';

  @override
  String get saveBookmark => 'Save Bookmark';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'Bookmark saved at Surah $surahName Ayah $ayahNumber';
  }
}
