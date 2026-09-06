// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Boshra';

  @override
  String get onboarding1Title => 'Bushra... Il tuo compagno sulla via del bene';

  @override
  String get onboarding1Desc =>
      'Rendi la tua giornata più vicina ad Allah, con semplici passi.';

  @override
  String get onboarding2Title =>
      'Tutto ciò di cui hai bisogno per la tua adorazione, in un unico posto';

  @override
  String get onboarding2Desc =>
      'Corano, orari di preghiera, Adhkar, Qibla e suppliche.';

  @override
  String get onboarding3Title =>
      'Un piccolo passo ogni giorno... fa un grande impatto';

  @override
  String get onboarding3Desc =>
      'Costruisci le tue abitudini di fede e cogli i momenti della tua giornata.';

  @override
  String get startJourney => 'Inizia il tuo viaggio';

  @override
  String get next => 'Avanti';

  @override
  String get skip => 'Salta';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Corano';

  @override
  String get navAzkar => 'Azkar';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'Altro';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'Fino a $prayerName';
  }

  @override
  String get greeting => 'Assalamu Alaikum👋';

  @override
  String get surahs => 'Sure';

  @override
  String get juzs => 'Juzs';

  @override
  String get prayerSettingsTitle => 'Impostazioni Preghiera e Adhan';

  @override
  String get prePrayerAlertTitle => 'Avviso prima della preghiera';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes minuti prima dell\'Adhan';
  }

  @override
  String get enablePrayerAlertsTitle => 'Abilita Avvisi Preghiera';

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
  String get ayahOfTheDay => 'Versetto del Giorno';

  @override
  String get listen => 'Ascolta';

  @override
  String get tafseer => 'Tafsir';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return '$surahName • Versetto $verseNumber';
  }

  @override
  String get dailyWird => 'Completa il tuo Wird quotidiano';

  @override
  String get morningAzkar => 'Azkar del mattino';

  @override
  String get eveningAzkar => 'Azkar della sera';

  @override
  String get continueReading => 'Continua';

  @override
  String get morningAzkarNotificationTitle => 'Azkar del Mattino 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'Inizia la tua giornata con il ricordo di Allah';

  @override
  String get eveningAzkarNotificationTitle => 'Azkar della Sera 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'Concludi la tua giornata con il ricordo di Allah';

  @override
  String get quickAccess => 'Accesso Rapido';

  @override
  String get qibla => 'Qibla';

  @override
  String get recitation => 'Recitazione';

  @override
  String get quran => 'Corano';

  @override
  String get quranRadio => 'Radio Corano';

  @override
  String get azkar => 'Azkar';

  @override
  String get continueReadingCardTitle => 'Continua a leggere';

  @override
  String surahName(String surahName) {
    return 'Sura $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'Versetto $number';
  }

  @override
  String get selectedRecitationTitle => 'Recitazione Selezionata';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'Il Sacro Corano';

  @override
  String get startQuranJourney => 'Inizia il tuo viaggio con il Corano';

  @override
  String get openSurahAndRead => 'Apri una Sura e inizia a leggere';

  @override
  String get browseSurahs => 'Sfoglia le Sure';

  @override
  String get searchSurah => 'Cerca una Sura...';

  @override
  String get tabSurahs => 'Sure';

  @override
  String get tabJuzs => 'Juzs';

  @override
  String get tabHizbs => 'Hizbs';

  @override
  String get meccan => 'Meccana';

  @override
  String get medinan => 'Medinese';

  @override
  String ayahsCount(Object count) {
    return '$count Versetti';
  }

  @override
  String get tafsirOption => 'Tafsir';

  @override
  String get recitationOption => 'Recitazione';

  @override
  String get downloadOption => 'Scarica';

  @override
  String get shareOption => 'Condividi';

  @override
  String get infoOption => 'Informazioni';

  @override
  String get copyOption => 'Copia';

  @override
  String get copiedSuccessfully => 'Versetto copiato negli appunti';

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
  String get quranMessageNotificationTitle => 'Messaggio dal Corano 🌿';
}
