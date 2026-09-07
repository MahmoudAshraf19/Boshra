import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ur'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Boshra'**
  String get appTitle;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Bushra... Your companion on the path of goodness'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In en, this message translates to:
  /// **'Make your day closer to Allah, with simple steps and acts of worship always present with you.'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Everything you need for your worship, in one place'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In en, this message translates to:
  /// **'Quran, prayer times, Adhkar, Qibla, and supplications... in a simple experience.'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'A small step every day... makes a big impact'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In en, this message translates to:
  /// **'Build your faith habits, and seize the moments of your day.'**
  String get onboarding3Desc;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start your journey'**
  String get startJourney;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get navQuran;

  /// No description provided for @navAzkar.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get navAzkar;

  /// No description provided for @navQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get navQibla;

  /// No description provided for @navRadio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get navRadio;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @nextPrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'{prayerName}'**
  String nextPrayerTitle(String prayerName);

  /// No description provided for @untilNextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Until {prayerName}'**
  String untilNextPrayer(String prayerName);

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Assalamu Alaikum👋'**
  String get greeting;

  /// No description provided for @surahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahs;

  /// No description provided for @juzs.
  ///
  /// In en, this message translates to:
  /// **'Juzs'**
  String get juzs;

  /// No description provided for @prayerSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer and Adhan Settings'**
  String get prayerSettingsTitle;

  /// No description provided for @prePrayerAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Pre-Prayer Alert (Before Adhan)'**
  String get prePrayerAlertTitle;

  /// No description provided for @minutesBeforeAdhan.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes before Adhan'**
  String minutesBeforeAdhan(int minutes);

  /// No description provided for @enablePrayerAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Prayer Alerts'**
  String get enablePrayerAlertsTitle;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @ayahOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Ayah of the Day'**
  String get ayahOfTheDay;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @tafseer.
  ///
  /// In en, this message translates to:
  /// **'Tafseer'**
  String get tafseer;

  /// No description provided for @surahAndVerse.
  ///
  /// In en, this message translates to:
  /// **'{surahName} • Verse {verseNumber}'**
  String surahAndVerse(String surahName, String verseNumber);

  /// No description provided for @dailyWird.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Daily Wird'**
  String get dailyWird;

  /// No description provided for @morningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar'**
  String get morningAzkar;

  /// No description provided for @eveningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar'**
  String get eveningAzkar;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueReading;

  /// No description provided for @morningAzkarNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar 🌅'**
  String get morningAzkarNotificationTitle;

  /// No description provided for @morningAzkarNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Start your day with the remembrance of Allah'**
  String get morningAzkarNotificationBody;

  /// No description provided for @eveningAzkarNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar 🌙'**
  String get eveningAzkarNotificationTitle;

  /// No description provided for @eveningAzkarNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'End your day with the remembrance of Allah'**
  String get eveningAzkarNotificationBody;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @recitation.
  ///
  /// In en, this message translates to:
  /// **'Recitation'**
  String get recitation;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @quranRadio.
  ///
  /// In en, this message translates to:
  /// **'Quran Radio'**
  String get quranRadio;

  /// No description provided for @azkar.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkar;

  /// No description provided for @continueReadingCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReadingCardTitle;

  /// No description provided for @surahName.
  ///
  /// In en, this message translates to:
  /// **'Surah {surahName}'**
  String surahName(String surahName);

  /// No description provided for @ayahNumber.
  ///
  /// In en, this message translates to:
  /// **'Ayah {number}'**
  String ayahNumber(String number);

  /// No description provided for @selectedRecitationTitle.
  ///
  /// In en, this message translates to:
  /// **'Selected Recitation'**
  String get selectedRecitationTitle;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @quranScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get quranScreenTitle;

  /// No description provided for @startQuranJourney.
  ///
  /// In en, this message translates to:
  /// **'Start your journey with the Quran'**
  String get startQuranJourney;

  /// No description provided for @openSurahAndRead.
  ///
  /// In en, this message translates to:
  /// **'Open a Surah and start reading'**
  String get openSurahAndRead;

  /// No description provided for @browseSurahs.
  ///
  /// In en, this message translates to:
  /// **'Browse Surahs'**
  String get browseSurahs;

  /// No description provided for @searchSurah.
  ///
  /// In en, this message translates to:
  /// **'Search for a Surah...'**
  String get searchSurah;

  /// No description provided for @tabSurahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get tabSurahs;

  /// No description provided for @tabJuzs.
  ///
  /// In en, this message translates to:
  /// **'Juzs'**
  String get tabJuzs;

  /// No description provided for @tabHizbs.
  ///
  /// In en, this message translates to:
  /// **'Hizbs'**
  String get tabHizbs;

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @ayahsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Verses'**
  String ayahsCount(Object count);

  /// No description provided for @tafsirOption.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirOption;

  /// No description provided for @recitationOption.
  ///
  /// In en, this message translates to:
  /// **'Recitation'**
  String get recitationOption;

  /// No description provided for @downloadOption.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get downloadOption;

  /// No description provided for @shareOption.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareOption;

  /// No description provided for @infoOption.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get infoOption;

  /// No description provided for @copyOption.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyOption;

  /// No description provided for @copiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Ayah copied to clipboard'**
  String get copiedSuccessfully;

  /// No description provided for @azkarScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkarScreenTitle;

  /// No description provided for @azkarScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Close to Allah... in every moment'**
  String get azkarScreenSubtitle;

  /// No description provided for @azkarCategoryMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar'**
  String get azkarCategoryMorning;

  /// No description provided for @azkarCategoryMorningSub.
  ///
  /// In en, this message translates to:
  /// **'Remembrances for the morning'**
  String get azkarCategoryMorningSub;

  /// No description provided for @azkarCategoryEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar'**
  String get azkarCategoryEvening;

  /// No description provided for @azkarCategoryEveningSub.
  ///
  /// In en, this message translates to:
  /// **'Remembrances for the evening'**
  String get azkarCategoryEveningSub;

  /// No description provided for @azkarCategoryPrayer.
  ///
  /// In en, this message translates to:
  /// **'After Prayer'**
  String get azkarCategoryPrayer;

  /// No description provided for @azkarCategoryPrayerSub.
  ///
  /// In en, this message translates to:
  /// **'Remembrances after prayer'**
  String get azkarCategoryPrayerSub;

  /// No description provided for @azkarCategorySleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep Azkar'**
  String get azkarCategorySleep;

  /// No description provided for @azkarCategorySleepSub.
  ///
  /// In en, this message translates to:
  /// **'Remembrances before sleep'**
  String get azkarCategorySleepSub;

  /// No description provided for @azkarCategoryProtection.
  ///
  /// In en, this message translates to:
  /// **'Protection Azkar'**
  String get azkarCategoryProtection;

  /// No description provided for @azkarCategoryProtectionSub.
  ///
  /// In en, this message translates to:
  /// **'For protection and tranquility'**
  String get azkarCategoryProtectionSub;

  /// No description provided for @azkarCategoryDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily Azkar'**
  String get azkarCategoryDaily;

  /// No description provided for @azkarCategoryDailySub.
  ///
  /// In en, this message translates to:
  /// **'Various remembrances for the day'**
  String get azkarCategoryDailySub;

  /// No description provided for @azkarAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get azkarAllCategories;

  /// No description provided for @quranMessageNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Message from the Quran 🌿'**
  String get quranMessageNotificationTitle;

  /// No description provided for @saveBookmark.
  ///
  /// In en, this message translates to:
  /// **'Save Bookmark'**
  String get saveBookmark;

  /// No description provided for @bookmarkSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Bookmark saved at Surah {surahName} Ayah {ayahNumber}'**
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber);

  /// No description provided for @qiblaDirection.
  ///
  /// In en, this message translates to:
  /// **'Qibla Direction'**
  String get qiblaDirection;

  /// No description provided for @qiblaAccurate.
  ///
  /// In en, this message translates to:
  /// **'Qibla is Accurate'**
  String get qiblaAccurate;

  /// No description provided for @youAreFacingQibla.
  ///
  /// In en, this message translates to:
  /// **'You are now facing the Qibla'**
  String get youAreFacingQibla;

  /// No description provided for @qiblaCalibration.
  ///
  /// In en, this message translates to:
  /// **'Qibla Calibration'**
  String get qiblaCalibration;

  /// No description provided for @qiblaCalibrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please move your phone slowly in a figure-8 motion until the compass is calibrated.'**
  String get qiblaCalibrationDesc;

  /// No description provided for @findingLocation.
  ///
  /// In en, this message translates to:
  /// **'Finding location...'**
  String get findingLocation;

  /// No description provided for @locationPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Unable to access location. Please enable GPS.'**
  String get locationPermissionError;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Location Access'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'We need your location to accurately calculate the Qibla direction based on your current position.'**
  String get locationPermissionDesc;

  /// No description provided for @preciseQibla.
  ///
  /// In en, this message translates to:
  /// **'Precise Qibla'**
  String get preciseQibla;

  /// No description provided for @exactLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Exact Location'**
  String get exactLocation;

  /// No description provided for @alwaysUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Always Up to Date'**
  String get alwaysUpToDate;

  /// No description provided for @allowLocationBtn.
  ///
  /// In en, this message translates to:
  /// **'Allow Location Access'**
  String get allowLocationBtn;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @startupLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Access'**
  String get startupLocationTitle;

  /// No description provided for @startupLocationDescSaved.
  ///
  /// In en, this message translates to:
  /// **'We need your location for accurate Prayer Times and Qibla direction.\n\nIf you choose not to allow, we will use your last saved location: {locationName}.'**
  String startupLocationDescSaved(String locationName);

  /// No description provided for @startupLocationDescDefault.
  ///
  /// In en, this message translates to:
  /// **'We need your location for accurate Prayer Times and Qibla direction.\n\nIf you choose not to allow, we will use the default location: Mecca, Saudi Arabia.'**
  String get startupLocationDescDefault;

  /// No description provided for @moreScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreScreenTitle;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalSettings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @alertsSettings.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsSettings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @adhanAndReminders.
  ///
  /// In en, this message translates to:
  /// **'Adhan & prayer reminders'**
  String get adhanAndReminders;

  /// No description provided for @dataAndStorage.
  ///
  /// In en, this message translates to:
  /// **'Data & Storage'**
  String get dataAndStorage;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @storageDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage downloaded Surahs'**
  String get storageDesc;

  /// No description provided for @infoAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Info & Support'**
  String get infoAndSupport;

  /// No description provided for @privacyAndPermissions.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Permissions'**
  String get privacyAndPermissions;

  /// No description provided for @aboutBoshra.
  ///
  /// In en, this message translates to:
  /// **'About Boshra'**
  String get aboutBoshra;

  /// No description provided for @downloadedOption.
  ///
  /// In en, this message translates to:
  /// **'Downloaded'**
  String get downloadedOption;

  /// No description provided for @totalUsed.
  ///
  /// In en, this message translates to:
  /// **'Total Used'**
  String get totalUsed;

  /// No description provided for @systemApp.
  ///
  /// In en, this message translates to:
  /// **'System (App Size)'**
  String get systemApp;

  /// No description provided for @downloadedSurahs.
  ///
  /// In en, this message translates to:
  /// **'Downloaded Surahs'**
  String get downloadedSurahs;

  /// No description provided for @cache.
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get cache;

  /// No description provided for @manageDownloads.
  ///
  /// In en, this message translates to:
  /// **'Manage Downloads'**
  String get manageDownloads;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @clearAllDownloads.
  ///
  /// In en, this message translates to:
  /// **'Clear All Downloads'**
  String get clearAllDownloads;

  /// No description provided for @clearWarning.
  ///
  /// In en, this message translates to:
  /// **'This will remove all downloaded content and cannot be undone.'**
  String get clearWarning;

  /// No description provided for @notEnoughSpace.
  ///
  /// In en, this message translates to:
  /// **'Not enough storage space (Limit 3GB reached).'**
  String get notEnoughSpace;

  /// No description provided for @clearCacheWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This will delete some temporary data like your saved location.'**
  String get clearCacheWarning;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearDataWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This will delete all your data, settings, and downloads. The app will return to its initial state.'**
  String get clearDataWarning;

  /// No description provided for @yesClear.
  ///
  /// In en, this message translates to:
  /// **'Yes, Clear'**
  String get yesClear;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yourPrivacyMatters.
  ///
  /// In en, this message translates to:
  /// **'Your privacy matters to us.'**
  String get yourPrivacyMatters;

  /// No description provided for @privacyRequestsDesc.
  ///
  /// In en, this message translates to:
  /// **'Boshra requests only the permissions needed to provide its features.'**
  String get privacyRequestsDesc;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @locationPermDesc.
  ///
  /// In en, this message translates to:
  /// **'Used to calculate accurate prayer times and determine the Qibla direction based on your location.'**
  String get locationPermDesc;

  /// No description provided for @statusAllowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get statusAllowed;

  /// No description provided for @statusDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get statusDenied;

  /// No description provided for @notificationsPermDesc.
  ///
  /// In en, this message translates to:
  /// **'Used to send prayer times, Adhan alerts, and Azkar reminders.'**
  String get notificationsPermDesc;

  /// No description provided for @yourData.
  ///
  /// In en, this message translates to:
  /// **'Your Data'**
  String get yourData;

  /// No description provided for @yourDataDesc1.
  ///
  /// In en, this message translates to:
  /// **'Boshra does not require an account or sign-in.'**
  String get yourDataDesc1;

  /// No description provided for @yourDataDesc2.
  ///
  /// In en, this message translates to:
  /// **'Your preferences, downloaded content, and local app settings may be stored on your device to provide the app\'s features.'**
  String get yourDataDesc2;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn how Boshra collects, uses, stores, and protects information.'**
  String get privacyPolicyDesc;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @termsDesc.
  ///
  /// In en, this message translates to:
  /// **'Read the terms governing your use of Boshra.'**
  String get termsDesc;

  /// No description provided for @dataAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get dataAndPrivacy;

  /// No description provided for @dataPrivacyDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn about the information processed by Boshra and your privacy choices.'**
  String get dataPrivacyDesc;

  /// No description provided for @permissionManagement.
  ///
  /// In en, this message translates to:
  /// **'Permission Management'**
  String get permissionManagement;

  /// No description provided for @manageLocationPerm.
  ///
  /// In en, this message translates to:
  /// **'Manage Location Permission'**
  String get manageLocationPerm;

  /// No description provided for @manageLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'Open your device settings to change location access.'**
  String get manageLocationDesc;

  /// No description provided for @manageNotificationsPerm.
  ///
  /// In en, this message translates to:
  /// **'Manage Notification Permission'**
  String get manageNotificationsPerm;

  /// No description provided for @manageNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Open your device settings to change notification access.'**
  String get manageNotificationsDesc;

  /// No description provided for @localData.
  ///
  /// In en, this message translates to:
  /// **'Local Data'**
  String get localData;

  /// No description provided for @clearLocalDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove locally stored Boshra data from this device.'**
  String get clearLocalDataDesc;

  /// No description provided for @clearDownloadsDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove downloaded Quran audio and other offline content.'**
  String get clearDownloadsDesc;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'Privacy Note'**
  String get privacyNote;

  /// No description provided for @privacyNoteDesc.
  ///
  /// In en, this message translates to:
  /// **'Boshra uses location only for features that require it, such as Prayer Times and Qibla direction.'**
  String get privacyNoteDesc;

  /// No description provided for @boshraTagline.
  ///
  /// In en, this message translates to:
  /// **'Your daily companion for Quran, prayer and remembrance.'**
  String get boshraTagline;

  /// No description provided for @boshraAboutDesc.
  ///
  /// In en, this message translates to:
  /// **'Boshra is an Islamic companion designed to make everyday worship easier, calmer, and more accessible.'**
  String get boshraAboutDesc;

  /// No description provided for @whatYouCanDo.
  ///
  /// In en, this message translates to:
  /// **'What you can do with Boshra'**
  String get whatYouCanDo;

  /// No description provided for @quranDesc.
  ///
  /// In en, this message translates to:
  /// **'Read the Quran with a clean and comfortable reading experience.'**
  String get quranDesc;

  /// No description provided for @quranRecitation.
  ///
  /// In en, this message translates to:
  /// **'Quran Recitation'**
  String get quranRecitation;

  /// No description provided for @quranRecitationDesc.
  ///
  /// In en, this message translates to:
  /// **'Listen to Quran recitations from your preferred reciter.'**
  String get quranRecitationDesc;

  /// No description provided for @azkarDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep your daily remembrance close with organized and easy-to-use Azkar.'**
  String get azkarDesc;

  /// No description provided for @prayerTimesDesc.
  ///
  /// In en, this message translates to:
  /// **'Get accurate prayer times based on your location.'**
  String get prayerTimesDesc;

  /// No description provided for @qiblaDesc.
  ///
  /// In en, this message translates to:
  /// **'Find the direction of the Kaaba using your device\'s location and compass.'**
  String get qiblaDesc;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @remindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive timely reminders to help you stay connected throughout the day.'**
  String get remindersDesc;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInfo;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @buildNumber.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get buildNumber;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreOptions;

  /// No description provided for @rateBoshra.
  ///
  /// In en, this message translates to:
  /// **'Rate Boshra'**
  String get rateBoshra;

  /// No description provided for @rateBoshraDesc.
  ///
  /// In en, this message translates to:
  /// **'Support Boshra by leaving a review.'**
  String get rateBoshraDesc;

  /// No description provided for @shareBoshra.
  ///
  /// In en, this message translates to:
  /// **'Share Boshra'**
  String get shareBoshra;

  /// No description provided for @shareBoshraDesc.
  ///
  /// In en, this message translates to:
  /// **'Share Boshra with family and friends.'**
  String get shareBoshraDesc;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactUsDesc.
  ///
  /// In en, this message translates to:
  /// **'Get in touch with Mahmoud Ashraf.'**
  String get contactUsDesc;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// No description provided for @openSourceDesc.
  ///
  /// In en, this message translates to:
  /// **'View the licenses for third-party open-source software used by Boshra.'**
  String get openSourceDesc;

  /// No description provided for @madeWithCare.
  ///
  /// In en, this message translates to:
  /// **'Made with care for everyone seeking a closer connection with the Quran and remembrance.'**
  String get madeWithCare;

  /// No description provided for @locationText.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationText;

  /// No description provided for @privacyPolicyText.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyText;

  /// No description provided for @clearLocalDataText.
  ///
  /// In en, this message translates to:
  /// **'Clear Local Data'**
  String get clearLocalDataText;

  /// No description provided for @prayerTimesText.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesText;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeLightDesc.
  ///
  /// In en, this message translates to:
  /// **'Clean warm cream interface'**
  String get themeLightDesc;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeDarkDesc.
  ///
  /// In en, this message translates to:
  /// **'Deep olive dark interface'**
  String get themeDarkDesc;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeSystemDesc.
  ///
  /// In en, this message translates to:
  /// **'Follow device settings'**
  String get themeSystemDesc;

  /// No description provided for @soundType.
  ///
  /// In en, this message translates to:
  /// **'Notification Type'**
  String get soundType;

  /// No description provided for @soundSilent.
  ///
  /// In en, this message translates to:
  /// **'Silent (No sound)'**
  String get soundSilent;

  /// No description provided for @soundShort.
  ///
  /// In en, this message translates to:
  /// **'Short Beep'**
  String get soundShort;

  /// No description provided for @soundAdhan.
  ///
  /// In en, this message translates to:
  /// **'Full Adhan'**
  String get soundAdhan;

  /// No description provided for @testNotificationNow.
  ///
  /// In en, this message translates to:
  /// **'Test Notification Now'**
  String get testNotificationNow;

  /// No description provided for @prePrayerAlertDesc.
  ///
  /// In en, this message translates to:
  /// **'Alert me before Adhan by'**
  String get prePrayerAlertDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'it',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
