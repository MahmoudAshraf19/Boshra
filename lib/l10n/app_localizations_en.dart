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
  String get prePrayerAlertDesc => 'Alert me before Adhan by';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'It’s time for $prayerName prayer';
  }

  @override
  String get prayerNotifBody => 'Hasten to the prayer';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return '$prayerName prayer is near';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return '$minutes minutes left until the Adhan';
  }

  @override
  String get notifDisabledTitle => 'Notifications are turned off';

  @override
  String get notifDisabledDesc =>
      'Turn notifications on so the Adhan and reminders reach you on time.';

  @override
  String get exactAlarmTitle => 'Exact alarms are off';

  @override
  String get exactAlarmDesc =>
      'Allow “Alarms & reminders” so the Adhan arrives at the exact time.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get retry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNoInternet =>
      'No internet connection. Check your connection and try again.';

  @override
  String get errorLoadFailed => 'Couldn’t load the content.';

  @override
  String get downloadingProgress => 'Downloading…';

  @override
  String get downloadSuccess => 'Downloaded successfully';

  @override
  String get downloadFailed => 'Download failed. Please try again.';

  @override
  String get shareFailed => 'Couldn’t create the image. Please try again.';

  @override
  String get audioLoadFailed =>
      'Couldn’t play the audio. Check your connection.';

  @override
  String get radioLoadFailed => 'Couldn’t load radio stations';

  @override
  String get continueReadingBtn => 'Continue Reading';

  @override
  String get permSetupTitle => 'Never miss a prayer';

  @override
  String get permSetupSubtitle =>
      'Allow a few permissions once so the Adhan and reminders always arrive on time — even when the app is closed.';

  @override
  String get permNotifTitle => 'Notifications';

  @override
  String get permNotifDesc =>
      'To show the Adhan, prayer reminders, Azkar and Quran messages.';

  @override
  String get permExactTitle => 'Alarms & reminders';

  @override
  String get permExactDesc =>
      'Lets Android deliver the Adhan at the exact minute.';

  @override
  String get permBatteryTitle => 'Unrestricted battery';

  @override
  String get permBatteryDesc =>
      'Stops the system from putting the app to sleep and dropping notifications.';

  @override
  String get permAutostartTitle => 'Auto-start & background';

  @override
  String permAutostartDesc(String brand) {
    return 'Your phone brand ($brand) may block background apps. Allow Boshra to auto-start and run in the background.';
  }

  @override
  String get permChannelsTitle => 'Notification categories & sound';

  @override
  String get permChannelsDesc =>
      'Some notification categories are turned off. Turn them on to hear the Adhan.';

  @override
  String get permAllowAll => 'Allow all';

  @override
  String get permAllow => 'Allow';

  @override
  String get permGranted => 'Allowed';

  @override
  String get permContinue => 'Continue';

  @override
  String get permLater => 'Later';

  @override
  String get permAllSet => 'All set! Notifications will arrive reliably.';

  @override
  String get permMissingNote =>
      'Some permissions are still off. Notifications may be late or missing.';

  @override
  String get permFix => 'Fix now';

  @override
  String get adhanStopAction => 'Stop Adhan';

  @override
  String get adhanBannerTitle => 'Adhan banner';

  @override
  String get adhanBannerDesc =>
      'Appears at the top of the screen and on the lock screen at Adhan time, with a button to stop it.';

  @override
  String get adhanBannerPreview => 'Banner preview';

  @override
  String get adhanBannerVerse =>
      'Indeed, prayer has been decreed upon the believers at specified times.';

  @override
  String get notifSettingsTitle => 'Notifications & Adhan';

  @override
  String get modeSilent => 'Silent';

  @override
  String get modeShort => 'Short alert';

  @override
  String get modeAdhan => 'Full Adhan';

  @override
  String get modeSilentDesc => 'Notification without sound';

  @override
  String get modeShortDesc => 'Regular notification sound';

  @override
  String get modeAdhanDesc => 'Full Adhan with a Stop button';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get remindersSection => 'Daily reminders';

  @override
  String afterFajrDesc(int minutes) {
    return '$minutes min after Fajr';
  }

  @override
  String afterAsrDesc(int minutes) {
    return '$minutes min after Asr (before sunset)';
  }

  @override
  String get ayahReminderTitle => 'Ayah of the day';

  @override
  String get ayahReminderDesc => 'A new verse every day at the time you choose';

  @override
  String get reminderTime => 'Time';

  @override
  String get muadhinTitle => 'Muadhin';

  @override
  String get atAdhanTime => 'At Adhan time';

  @override
  String get advancedSection => 'Accuracy & calculation';

  @override
  String get calcMethodTitle => 'Calculation method';

  @override
  String get calcMethodAuto => 'Automatic (by your location)';

  @override
  String get asrSchoolTitle => 'Asr calculation';

  @override
  String get asrStandard => 'Standard (Shafi’i, Maliki, Hanbali)';

  @override
  String get asrHanafi => 'Hanafi';

  @override
  String get adjustTimesTitle => 'Fine-tune times (minutes)';

  @override
  String get testAdhanButton => 'Test the Adhan now';

  @override
  String get locationFallbackWarning =>
      'Your location is unavailable, so times are calculated for Makkah. Turn on location for accurate times.';

  @override
  String get sadaqaJariyaTitle => 'Ongoing Charity';

  @override
  String get sadaqaHadith =>
      '“Whoever guides someone to goodness will have a reward like one who did it.”';

  @override
  String get narratedByMuslim => 'Narrated by Muslim';

  @override
  String get yourInviteCode => 'Your invite code';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get shareAppButton => 'Share the app';

  @override
  String get shareViaWhatsApp => 'Share via WhatsApp';

  @override
  String get startFirstShare => 'Make your first share 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'You shared the app $count time(s) — may Allah accept it';
  }

  @override
  String get haveFriendCode => 'Have a friend\'s invite code?';

  @override
  String recordedInviteFrom(Object code) {
    return 'Recorded invite $code — may Allah reward them';
  }

  @override
  String get invalidInviteCode => 'Invalid code (e.g. BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'That is your own code 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'I use \"Boshra\" for Adhan, Quran and Azkar — I recommend it 🌙\nShare it as an ongoing charity — “Whoever guides someone to goodness will have a reward like one who did it.”\n\n$link\nInvite code: $code';
  }

  @override
  String get diagTitle => 'Will the Adhan ring?';

  @override
  String get diagAllGood =>
      'All good — the Adhan will ring on time insha\'Allah';

  @override
  String diagCanImprove(Object count) {
    return 'The Adhan should ring, but $count item(s) can be improved';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count problem(s) may stop the Adhan — fix with the buttons below';
  }

  @override
  String get diagFix => 'Fix';

  @override
  String get diagTestAdhanNow => 'Test Adhan now';

  @override
  String get diagReschedule => 'Re-schedule';

  @override
  String get diagRecentEvents => 'Recent events';

  @override
  String get diagNoEvents => 'No events yet';

  @override
  String get diagCopyReport => 'Copy report for support';

  @override
  String get diagReportCopied => 'Support report copied';

  @override
  String get diagNotifications => 'Notifications';

  @override
  String get diagNotifEnabled => 'Enabled';

  @override
  String get diagNotifBlocked => 'Blocked — the Adhan cannot show';

  @override
  String get diagEnable => 'Enable';

  @override
  String get diagChannels => 'Notification channels';

  @override
  String get diagChannelsAllEnabled => 'All enabled';

  @override
  String get diagChannelMuted => 'A channel is muted in system settings';

  @override
  String get diagOpenSettings => 'Open settings';

  @override
  String get diagExactAlarms => 'Exact alarms';

  @override
  String get diagExactAlarmsAllowed => 'Allowed — Adhan fires on the second';

  @override
  String get diagExactAlarmsNotAllowed => 'Not allowed — the Adhan may be late';

  @override
  String get diagAllow => 'Allow';

  @override
  String get diagBattery => 'Battery optimisation';

  @override
  String get diagBatteryExempt => 'App is exempt';

  @override
  String get diagBatteryMayKill => 'The system may stop the app in background';

  @override
  String get diagExempt => 'Exempt';

  @override
  String get diagPrayerMode => 'Prayer mode';

  @override
  String get diagPrayerModeFullSilence =>
      'Full silence ready (DND access granted)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'Without \"Do Not Disturb access\" we can only switch to vibrate';

  @override
  String get diagGrantPermission => 'Grant access';

  @override
  String get diagAutostart => 'Auto-start';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'Configured ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return '$brand kills background apps — enable auto-start';
  }

  @override
  String get diagOpen => 'Open';

  @override
  String get diagLocation => 'Location';

  @override
  String diagLocationManual(Object city) {
    return 'Manual city: $city';
  }

  @override
  String get diagLocationApprox => 'Approximate';

  @override
  String get diagLocationUnknown => 'Unknown — using a default city';

  @override
  String get diagLocationGpsOff => 'Location service (GPS) is off';

  @override
  String get diagLocationDenied => 'Location permission denied';

  @override
  String get diagLocationPermanentlyDenied =>
      'Permission permanently denied — open settings';

  @override
  String get diagLocationNoFix =>
      'Device could not get a fix (weak signal / Location accuracy off)';

  @override
  String get diagLocationMock =>
      'A mock location is active on the device — ignored';

  @override
  String get diagLocationTzMismatch =>
      'Fix contradicts the device time zone (mock location?)';

  @override
  String get diagFixLocation => 'Fix location';

  @override
  String get diagSetLocation => 'Set';

  @override
  String get diagLastScheduling => 'Last scheduling';

  @override
  String get diagNeverScheduled => 'Never scheduled yet';

  @override
  String get diagScheduleNow => 'Schedule now';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count alerts';
  }

  @override
  String get diagScheduleIncomplete => 'incomplete (offline calc)';

  @override
  String get diagScheduleError => 'error';

  @override
  String get diagNextAdhan => 'Next Adhan';

  @override
  String get diagAllPrayersSilent =>
      'All prayers are set to short/silent (no full Adhan)';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count Adhans armed in the system';
  }

  @override
  String get diagNoAdhanArmed =>
      'No Adhan is armed in the alarm system! Tap schedule';

  @override
  String get diagOfflineMode => 'Offline mode';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count months cached — works without internet';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'Only $count month cached (auto-completes online)';
  }

  @override
  String get diagInternet => 'Internet';

  @override
  String get diagInternetConnected => 'Reaching the prayer-times server';

  @override
  String get diagInternetUnavailable =>
      'Unavailable now — cached times are enough';

  @override
  String get diagTestAdhanTitle => 'Adhan test';

  @override
  String get diagTestAdhanBody => 'If you hear this, everything works';

  @override
  String get diagStop => 'Stop';

  @override
  String get diagAgoJustNow => 'just now';

  @override
  String diagAgoMinutes(Object m) {
    return '$m min ago';
  }

  @override
  String diagAgoHours(Object h) {
    return '$h h ago';
  }

  @override
  String diagAgoDays(Object d) {
    return '$d d ago';
  }

  @override
  String get zakatCalculatorTitle => 'Zakat Calculator';

  @override
  String get zakatCurrency => 'Currency';

  @override
  String get zakatTodayPricesGram => 'Today\'s prices (per gram)';

  @override
  String get zakatRefresh => 'Refresh';

  @override
  String get zakatEditManually => 'Edit manually';

  @override
  String get zakatCouldNotLoadPrices =>
      'Could not load prices (offline). Tap ✏️ to enter the per-gram price.';

  @override
  String get zakatGold24 => 'Gold 24k';

  @override
  String get zakatGold21 => 'Gold 21k';

  @override
  String get zakatGold18 => 'Gold 18k';

  @override
  String get zakatSilver => 'Silver';

  @override
  String get zakatGram => 'g';

  @override
  String get zakatUsingManualPrices => '✏️ Using your manual prices';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'World price × exchange rate — updated $date';
  }

  @override
  String get zakatPriceOld => ' (old)';

  @override
  String get zakatNisab => 'Nisab';

  @override
  String get zakatGoldNisab => 'Gold (85 g)';

  @override
  String get zakatSilverNisab => 'Silver (595 g)';

  @override
  String get zakatNisabExplanation =>
      'Use the nisab your trusted scholarly authority uses. The silver nisab is lower in value, so it covers more people.';

  @override
  String get zakatYourWealth => 'Your wealth';

  @override
  String get zakatCashSavings => 'Cash, savings & bank accounts';

  @override
  String get zakatSharesInvestments => 'Shares & investments';

  @override
  String get zakatTradeGoods => 'Trade goods (market value)';

  @override
  String get zakatMoneyOwedToYou => 'Money owed to you (reliable)';

  @override
  String get zakatDebtsDue => 'Debts you owe now (deducted)';

  @override
  String get zakatJewelleryNote =>
      'Scholars differ on zakat for worn jewellery; it is counted here — leave the gold fields empty if you follow the other view.';

  @override
  String get zakatTotalZakatableWealth => 'Total zakatable wealth';

  @override
  String get zakatEnterPriceForNisab =>
      'Enter the gold/silver price to compute the nisab';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'Nisab: $amount $cur';
  }

  @override
  String get zakatDue25 => 'Zakat due (2.5%)';

  @override
  String get zakatHawlCondition =>
      'Provided a full lunar year has passed over it.';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'Below the nisab ($amount $cur short) — no zakat is due now.';
  }

  @override
  String get zakatCopyResult => 'Copy result';

  @override
  String get zakatResultCopied => 'Result copied';

  @override
  String get zakatYearlyReminder => 'Yearly zakat reminder';

  @override
  String get zakatReminderExplanation =>
      'Pick the date your wealth reached the nisab. We remind you a week before the lunar year completes and on the day, every year (≈354 days).';

  @override
  String get zakatSetDate => 'Set date';

  @override
  String zakatNextDue(Object date) {
    return 'Next due: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'Note: general guidance only. For special cases (stocks, companies, debts, trade property…) ask a scholar.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'Manual local prices ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'Your local jeweller price may differ from the world price. Enter your own per-gram price, or leave empty to use the automatic one.';

  @override
  String get zakatGold24PerGram => 'Gold 24k per gram';

  @override
  String get zakatSilverPerGram => 'Silver per gram';

  @override
  String get zakatPickHawlHelp => 'Date your wealth reached the nisab';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'Zakat — Boshra\nZakatable wealth: $total $cur\nNisab ($nisabType): $nisabVal $cur\nZakat due (2.5%): $due $cur';
  }

  @override
  String get trackerTitle => 'Prayer tracker';

  @override
  String get trackerTimeNotStarted => 'Its time has not started yet 🌙';

  @override
  String get trackerLearningHabits => '🧠 Learning your habits';

  @override
  String get trackerLearningDesc =>
      'Log your prayers for at least 5 days, and we will suggest personalized improvements (analyzed only on your device).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 Fajr slips away: $missed of the last $days days';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'Your early-sleep reminder is on at $time every night 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'Missing Fajr is usually about sleeping late. Want a nightly reminder to sleep early?';

  @override
  String trackerTurnOnTime(Object time) {
    return 'Turn on ($time)';
  }

  @override
  String get trackerNotNow => 'Not now';

  @override
  String get trackerChangeTime => 'Change time';

  @override
  String get trackerTurnOff => 'Turn off';

  @override
  String get trackerPickAnotherTime => 'Pick another time';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer is usually near the end of its time';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'Your gentle reminder for $prayer now arrives earlier (mid-window instead of near the end).';
  }

  @override
  String get trackerGreatConsistency => '✨ Great consistency';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 Your weakest prayer: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'No prayer is slipping repeatedly. Keep going!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'Missed $missed times in the last $days days. The gentle reminder helps.';
  }

  @override
  String get trackerTurnOffNudge => 'Turn off gentle reminder';

  @override
  String get trackerTurnOnNudge => 'Turn on gentle reminder';

  @override
  String get trackerStopLearning => 'Stop learning my habits';

  @override
  String get trackerStartLearning => 'Learn my habits';

  @override
  String get trackerStartStreakToday => 'Start your streak today';

  @override
  String trackerStreakDays(Object count) {
    return '$count-day streak, all five prayers';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'Best streak: $best — this week: $pct%';
  }

  @override
  String get trackerToday => 'Today';

  @override
  String get trackerYesterday => 'Yesterday';

  @override
  String get trackerYourGarden => 'Your garden 🌳';

  @override
  String get trackerGardenDesc =>
      'Every prayer has a tree that grows with each day you keep it';

  @override
  String get trackerDayUnit => 'd';

  @override
  String get trackerTodayPrayers => 'Today\'s prayers';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'Prayers $date';
  }

  @override
  String get trackerPrayedMark => 'Prayed ✓';

  @override
  String get trackerNotMarked => 'Not marked';

  @override
  String get trackerThisWeek => 'This week';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'Total logged: $count prayers';
  }

  @override
  String get gardenTitle => 'My garden';

  @override
  String get gardenHomeCardTitle => 'Your prayer garden 🌳';

  @override
  String get gardenEnterFull => 'Enter your full garden 🌿';

  @override
  String get gardenTooEarlySeed => 'Too early… the seed is waiting 🌱';

  @override
  String get gardenChooseMonth => 'Choose the month';

  @override
  String get gardenOf => 'Garden of';

  @override
  String get gardenHijriSuffix => 'AH';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count perfect days';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'Best streak $count';
  }

  @override
  String get gardenBlessedForest => 'A blessed forest';

  @override
  String gardenWeekNumber(Object num) {
    return 'Week $num';
  }

  @override
  String get gardenMsgFlourishing => 'Masha Allah! A flourishing garden 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'A lovely garden — keep going and it becomes a forest 🌿';

  @override
  String get gardenMsgWaterToday =>
      'Every prayer waters a tree. Start today 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'The garden is waiting… your first prayer plants the first tree 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'Prayed ✓ at $time';
  }

  @override
  String get plantStatusPrayed => 'Prayed ✓';

  @override
  String get plantStatusPending => 'Its time has come — not logged yet 💧';

  @override
  String get plantStatusMissed => 'Not logged — the tree needs water';

  @override
  String get plantStatusUpcoming => 'Its time has not come yet 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'A fruit-bearing tree! $streak days in a row on $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return '$streak days in a row on $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'Day $streak of your streak on $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'Every prayer grows the tree — consistency is its water 💧';

  @override
  String get plantUndo => 'Undo';

  @override
  String get plantWaterAction => 'I prayed it — water the tree 💧';

  @override
  String get plantStageSeed => 'Seed';

  @override
  String get plantStageSprout => 'Sprout';

  @override
  String get plantStageSapling => 'Sapling';

  @override
  String get plantStageYoungTree => 'Young tree';

  @override
  String get plantStageTree => 'Tree';

  @override
  String get plantStageFruitTree => 'Fruit tree';

  @override
  String get treeCherryBlossom => 'Cherry blossom';

  @override
  String get treeDatePalm => 'Date palm';

  @override
  String get treeOrangeTree => 'Orange tree';

  @override
  String get treePomegranate => 'Pomegranate';

  @override
  String get treeCypress => 'Cypress';

  @override
  String get weeklySummaryTitle => 'Weekly summary';

  @override
  String get weeklyShareAsImage => 'Share as image';

  @override
  String get weeklyNoPrayersLogged =>
      'No prayers logged this week yet. Start from your garden on Home 🌱';

  @override
  String get weeklyShareYourTree => 'Share your weekly tree';

  @override
  String get weeklyNotificationHint =>
      'Every Friday evening you get a notification with your weekly summary.';

  @override
  String get weeklyImageError => 'Could not create the image, try again';

  @override
  String get weeklyCardTitle => 'My weekly summary';

  @override
  String get weeklyCardTreeSubtitle => 'My prayer tree this week 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% of my prayers logged';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'Strongest: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'Weakest: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 $count-day streak, all five prayers';
  }

  @override
  String get weeklyCardAppBranding => 'Boshra — Adhan, Azkar & Quran';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'You prayed $total of $max';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'strongest: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'weakest: $prayer';
  }

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';
}
