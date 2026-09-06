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
