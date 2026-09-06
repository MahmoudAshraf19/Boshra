// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Boshra';

  @override
  String get onboarding1Title =>
      'Bushra... Votre compagnon sur le chemin du bien';

  @override
  String get onboarding1Desc =>
      'Rapprochez-vous d\'Allah chaque jour, avec des étapes simples.';

  @override
  String get onboarding2Title =>
      'Tout ce dont vous avez besoin, en un seul endroit';

  @override
  String get onboarding2Desc =>
      'Coran, heures de prière, Adhkar, Qibla et invocations.';

  @override
  String get onboarding3Title => 'Un petit pas chaque jour... un grand impact';

  @override
  String get onboarding3Desc =>
      'Construisez vos habitudes de foi et saisissez les moments de votre journée.';

  @override
  String get startJourney => 'Commencez votre voyage';

  @override
  String get next => 'Suivant';

  @override
  String get skip => 'Passer';

  @override
  String get navHome => 'Accueil';

  @override
  String get navQuran => 'Coran';

  @override
  String get navAzkar => 'Azkar';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'Plus';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'Jusqu\'à $prayerName';
  }

  @override
  String get greeting => 'Assalamu Alaikum👋';

  @override
  String get surahs => 'Sourates';

  @override
  String get juzs => 'Juzs';

  @override
  String get prayerSettingsTitle => 'Paramètres de Prière et Adhan';

  @override
  String get prePrayerAlertTitle => 'Alerte avant la prière';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes minutes avant l\'Adhan';
  }

  @override
  String get enablePrayerAlertsTitle => 'Activer les alertes de prière';

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
  String get ayahOfTheDay => 'Verset du Jour';

  @override
  String get listen => 'Écouter';

  @override
  String get tafseer => 'Tafsir';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return '$surahName • Verset $verseNumber';
  }

  @override
  String get dailyWird => 'Complétez votre Wird quotidien';

  @override
  String get morningAzkar => 'Azkar du matin';

  @override
  String get eveningAzkar => 'Azkar du soir';

  @override
  String get continueReading => 'Continuer';

  @override
  String get morningAzkarNotificationTitle => 'Azkar du Matin 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'Commencez votre journée par le rappel d\'Allah';

  @override
  String get eveningAzkarNotificationTitle => 'Azkar du Soir 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'Terminez votre journée par le rappel d\'Allah';

  @override
  String get quickAccess => 'Accès Rapide';

  @override
  String get qibla => 'Qibla';

  @override
  String get recitation => 'Récitation';

  @override
  String get quran => 'Coran';

  @override
  String get quranRadio => 'Radio Coran';

  @override
  String get azkar => 'Azkar';

  @override
  String get continueReadingCardTitle => 'Continuer la lecture';

  @override
  String surahName(String surahName) {
    return 'Sourate $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'Verset $number';
  }

  @override
  String get selectedRecitationTitle => 'Récitation Sélectionnée';

  @override
  String get live => 'Live';

  @override
  String get quranScreenTitle => 'Le Saint Coran';

  @override
  String get startQuranJourney => 'Commencez votre voyage avec le Coran';

  @override
  String get openSurahAndRead => 'Ouvrez une sourate et commencez à lire';

  @override
  String get browseSurahs => 'Parcourir les Sourates';

  @override
  String get searchSurah => 'Rechercher une Sourate...';

  @override
  String get tabSurahs => 'Sourates';

  @override
  String get tabJuzs => 'Juzs';

  @override
  String get tabHizbs => 'Hizbs';

  @override
  String get meccan => 'Mecquoise';

  @override
  String get medinan => 'Médinoise';

  @override
  String ayahsCount(Object count) {
    return '$count Versets';
  }

  @override
  String get tafsirOption => 'Tafsir';

  @override
  String get recitationOption => 'Récitation';

  @override
  String get downloadOption => 'Télécharger';

  @override
  String get shareOption => 'Partager';

  @override
  String get infoOption => 'Information';

  @override
  String get copyOption => 'Copier';

  @override
  String get copiedSuccessfully => 'Verset copié dans le presse-papiers';

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
  String get quranMessageNotificationTitle => 'Message du Coran 🌿';

  @override
  String get saveBookmark => 'Enregistrer le signet';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'Signet enregistré à la Sourate $surahName Ayah $ayahNumber';
  }
}
