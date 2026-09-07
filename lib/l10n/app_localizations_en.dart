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

  @override
  String get qiblaDirection => 'Qibla Direction';

  @override
  String get qiblaAccurate => 'Qibla is Accurate';

  @override
  String get youAreFacingQibla => 'You are now facing the Qibla';

  @override
  String get qiblaCalibration => 'Qibla Calibration';

  @override
  String get qiblaCalibrationDesc =>
      'Please move your phone slowly in a figure-8 motion until the compass is calibrated.';

  @override
  String get findingLocation => 'Finding location...';

  @override
  String get locationPermissionError =>
      'Unable to access location. Please enable GPS.';

  @override
  String get locationPermissionTitle => 'Allow Location Access';

  @override
  String get locationPermissionDesc =>
      'We need your location to accurately calculate the Qibla direction based on your current position.';

  @override
  String get preciseQibla => 'Precise Qibla';

  @override
  String get exactLocation => 'Your Exact Location';

  @override
  String get alwaysUpToDate => 'Always Up to Date';

  @override
  String get allowLocationBtn => 'Allow Location Access';

  @override
  String get notNow => 'Not Now';

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
  String get moreScreenTitle => 'More';

  @override
  String get generalSettings => 'General';

  @override
  String get appearance => 'Appearance';

  @override
  String get systemDefault => 'System Default';

  @override
  String get appLanguage => 'App Language';

  @override
  String get alertsSettings => 'Alerts';

  @override
  String get notifications => 'Notifications';

  @override
  String get adhanAndReminders => 'Adhan & prayer reminders';

  @override
  String get dataAndStorage => 'Data & Storage';

  @override
  String get storage => 'Storage';

  @override
  String get storageDesc => 'Manage downloaded Surahs';

  @override
  String get infoAndSupport => 'Info & Support';

  @override
  String get privacyAndPermissions => 'Privacy & Permissions';

  @override
  String get aboutBoshra => 'About Boshra';

  @override
  String get downloadedOption => 'Downloaded';

  @override
  String get totalUsed => 'Total Used';

  @override
  String get systemApp => 'System (App Size)';

  @override
  String get downloadedSurahs => 'Downloaded Surahs';

  @override
  String get cache => 'Cache';

  @override
  String get manageDownloads => 'Manage Downloads';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get clearAllDownloads => 'Clear All Downloads';

  @override
  String get clearWarning =>
      'This will remove all downloaded content and cannot be undone.';

  @override
  String get notEnoughSpace => 'Not enough storage space (Limit 3GB reached).';

  @override
  String get clearCacheWarning =>
      'Are you sure? This will delete some temporary data like your saved location.';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearDataWarning =>
      'Are you sure? This will delete all your data, settings, and downloads. The app will return to its initial state.';

  @override
  String get yesClear => 'Yes, Clear';

  @override
  String get cancel => 'Cancel';

  @override
  String get yourPrivacyMatters => 'Your privacy matters to us.';

  @override
  String get privacyRequestsDesc =>
      'Boshra requests only the permissions needed to provide its features.';

  @override
  String get permissions => 'Permissions';

  @override
  String get locationPermDesc =>
      'Used to calculate accurate prayer times and determine the Qibla direction based on your location.';

  @override
  String get statusAllowed => 'Allowed';

  @override
  String get statusDenied => 'Denied';

  @override
  String get notificationsPermDesc =>
      'Used to send prayer times, Adhan alerts, and Azkar reminders.';

  @override
  String get yourData => 'Your Data';

  @override
  String get yourDataDesc1 => 'Boshra does not require an account or sign-in.';

  @override
  String get yourDataDesc2 =>
      'Your preferences, downloaded content, and local app settings may be stored on your device to provide the app\'s features.';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyPolicyDesc =>
      'Learn how Boshra collects, uses, stores, and protects information.';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get termsDesc => 'Read the terms governing your use of Boshra.';

  @override
  String get dataAndPrivacy => 'Data & Privacy';

  @override
  String get dataPrivacyDesc =>
      'Learn about the information processed by Boshra and your privacy choices.';

  @override
  String get permissionManagement => 'Permission Management';

  @override
  String get manageLocationPerm => 'Manage Location Permission';

  @override
  String get manageLocationDesc =>
      'Open your device settings to change location access.';

  @override
  String get manageNotificationsPerm => 'Manage Notification Permission';

  @override
  String get manageNotificationsDesc =>
      'Open your device settings to change notification access.';

  @override
  String get localData => 'Local Data';

  @override
  String get clearLocalDataDesc =>
      'Remove locally stored Boshra data from this device.';

  @override
  String get clearDownloadsDesc =>
      'Remove downloaded Quran audio and other offline content.';

  @override
  String get privacyNote => 'Privacy Note';

  @override
  String get privacyNoteDesc =>
      'Boshra uses location only for features that require it, such as Prayer Times and Qibla direction.';

  @override
  String get boshraTagline =>
      'Your daily companion for Quran, prayer and remembrance.';

  @override
  String get boshraAboutDesc =>
      'Boshra is an Islamic companion designed to make everyday worship easier, calmer, and more accessible.';

  @override
  String get whatYouCanDo => 'What you can do with Boshra';

  @override
  String get quranDesc =>
      'Read the Quran with a clean and comfortable reading experience.';

  @override
  String get quranRecitation => 'Quran Recitation';

  @override
  String get quranRecitationDesc =>
      'Listen to Quran recitations from your preferred reciter.';

  @override
  String get azkarDesc =>
      'Keep your daily remembrance close with organized and easy-to-use Azkar.';

  @override
  String get prayerTimesDesc =>
      'Get accurate prayer times based on your location.';

  @override
  String get qiblaDesc =>
      'Find the direction of the Kaaba using your device\'s location and compass.';

  @override
  String get reminders => 'Reminders';

  @override
  String get remindersDesc =>
      'Receive timely reminders to help you stay connected throughout the day.';

  @override
  String get appInfo => 'App Information';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Build';

  @override
  String get moreOptions => 'More';

  @override
  String get rateBoshra => 'Rate Boshra';

  @override
  String get rateBoshraDesc => 'Support Boshra by leaving a review.';

  @override
  String get shareBoshra => 'Share Boshra';

  @override
  String get shareBoshraDesc => 'Share Boshra with family and friends.';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get contactUsDesc => 'Get in touch with Mahmoud Ashraf.';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get openSourceDesc =>
      'View the licenses for third-party open-source software used by Boshra.';

  @override
  String get madeWithCare =>
      'Made with care for everyone seeking a closer connection with the Quran and remembrance.';

  @override
  String get locationText => 'Location';

  @override
  String get privacyPolicyText => 'Privacy Policy';

  @override
  String get clearLocalDataText => 'Clear Local Data';

  @override
  String get prayerTimesText => 'Prayer Times';

  @override
  String get themeLight => 'Light';

  @override
  String get themeLightDesc => 'Clean warm cream interface';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeDarkDesc => 'Deep olive dark interface';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSystemDesc => 'Follow device settings';

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
