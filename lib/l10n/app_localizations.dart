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

  /// No description provided for @prePrayerAlertDesc.
  ///
  /// In en, this message translates to:
  /// **'Alert me before Adhan by'**
  String get prePrayerAlertDesc;

  /// No description provided for @prayerNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'It’s time for {prayerName} prayer'**
  String prayerNotifTitle(String prayerName);

  /// No description provided for @prayerNotifBody.
  ///
  /// In en, this message translates to:
  /// **'Hasten to the prayer'**
  String get prayerNotifBody;

  /// No description provided for @prePrayerNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'{prayerName} prayer is near'**
  String prePrayerNotifTitle(String prayerName);

  /// No description provided for @prePrayerNotifBody.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes left until the Adhan'**
  String prePrayerNotifBody(int minutes);

  /// No description provided for @notifDisabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off'**
  String get notifDisabledTitle;

  /// No description provided for @notifDisabledDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn notifications on so the Adhan and reminders reach you on time.'**
  String get notifDisabledDesc;

  /// No description provided for @exactAlarmTitle.
  ///
  /// In en, this message translates to:
  /// **'Exact alarms are off'**
  String get exactAlarmTitle;

  /// No description provided for @exactAlarmDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow “Alarms & reminders” so the Adhan arrives at the exact time.'**
  String get exactAlarmDesc;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your connection and try again.'**
  String get errorNoInternet;

  /// No description provided for @errorLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load the content.'**
  String get errorLoadFailed;

  /// No description provided for @downloadingProgress.
  ///
  /// In en, this message translates to:
  /// **'Downloading…'**
  String get downloadingProgress;

  /// No description provided for @downloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Downloaded successfully'**
  String get downloadSuccess;

  /// No description provided for @downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed. Please try again.'**
  String get downloadFailed;

  /// No description provided for @shareFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t create the image. Please try again.'**
  String get shareFailed;

  /// No description provided for @audioLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t play the audio. Check your connection.'**
  String get audioLoadFailed;

  /// No description provided for @radioLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load radio stations'**
  String get radioLoadFailed;

  /// No description provided for @continueReadingBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReadingBtn;

  /// No description provided for @permSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Never miss a prayer'**
  String get permSetupTitle;

  /// No description provided for @permSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow a few permissions once so the Adhan and reminders always arrive on time — even when the app is closed.'**
  String get permSetupSubtitle;

  /// No description provided for @permNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permNotifTitle;

  /// No description provided for @permNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'To show the Adhan, prayer reminders, Azkar and Quran messages.'**
  String get permNotifDesc;

  /// No description provided for @permExactTitle.
  ///
  /// In en, this message translates to:
  /// **'Alarms & reminders'**
  String get permExactTitle;

  /// No description provided for @permExactDesc.
  ///
  /// In en, this message translates to:
  /// **'Lets Android deliver the Adhan at the exact minute.'**
  String get permExactDesc;

  /// No description provided for @permBatteryTitle.
  ///
  /// In en, this message translates to:
  /// **'Unrestricted battery'**
  String get permBatteryTitle;

  /// No description provided for @permBatteryDesc.
  ///
  /// In en, this message translates to:
  /// **'Stops the system from putting the app to sleep and dropping notifications.'**
  String get permBatteryDesc;

  /// No description provided for @permAutostartTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-start & background'**
  String get permAutostartTitle;

  /// No description provided for @permAutostartDesc.
  ///
  /// In en, this message translates to:
  /// **'Your phone brand ({brand}) may block background apps. Allow Boshra to auto-start and run in the background.'**
  String permAutostartDesc(String brand);

  /// No description provided for @permChannelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification categories & sound'**
  String get permChannelsTitle;

  /// No description provided for @permChannelsDesc.
  ///
  /// In en, this message translates to:
  /// **'Some notification categories are turned off. Turn them on to hear the Adhan.'**
  String get permChannelsDesc;

  /// No description provided for @permAllowAll.
  ///
  /// In en, this message translates to:
  /// **'Allow all'**
  String get permAllowAll;

  /// No description provided for @permAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get permAllow;

  /// No description provided for @permGranted.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get permGranted;

  /// No description provided for @permContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get permContinue;

  /// No description provided for @permLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get permLater;

  /// No description provided for @permAllSet.
  ///
  /// In en, this message translates to:
  /// **'All set! Notifications will arrive reliably.'**
  String get permAllSet;

  /// No description provided for @permMissingNote.
  ///
  /// In en, this message translates to:
  /// **'Some permissions are still off. Notifications may be late or missing.'**
  String get permMissingNote;

  /// No description provided for @permFix.
  ///
  /// In en, this message translates to:
  /// **'Fix now'**
  String get permFix;

  /// No description provided for @adhanStopAction.
  ///
  /// In en, this message translates to:
  /// **'Stop Adhan'**
  String get adhanStopAction;

  /// No description provided for @adhanBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Adhan banner'**
  String get adhanBannerTitle;

  /// No description provided for @adhanBannerDesc.
  ///
  /// In en, this message translates to:
  /// **'Appears at the top of the screen and on the lock screen at Adhan time, with a button to stop it.'**
  String get adhanBannerDesc;

  /// No description provided for @adhanBannerPreview.
  ///
  /// In en, this message translates to:
  /// **'Banner preview'**
  String get adhanBannerPreview;

  /// No description provided for @adhanBannerVerse.
  ///
  /// In en, this message translates to:
  /// **'Indeed, prayer has been decreed upon the believers at specified times.'**
  String get adhanBannerVerse;

  /// No description provided for @notifSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Adhan'**
  String get notifSettingsTitle;

  /// No description provided for @modeSilent.
  ///
  /// In en, this message translates to:
  /// **'Silent'**
  String get modeSilent;

  /// No description provided for @modeShort.
  ///
  /// In en, this message translates to:
  /// **'Short alert'**
  String get modeShort;

  /// No description provided for @modeAdhan.
  ///
  /// In en, this message translates to:
  /// **'Full Adhan'**
  String get modeAdhan;

  /// No description provided for @modeSilentDesc.
  ///
  /// In en, this message translates to:
  /// **'Notification without sound'**
  String get modeSilentDesc;

  /// No description provided for @modeShortDesc.
  ///
  /// In en, this message translates to:
  /// **'Regular notification sound'**
  String get modeShortDesc;

  /// No description provided for @modeAdhanDesc.
  ///
  /// In en, this message translates to:
  /// **'Full Adhan with a Stop button'**
  String get modeAdhanDesc;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @remindersSection.
  ///
  /// In en, this message translates to:
  /// **'Daily reminders'**
  String get remindersSection;

  /// No description provided for @afterFajrDesc.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min after Fajr'**
  String afterFajrDesc(int minutes);

  /// No description provided for @afterAsrDesc.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min after Asr (before sunset)'**
  String afterAsrDesc(int minutes);

  /// No description provided for @ayahReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayah of the day'**
  String get ayahReminderTitle;

  /// No description provided for @ayahReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'A new verse every day at the time you choose'**
  String get ayahReminderDesc;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reminderTime;

  /// No description provided for @muadhinTitle.
  ///
  /// In en, this message translates to:
  /// **'Muadhin'**
  String get muadhinTitle;

  /// No description provided for @atAdhanTime.
  ///
  /// In en, this message translates to:
  /// **'At Adhan time'**
  String get atAdhanTime;

  /// No description provided for @advancedSection.
  ///
  /// In en, this message translates to:
  /// **'Accuracy & calculation'**
  String get advancedSection;

  /// No description provided for @calcMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculation method'**
  String get calcMethodTitle;

  /// No description provided for @calcMethodAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic (by your location)'**
  String get calcMethodAuto;

  /// No description provided for @asrSchoolTitle.
  ///
  /// In en, this message translates to:
  /// **'Asr calculation'**
  String get asrSchoolTitle;

  /// No description provided for @asrStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard (Shafi’i, Maliki, Hanbali)'**
  String get asrStandard;

  /// No description provided for @asrHanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get asrHanafi;

  /// No description provided for @adjustTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune times (minutes)'**
  String get adjustTimesTitle;

  /// No description provided for @testAdhanButton.
  ///
  /// In en, this message translates to:
  /// **'Test the Adhan now'**
  String get testAdhanButton;

  /// No description provided for @locationFallbackWarning.
  ///
  /// In en, this message translates to:
  /// **'Your location is unavailable, so times are calculated for Makkah. Turn on location for accurate times.'**
  String get locationFallbackWarning;

  /// No description provided for @sadaqaJariyaTitle.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Charity'**
  String get sadaqaJariyaTitle;

  /// No description provided for @sadaqaHadith.
  ///
  /// In en, this message translates to:
  /// **'“Whoever guides someone to goodness will have a reward like one who did it.”'**
  String get sadaqaHadith;

  /// No description provided for @narratedByMuslim.
  ///
  /// In en, this message translates to:
  /// **'Narrated by Muslim'**
  String get narratedByMuslim;

  /// No description provided for @yourInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Your invite code'**
  String get yourInviteCode;

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @shareAppButton.
  ///
  /// In en, this message translates to:
  /// **'Share the app'**
  String get shareAppButton;

  /// No description provided for @shareViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Share via WhatsApp'**
  String get shareViaWhatsApp;

  /// No description provided for @startFirstShare.
  ///
  /// In en, this message translates to:
  /// **'Make your first share 🌱'**
  String get startFirstShare;

  /// No description provided for @sharedTimesCount.
  ///
  /// In en, this message translates to:
  /// **'You shared the app {count} time(s) — may Allah accept it'**
  String sharedTimesCount(Object count);

  /// No description provided for @haveFriendCode.
  ///
  /// In en, this message translates to:
  /// **'Have a friend\'s invite code?'**
  String get haveFriendCode;

  /// No description provided for @recordedInviteFrom.
  ///
  /// In en, this message translates to:
  /// **'Recorded invite {code} — may Allah reward them'**
  String recordedInviteFrom(Object code);

  /// No description provided for @invalidInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code (e.g. BSH-AB3K9)'**
  String get invalidInviteCode;

  /// No description provided for @ownInviteCodeError.
  ///
  /// In en, this message translates to:
  /// **'That is your own code 🙂'**
  String get ownInviteCodeError;

  /// No description provided for @inviteShareMessage.
  ///
  /// In en, this message translates to:
  /// **'I use \"Boshra\" for Adhan, Quran and Azkar — I recommend it 🌙\nShare it as an ongoing charity — “Whoever guides someone to goodness will have a reward like one who did it.”\n\n{link}\nInvite code: {code}'**
  String inviteShareMessage(Object code, Object link);

  /// No description provided for @diagTitle.
  ///
  /// In en, this message translates to:
  /// **'Will the Adhan ring?'**
  String get diagTitle;

  /// No description provided for @diagAllGood.
  ///
  /// In en, this message translates to:
  /// **'All good — the Adhan will ring on time insha\'Allah'**
  String get diagAllGood;

  /// No description provided for @diagCanImprove.
  ///
  /// In en, this message translates to:
  /// **'The Adhan should ring, but {count} item(s) can be improved'**
  String diagCanImprove(Object count);

  /// No description provided for @diagProblemsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} problem(s) may stop the Adhan — fix with the buttons below'**
  String diagProblemsFound(Object count);

  /// No description provided for @diagFix.
  ///
  /// In en, this message translates to:
  /// **'Fix'**
  String get diagFix;

  /// No description provided for @diagTestAdhanNow.
  ///
  /// In en, this message translates to:
  /// **'Test Adhan now'**
  String get diagTestAdhanNow;

  /// No description provided for @diagReschedule.
  ///
  /// In en, this message translates to:
  /// **'Re-schedule'**
  String get diagReschedule;

  /// No description provided for @diagRecentEvents.
  ///
  /// In en, this message translates to:
  /// **'Recent events'**
  String get diagRecentEvents;

  /// No description provided for @diagNoEvents.
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get diagNoEvents;

  /// No description provided for @diagCopyReport.
  ///
  /// In en, this message translates to:
  /// **'Copy report for support'**
  String get diagCopyReport;

  /// No description provided for @diagReportCopied.
  ///
  /// In en, this message translates to:
  /// **'Support report copied'**
  String get diagReportCopied;

  /// No description provided for @diagNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get diagNotifications;

  /// No description provided for @diagNotifEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get diagNotifEnabled;

  /// No description provided for @diagNotifBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked — the Adhan cannot show'**
  String get diagNotifBlocked;

  /// No description provided for @diagEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get diagEnable;

  /// No description provided for @diagChannels.
  ///
  /// In en, this message translates to:
  /// **'Notification channels'**
  String get diagChannels;

  /// No description provided for @diagChannelsAllEnabled.
  ///
  /// In en, this message translates to:
  /// **'All enabled'**
  String get diagChannelsAllEnabled;

  /// No description provided for @diagChannelMuted.
  ///
  /// In en, this message translates to:
  /// **'A channel is muted in system settings'**
  String get diagChannelMuted;

  /// No description provided for @diagOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get diagOpenSettings;

  /// No description provided for @diagExactAlarms.
  ///
  /// In en, this message translates to:
  /// **'Exact alarms'**
  String get diagExactAlarms;

  /// No description provided for @diagExactAlarmsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed — Adhan fires on the second'**
  String get diagExactAlarmsAllowed;

  /// No description provided for @diagExactAlarmsNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Not allowed — the Adhan may be late'**
  String get diagExactAlarmsNotAllowed;

  /// No description provided for @diagAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get diagAllow;

  /// No description provided for @diagBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery optimisation'**
  String get diagBattery;

  /// No description provided for @diagBatteryExempt.
  ///
  /// In en, this message translates to:
  /// **'App is exempt'**
  String get diagBatteryExempt;

  /// No description provided for @diagBatteryMayKill.
  ///
  /// In en, this message translates to:
  /// **'The system may stop the app in background'**
  String get diagBatteryMayKill;

  /// No description provided for @diagExempt.
  ///
  /// In en, this message translates to:
  /// **'Exempt'**
  String get diagExempt;

  /// No description provided for @diagPrayerMode.
  ///
  /// In en, this message translates to:
  /// **'Prayer mode'**
  String get diagPrayerMode;

  /// No description provided for @diagPrayerModeFullSilence.
  ///
  /// In en, this message translates to:
  /// **'Full silence ready (DND access granted)'**
  String get diagPrayerModeFullSilence;

  /// No description provided for @diagPrayerModeVibrateOnly.
  ///
  /// In en, this message translates to:
  /// **'Without \"Do Not Disturb access\" we can only switch to vibrate'**
  String get diagPrayerModeVibrateOnly;

  /// No description provided for @diagGrantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant access'**
  String get diagGrantPermission;

  /// No description provided for @diagAutostart.
  ///
  /// In en, this message translates to:
  /// **'Auto-start'**
  String get diagAutostart;

  /// No description provided for @diagAutostartConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured ({brand})'**
  String diagAutostartConfigured(Object brand);

  /// No description provided for @diagAutostartNeeds.
  ///
  /// In en, this message translates to:
  /// **'{brand} kills background apps — enable auto-start'**
  String diagAutostartNeeds(Object brand);

  /// No description provided for @diagOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get diagOpen;

  /// No description provided for @diagLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get diagLocation;

  /// No description provided for @diagLocationManual.
  ///
  /// In en, this message translates to:
  /// **'Manual city: {city}'**
  String diagLocationManual(Object city);

  /// No description provided for @diagLocationApprox.
  ///
  /// In en, this message translates to:
  /// **'Approximate'**
  String get diagLocationApprox;

  /// No description provided for @diagLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown — using a default city'**
  String get diagLocationUnknown;

  /// No description provided for @diagLocationGpsOff.
  ///
  /// In en, this message translates to:
  /// **'Location service (GPS) is off'**
  String get diagLocationGpsOff;

  /// No description provided for @diagLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get diagLocationDenied;

  /// No description provided for @diagLocationPermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission permanently denied — open settings'**
  String get diagLocationPermanentlyDenied;

  /// No description provided for @diagLocationNoFix.
  ///
  /// In en, this message translates to:
  /// **'Device could not get a fix (weak signal / Location accuracy off)'**
  String get diagLocationNoFix;

  /// No description provided for @diagLocationMock.
  ///
  /// In en, this message translates to:
  /// **'A mock location is active on the device — ignored'**
  String get diagLocationMock;

  /// No description provided for @diagLocationTzMismatch.
  ///
  /// In en, this message translates to:
  /// **'Fix contradicts the device time zone (mock location?)'**
  String get diagLocationTzMismatch;

  /// No description provided for @diagFixLocation.
  ///
  /// In en, this message translates to:
  /// **'Fix location'**
  String get diagFixLocation;

  /// No description provided for @diagSetLocation.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get diagSetLocation;

  /// No description provided for @diagLastScheduling.
  ///
  /// In en, this message translates to:
  /// **'Last scheduling'**
  String get diagLastScheduling;

  /// No description provided for @diagNeverScheduled.
  ///
  /// In en, this message translates to:
  /// **'Never scheduled yet'**
  String get diagNeverScheduled;

  /// No description provided for @diagScheduleNow.
  ///
  /// In en, this message translates to:
  /// **'Schedule now'**
  String get diagScheduleNow;

  /// No description provided for @diagScheduleAlertsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} alerts'**
  String diagScheduleAlertsCount(Object count);

  /// No description provided for @diagScheduleIncomplete.
  ///
  /// In en, this message translates to:
  /// **'incomplete (offline calc)'**
  String get diagScheduleIncomplete;

  /// No description provided for @diagScheduleError.
  ///
  /// In en, this message translates to:
  /// **'error'**
  String get diagScheduleError;

  /// No description provided for @diagNextAdhan.
  ///
  /// In en, this message translates to:
  /// **'Next Adhan'**
  String get diagNextAdhan;

  /// No description provided for @diagAllPrayersSilent.
  ///
  /// In en, this message translates to:
  /// **'All prayers are set to short/silent (no full Adhan)'**
  String get diagAllPrayersSilent;

  /// No description provided for @diagArmedAdhansCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Adhans armed in the system'**
  String diagArmedAdhansCount(Object count);

  /// No description provided for @diagNoAdhanArmed.
  ///
  /// In en, this message translates to:
  /// **'No Adhan is armed in the alarm system! Tap schedule'**
  String get diagNoAdhanArmed;

  /// No description provided for @diagOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline mode'**
  String get diagOfflineMode;

  /// No description provided for @diagOfflineMonthsCached.
  ///
  /// In en, this message translates to:
  /// **'{count} months cached — works without internet'**
  String diagOfflineMonthsCached(Object count);

  /// No description provided for @diagOfflineMonthsOnly.
  ///
  /// In en, this message translates to:
  /// **'Only {count} month cached (auto-completes online)'**
  String diagOfflineMonthsOnly(Object count);

  /// No description provided for @diagInternet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get diagInternet;

  /// No description provided for @diagInternetConnected.
  ///
  /// In en, this message translates to:
  /// **'Reaching the prayer-times server'**
  String get diagInternetConnected;

  /// No description provided for @diagInternetUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable now — cached times are enough'**
  String get diagInternetUnavailable;

  /// No description provided for @diagTestAdhanTitle.
  ///
  /// In en, this message translates to:
  /// **'Adhan test'**
  String get diagTestAdhanTitle;

  /// No description provided for @diagTestAdhanBody.
  ///
  /// In en, this message translates to:
  /// **'If you hear this, everything works'**
  String get diagTestAdhanBody;

  /// No description provided for @diagStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get diagStop;

  /// No description provided for @diagAgoJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get diagAgoJustNow;

  /// No description provided for @diagAgoMinutes.
  ///
  /// In en, this message translates to:
  /// **'{m} min ago'**
  String diagAgoMinutes(Object m);

  /// No description provided for @diagAgoHours.
  ///
  /// In en, this message translates to:
  /// **'{h} h ago'**
  String diagAgoHours(Object h);

  /// No description provided for @diagAgoDays.
  ///
  /// In en, this message translates to:
  /// **'{d} d ago'**
  String diagAgoDays(Object d);

  /// No description provided for @zakatCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Zakat Calculator'**
  String get zakatCalculatorTitle;

  /// No description provided for @zakatCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get zakatCurrency;

  /// No description provided for @zakatTodayPricesGram.
  ///
  /// In en, this message translates to:
  /// **'Today\'s prices (per gram)'**
  String get zakatTodayPricesGram;

  /// No description provided for @zakatRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get zakatRefresh;

  /// No description provided for @zakatEditManually.
  ///
  /// In en, this message translates to:
  /// **'Edit manually'**
  String get zakatEditManually;

  /// No description provided for @zakatCouldNotLoadPrices.
  ///
  /// In en, this message translates to:
  /// **'Could not load prices (offline). Tap ✏️ to enter the per-gram price.'**
  String get zakatCouldNotLoadPrices;

  /// No description provided for @zakatGold24.
  ///
  /// In en, this message translates to:
  /// **'Gold 24k'**
  String get zakatGold24;

  /// No description provided for @zakatGold21.
  ///
  /// In en, this message translates to:
  /// **'Gold 21k'**
  String get zakatGold21;

  /// No description provided for @zakatGold18.
  ///
  /// In en, this message translates to:
  /// **'Gold 18k'**
  String get zakatGold18;

  /// No description provided for @zakatSilver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get zakatSilver;

  /// No description provided for @zakatGram.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get zakatGram;

  /// No description provided for @zakatUsingManualPrices.
  ///
  /// In en, this message translates to:
  /// **'✏️ Using your manual prices'**
  String get zakatUsingManualPrices;

  /// No description provided for @zakatWorldPriceStamp.
  ///
  /// In en, this message translates to:
  /// **'World price × exchange rate — updated {date}'**
  String zakatWorldPriceStamp(Object date);

  /// No description provided for @zakatPriceOld.
  ///
  /// In en, this message translates to:
  /// **' (old)'**
  String get zakatPriceOld;

  /// No description provided for @zakatNisab.
  ///
  /// In en, this message translates to:
  /// **'Nisab'**
  String get zakatNisab;

  /// No description provided for @zakatGoldNisab.
  ///
  /// In en, this message translates to:
  /// **'Gold (85 g)'**
  String get zakatGoldNisab;

  /// No description provided for @zakatSilverNisab.
  ///
  /// In en, this message translates to:
  /// **'Silver (595 g)'**
  String get zakatSilverNisab;

  /// No description provided for @zakatNisabExplanation.
  ///
  /// In en, this message translates to:
  /// **'Use the nisab your trusted scholarly authority uses. The silver nisab is lower in value, so it covers more people.'**
  String get zakatNisabExplanation;

  /// No description provided for @zakatYourWealth.
  ///
  /// In en, this message translates to:
  /// **'Your wealth'**
  String get zakatYourWealth;

  /// No description provided for @zakatCashSavings.
  ///
  /// In en, this message translates to:
  /// **'Cash, savings & bank accounts'**
  String get zakatCashSavings;

  /// No description provided for @zakatSharesInvestments.
  ///
  /// In en, this message translates to:
  /// **'Shares & investments'**
  String get zakatSharesInvestments;

  /// No description provided for @zakatTradeGoods.
  ///
  /// In en, this message translates to:
  /// **'Trade goods (market value)'**
  String get zakatTradeGoods;

  /// No description provided for @zakatMoneyOwedToYou.
  ///
  /// In en, this message translates to:
  /// **'Money owed to you (reliable)'**
  String get zakatMoneyOwedToYou;

  /// No description provided for @zakatDebtsDue.
  ///
  /// In en, this message translates to:
  /// **'Debts you owe now (deducted)'**
  String get zakatDebtsDue;

  /// No description provided for @zakatJewelleryNote.
  ///
  /// In en, this message translates to:
  /// **'Scholars differ on zakat for worn jewellery; it is counted here — leave the gold fields empty if you follow the other view.'**
  String get zakatJewelleryNote;

  /// No description provided for @zakatTotalZakatableWealth.
  ///
  /// In en, this message translates to:
  /// **'Total zakatable wealth'**
  String get zakatTotalZakatableWealth;

  /// No description provided for @zakatEnterPriceForNisab.
  ///
  /// In en, this message translates to:
  /// **'Enter the gold/silver price to compute the nisab'**
  String get zakatEnterPriceForNisab;

  /// No description provided for @zakatNisabValue.
  ///
  /// In en, this message translates to:
  /// **'Nisab: {amount} {cur}'**
  String zakatNisabValue(Object amount, Object cur);

  /// No description provided for @zakatDue25.
  ///
  /// In en, this message translates to:
  /// **'Zakat due (2.5%)'**
  String get zakatDue25;

  /// No description provided for @zakatHawlCondition.
  ///
  /// In en, this message translates to:
  /// **'Provided a full lunar year has passed over it.'**
  String get zakatHawlCondition;

  /// No description provided for @zakatNotEligibleShort.
  ///
  /// In en, this message translates to:
  /// **'Below the nisab ({amount} {cur} short) — no zakat is due now.'**
  String zakatNotEligibleShort(Object amount, Object cur);

  /// No description provided for @zakatCopyResult.
  ///
  /// In en, this message translates to:
  /// **'Copy result'**
  String get zakatCopyResult;

  /// No description provided for @zakatResultCopied.
  ///
  /// In en, this message translates to:
  /// **'Result copied'**
  String get zakatResultCopied;

  /// No description provided for @zakatYearlyReminder.
  ///
  /// In en, this message translates to:
  /// **'Yearly zakat reminder'**
  String get zakatYearlyReminder;

  /// No description provided for @zakatReminderExplanation.
  ///
  /// In en, this message translates to:
  /// **'Pick the date your wealth reached the nisab. We remind you a week before the lunar year completes and on the day, every year (≈354 days).'**
  String get zakatReminderExplanation;

  /// No description provided for @zakatSetDate.
  ///
  /// In en, this message translates to:
  /// **'Set date'**
  String get zakatSetDate;

  /// No description provided for @zakatNextDue.
  ///
  /// In en, this message translates to:
  /// **'Next due: {date}'**
  String zakatNextDue(Object date);

  /// No description provided for @zakatScholarsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Note: general guidance only. For special cases (stocks, companies, debts, trade property…) ask a scholar.'**
  String get zakatScholarsDisclaimer;

  /// No description provided for @zakatManualPricesTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual local prices ({cur})'**
  String zakatManualPricesTitle(Object cur);

  /// No description provided for @zakatManualPricesDesc.
  ///
  /// In en, this message translates to:
  /// **'Your local jeweller price may differ from the world price. Enter your own per-gram price, or leave empty to use the automatic one.'**
  String get zakatManualPricesDesc;

  /// No description provided for @zakatGold24PerGram.
  ///
  /// In en, this message translates to:
  /// **'Gold 24k per gram'**
  String get zakatGold24PerGram;

  /// No description provided for @zakatSilverPerGram.
  ///
  /// In en, this message translates to:
  /// **'Silver per gram'**
  String get zakatSilverPerGram;

  /// No description provided for @zakatPickHawlHelp.
  ///
  /// In en, this message translates to:
  /// **'Date your wealth reached the nisab'**
  String get zakatPickHawlHelp;

  /// No description provided for @zakatSummaryShare.
  ///
  /// In en, this message translates to:
  /// **'Zakat — Boshra\nZakatable wealth: {total} {cur}\nNisab ({nisabType}): {nisabVal} {cur}\nZakat due (2.5%): {due} {cur}'**
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  );

  /// No description provided for @trackerTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer tracker'**
  String get trackerTitle;

  /// No description provided for @trackerTimeNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Its time has not started yet 🌙'**
  String get trackerTimeNotStarted;

  /// No description provided for @trackerLearningHabits.
  ///
  /// In en, this message translates to:
  /// **'🧠 Learning your habits'**
  String get trackerLearningHabits;

  /// No description provided for @trackerLearningDesc.
  ///
  /// In en, this message translates to:
  /// **'Log your prayers for at least 5 days, and we will suggest personalized improvements (analyzed only on your device).'**
  String get trackerLearningDesc;

  /// No description provided for @trackerFajrSlips.
  ///
  /// In en, this message translates to:
  /// **'🌅 Fajr slips away: {missed} of the last {days} days'**
  String trackerFajrSlips(Object days, Object missed);

  /// No description provided for @trackerSleepReminderActive.
  ///
  /// In en, this message translates to:
  /// **'Your early-sleep reminder is on at {time} every night 🌿'**
  String trackerSleepReminderActive(Object time);

  /// No description provided for @trackerSleepReminderSuggest.
  ///
  /// In en, this message translates to:
  /// **'Missing Fajr is usually about sleeping late. Want a nightly reminder to sleep early?'**
  String get trackerSleepReminderSuggest;

  /// No description provided for @trackerTurnOnTime.
  ///
  /// In en, this message translates to:
  /// **'Turn on ({time})'**
  String trackerTurnOnTime(Object time);

  /// No description provided for @trackerNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get trackerNotNow;

  /// No description provided for @trackerChangeTime.
  ///
  /// In en, this message translates to:
  /// **'Change time'**
  String get trackerChangeTime;

  /// No description provided for @trackerTurnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get trackerTurnOff;

  /// No description provided for @trackerPickAnotherTime.
  ///
  /// In en, this message translates to:
  /// **'Pick another time'**
  String get trackerPickAnotherTime;

  /// No description provided for @trackerPrayerNearEnd.
  ///
  /// In en, this message translates to:
  /// **'⏰ {prayer} is usually near the end of its time'**
  String trackerPrayerNearEnd(Object prayer);

  /// No description provided for @trackerPrayerNearEndDesc.
  ///
  /// In en, this message translates to:
  /// **'Your gentle reminder for {prayer} now arrives earlier (mid-window instead of near the end).'**
  String trackerPrayerNearEndDesc(Object prayer);

  /// No description provided for @trackerGreatConsistency.
  ///
  /// In en, this message translates to:
  /// **'✨ Great consistency'**
  String get trackerGreatConsistency;

  /// No description provided for @trackerWeakestPrayer.
  ///
  /// In en, this message translates to:
  /// **'🌿 Your weakest prayer: {prayer}'**
  String trackerWeakestPrayer(Object prayer);

  /// No description provided for @trackerNoPrayerSlipping.
  ///
  /// In en, this message translates to:
  /// **'No prayer is slipping repeatedly. Keep going!'**
  String get trackerNoPrayerSlipping;

  /// No description provided for @trackerPrayerMissedCount.
  ///
  /// In en, this message translates to:
  /// **'Missed {missed} times in the last {days} days. The gentle reminder helps.'**
  String trackerPrayerMissedCount(Object days, Object missed);

  /// No description provided for @trackerTurnOffNudge.
  ///
  /// In en, this message translates to:
  /// **'Turn off gentle reminder'**
  String get trackerTurnOffNudge;

  /// No description provided for @trackerTurnOnNudge.
  ///
  /// In en, this message translates to:
  /// **'Turn on gentle reminder'**
  String get trackerTurnOnNudge;

  /// No description provided for @trackerStopLearning.
  ///
  /// In en, this message translates to:
  /// **'Stop learning my habits'**
  String get trackerStopLearning;

  /// No description provided for @trackerStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Learn my habits'**
  String get trackerStartLearning;

  /// No description provided for @trackerStartStreakToday.
  ///
  /// In en, this message translates to:
  /// **'Start your streak today'**
  String get trackerStartStreakToday;

  /// No description provided for @trackerStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak, all five prayers'**
  String trackerStreakDays(Object count);

  /// No description provided for @trackerBestStreakStats.
  ///
  /// In en, this message translates to:
  /// **'Best streak: {best} — this week: {pct}%'**
  String trackerBestStreakStats(Object best, Object pct);

  /// No description provided for @trackerToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get trackerToday;

  /// No description provided for @trackerYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get trackerYesterday;

  /// No description provided for @trackerYourGarden.
  ///
  /// In en, this message translates to:
  /// **'Your garden 🌳'**
  String get trackerYourGarden;

  /// No description provided for @trackerGardenDesc.
  ///
  /// In en, this message translates to:
  /// **'Every prayer has a tree that grows with each day you keep it'**
  String get trackerGardenDesc;

  /// No description provided for @trackerDayUnit.
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get trackerDayUnit;

  /// No description provided for @trackerTodayPrayers.
  ///
  /// In en, this message translates to:
  /// **'Today\'s prayers'**
  String get trackerTodayPrayers;

  /// No description provided for @trackerPrayersOnDate.
  ///
  /// In en, this message translates to:
  /// **'Prayers {date}'**
  String trackerPrayersOnDate(Object date);

  /// No description provided for @trackerPrayedMark.
  ///
  /// In en, this message translates to:
  /// **'Prayed ✓'**
  String get trackerPrayedMark;

  /// No description provided for @trackerNotMarked.
  ///
  /// In en, this message translates to:
  /// **'Not marked'**
  String get trackerNotMarked;

  /// No description provided for @trackerThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get trackerThisWeek;

  /// No description provided for @trackerTotalPrayedCount.
  ///
  /// In en, this message translates to:
  /// **'Total logged: {count} prayers'**
  String trackerTotalPrayedCount(Object count);

  /// No description provided for @gardenTitle.
  ///
  /// In en, this message translates to:
  /// **'My garden'**
  String get gardenTitle;

  /// No description provided for @gardenHomeCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Your prayer garden 🌳'**
  String get gardenHomeCardTitle;

  /// No description provided for @gardenEnterFull.
  ///
  /// In en, this message translates to:
  /// **'Enter your full garden 🌿'**
  String get gardenEnterFull;

  /// No description provided for @gardenTooEarlySeed.
  ///
  /// In en, this message translates to:
  /// **'Too early… the seed is waiting 🌱'**
  String get gardenTooEarlySeed;

  /// No description provided for @gardenChooseMonth.
  ///
  /// In en, this message translates to:
  /// **'Choose the month'**
  String get gardenChooseMonth;

  /// No description provided for @gardenOf.
  ///
  /// In en, this message translates to:
  /// **'Garden of'**
  String get gardenOf;

  /// No description provided for @gardenHijriSuffix.
  ///
  /// In en, this message translates to:
  /// **'AH'**
  String get gardenHijriSuffix;

  /// No description provided for @gardenPerfectDaysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} perfect days'**
  String gardenPerfectDaysCount(Object count);

  /// No description provided for @gardenBestStreakCount.
  ///
  /// In en, this message translates to:
  /// **'Best streak {count}'**
  String gardenBestStreakCount(Object count);

  /// No description provided for @gardenBlessedForest.
  ///
  /// In en, this message translates to:
  /// **'A blessed forest'**
  String get gardenBlessedForest;

  /// No description provided for @gardenWeekNumber.
  ///
  /// In en, this message translates to:
  /// **'Week {num}'**
  String gardenWeekNumber(Object num);

  /// No description provided for @gardenMsgFlourishing.
  ///
  /// In en, this message translates to:
  /// **'Masha Allah! A flourishing garden 🌳🌳🌳'**
  String get gardenMsgFlourishing;

  /// No description provided for @gardenMsgKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'A lovely garden — keep going and it becomes a forest 🌿'**
  String get gardenMsgKeepGoing;

  /// No description provided for @gardenMsgWaterToday.
  ///
  /// In en, this message translates to:
  /// **'Every prayer waters a tree. Start today 💧'**
  String get gardenMsgWaterToday;

  /// No description provided for @gardenMsgWaitingFirst.
  ///
  /// In en, this message translates to:
  /// **'The garden is waiting… your first prayer plants the first tree 🌱'**
  String get gardenMsgWaitingFirst;

  /// No description provided for @plantStatusPrayedAt.
  ///
  /// In en, this message translates to:
  /// **'Prayed ✓ at {time}'**
  String plantStatusPrayedAt(Object time);

  /// No description provided for @plantStatusPrayed.
  ///
  /// In en, this message translates to:
  /// **'Prayed ✓'**
  String get plantStatusPrayed;

  /// No description provided for @plantStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Its time has come — not logged yet 💧'**
  String get plantStatusPending;

  /// No description provided for @plantStatusMissed.
  ///
  /// In en, this message translates to:
  /// **'Not logged — the tree needs water'**
  String get plantStatusMissed;

  /// No description provided for @plantStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Its time has not come yet 🌱'**
  String get plantStatusUpcoming;

  /// No description provided for @plantStreakFruit.
  ///
  /// In en, this message translates to:
  /// **'A fruit-bearing tree! {streak} days in a row on {prayer} 🍎'**
  String plantStreakFruit(Object prayer, Object streak);

  /// No description provided for @plantStreakWeekPlus.
  ///
  /// In en, this message translates to:
  /// **'{streak} days in a row on {prayer} 🔥'**
  String plantStreakWeekPlus(Object prayer, Object streak);

  /// No description provided for @plantStreakDayNum.
  ///
  /// In en, this message translates to:
  /// **'Day {streak} of your streak on {prayer}'**
  String plantStreakDayNum(Object prayer, Object streak);

  /// No description provided for @plantWaterConsistency.
  ///
  /// In en, this message translates to:
  /// **'Every prayer grows the tree — consistency is its water 💧'**
  String get plantWaterConsistency;

  /// No description provided for @plantUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get plantUndo;

  /// No description provided for @plantWaterAction.
  ///
  /// In en, this message translates to:
  /// **'I prayed it — water the tree 💧'**
  String get plantWaterAction;

  /// No description provided for @plantStageSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get plantStageSeed;

  /// No description provided for @plantStageSprout.
  ///
  /// In en, this message translates to:
  /// **'Sprout'**
  String get plantStageSprout;

  /// No description provided for @plantStageSapling.
  ///
  /// In en, this message translates to:
  /// **'Sapling'**
  String get plantStageSapling;

  /// No description provided for @plantStageYoungTree.
  ///
  /// In en, this message translates to:
  /// **'Young tree'**
  String get plantStageYoungTree;

  /// No description provided for @plantStageTree.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get plantStageTree;

  /// No description provided for @plantStageFruitTree.
  ///
  /// In en, this message translates to:
  /// **'Fruit tree'**
  String get plantStageFruitTree;

  /// No description provided for @treeCherryBlossom.
  ///
  /// In en, this message translates to:
  /// **'Cherry blossom'**
  String get treeCherryBlossom;

  /// No description provided for @treeDatePalm.
  ///
  /// In en, this message translates to:
  /// **'Date palm'**
  String get treeDatePalm;

  /// No description provided for @treeOrangeTree.
  ///
  /// In en, this message translates to:
  /// **'Orange tree'**
  String get treeOrangeTree;

  /// No description provided for @treePomegranate.
  ///
  /// In en, this message translates to:
  /// **'Pomegranate'**
  String get treePomegranate;

  /// No description provided for @treeCypress.
  ///
  /// In en, this message translates to:
  /// **'Cypress'**
  String get treeCypress;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get weeklySummaryTitle;

  /// No description provided for @weeklyShareAsImage.
  ///
  /// In en, this message translates to:
  /// **'Share as image'**
  String get weeklyShareAsImage;

  /// No description provided for @weeklyNoPrayersLogged.
  ///
  /// In en, this message translates to:
  /// **'No prayers logged this week yet. Start from your garden on Home 🌱'**
  String get weeklyNoPrayersLogged;

  /// No description provided for @weeklyShareYourTree.
  ///
  /// In en, this message translates to:
  /// **'Share your weekly tree'**
  String get weeklyShareYourTree;

  /// No description provided for @weeklyNotificationHint.
  ///
  /// In en, this message translates to:
  /// **'Every Friday evening you get a notification with your weekly summary.'**
  String get weeklyNotificationHint;

  /// No description provided for @weeklyImageError.
  ///
  /// In en, this message translates to:
  /// **'Could not create the image, try again'**
  String get weeklyImageError;

  /// No description provided for @weeklyCardTitle.
  ///
  /// In en, this message translates to:
  /// **'My weekly summary'**
  String get weeklyCardTitle;

  /// No description provided for @weeklyCardTreeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My prayer tree this week 🌳'**
  String get weeklyCardTreeSubtitle;

  /// No description provided for @weeklyCardPercentLogged.
  ///
  /// In en, this message translates to:
  /// **'{pct}% of my prayers logged'**
  String weeklyCardPercentLogged(Object pct);

  /// No description provided for @weeklyCardStrongest.
  ///
  /// In en, this message translates to:
  /// **'Strongest: {prayer}'**
  String weeklyCardStrongest(Object prayer);

  /// No description provided for @weeklyCardWeakest.
  ///
  /// In en, this message translates to:
  /// **'Weakest: {prayer}'**
  String weeklyCardWeakest(Object prayer);

  /// No description provided for @weeklyCardStreak.
  ///
  /// In en, this message translates to:
  /// **'🔥 {count}-day streak, all five prayers'**
  String weeklyCardStreak(Object count);

  /// No description provided for @weeklyCardAppBranding.
  ///
  /// In en, this message translates to:
  /// **'Boshra — Adhan, Azkar & Quran'**
  String get weeklyCardAppBranding;

  /// No description provided for @weeklySentencePrayed.
  ///
  /// In en, this message translates to:
  /// **'You prayed {total} of {max}'**
  String weeklySentencePrayed(Object max, Object total);

  /// No description provided for @weeklySentenceStrongest.
  ///
  /// In en, this message translates to:
  /// **'strongest: {prayer}'**
  String weeklySentenceStrongest(Object prayer);

  /// No description provided for @weeklySentenceWeakest.
  ///
  /// In en, this message translates to:
  /// **'weakest: {prayer}'**
  String weeklySentenceWeakest(Object prayer);

  /// No description provided for @amLabel.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get amLabel;

  /// No description provided for @pmLabel.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pmLabel;
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
