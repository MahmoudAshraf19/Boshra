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

  @override
  String get qiblaDirection => 'Direction de la Qibla';

  @override
  String get qiblaAccurate => 'Qibla exacte';

  @override
  String get youAreFacingQibla => 'Vous faites maintenant face à la Qibla';

  @override
  String get qiblaCalibration => 'Étalonnage de la Qibla';

  @override
  String get qiblaCalibrationDesc =>
      'Veuillez déplacer lentement votre téléphone en formant un 8 pour étalonner la boussole.';

  @override
  String get findingLocation => 'Recherche d\'emplacement...';

  @override
  String get locationPermissionError =>
      'Impossible d\'accéder à l\'emplacement. Veuillez activer le GPS.';

  @override
  String get locationPermissionTitle => 'Allow Location Access';

  @override
  String get locationPermissionDesc =>
      'We need your location to accurately calculate the Qibla direction based on your current position.';

  @override
  String get preciseQibla => 'Qibla précise';

  @override
  String get exactLocation => 'Votre emplacement exact';

  @override
  String get alwaysUpToDate => 'Toujours à jour';

  @override
  String get allowLocationBtn => 'Autoriser l\'accès';

  @override
  String get notNow => 'Pas maintenant';

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
  String get moreScreenTitle => 'Plus';

  @override
  String get generalSettings => 'Général';

  @override
  String get appearance => 'Apparence';

  @override
  String get systemDefault => 'Par défaut';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get alertsSettings => 'Alertes';

  @override
  String get notifications => 'Notifications';

  @override
  String get adhanAndReminders => 'Adhan et rappels';

  @override
  String get dataAndStorage => 'Données et Stockage';

  @override
  String get storage => 'Stockage';

  @override
  String get storageDesc => 'Gérer les sourates téléchargées';

  @override
  String get infoAndSupport => 'Info et Support';

  @override
  String get privacyAndPermissions => 'Confidentialité et Permissions';

  @override
  String get aboutBoshra => 'À propos de Boshra';

  @override
  String get downloadedOption => 'Téléchargé';

  @override
  String get totalUsed => 'Total Utilisé';

  @override
  String get systemApp => 'Système (App)';

  @override
  String get downloadedSurahs => 'Sourates téléchargées';

  @override
  String get cache => 'Cache';

  @override
  String get manageDownloads => 'Gérer les téléchargements';

  @override
  String get clearCache => 'Vider le cache';

  @override
  String get clearAllDownloads => 'Effacer tous les téléchargements';

  @override
  String get clearWarning => 'Cela supprimera tout le contenu téléchargé.';

  @override
  String get notEnoughSpace => 'Espace insuffisant (limite de 3 Go atteinte).';

  @override
  String get clearCacheWarning =>
      'Êtes-vous sûr ? Cela supprimera les données temporaires.';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get clearDataWarning =>
      'Êtes-vous sûr ? L\'application reviendra à son état initial.';

  @override
  String get yesClear => 'Oui, effacer';

  @override
  String get cancel => 'Annuler';

  @override
  String get yourPrivacyMatters =>
      'Votre confidentialité est importante pour nous.';

  @override
  String get privacyRequestsDesc =>
      'Boshra demande uniquement les autorisations nécessaires à ses fonctionnalités.';

  @override
  String get permissions => 'Autorisations';

  @override
  String get locationPermDesc =>
      'Utilisée pour calculer avec précision les horaires de prière et déterminer la direction de la Qibla selon votre position.';

  @override
  String get statusAllowed => 'Autorisé';

  @override
  String get statusDenied => 'Refusé';

  @override
  String get notificationsPermDesc =>
      'Utilisées pour envoyer les horaires de prière, les alertes de l’Adhan et les rappels d’Azkar.';

  @override
  String get yourData => 'Vos données';

  @override
  String get yourDataDesc1 => 'Boshra ne nécessite ni compte ni connexion.';

  @override
  String get yourDataDesc2 =>
      'Vos préférences, contenus téléchargés et paramètres locaux peuvent être stockés sur votre appareil afin de fournir les fonctionnalités de l’application.';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacyPolicyDesc =>
      'Découvrez comment Boshra collecte, utilise, stocke et protège les informations.';

  @override
  String get termsAndConditions => 'Conditions générales';

  @override
  String get termsDesc =>
      'Consultez les conditions régissant votre utilisation de Boshra.';

  @override
  String get dataAndPrivacy => 'Données et confidentialité';

  @override
  String get dataPrivacyDesc =>
      'Découvrez les données traitées par Boshra et vos options de confidentialité.';

  @override
  String get permissionManagement => 'Gestion des autorisations';

  @override
  String get manageLocationPerm => 'Gérer l’autorisation de localisation';

  @override
  String get manageLocationDesc =>
      'Ouvrez les réglages de votre appareil pour modifier l’accès à la localisation.';

  @override
  String get manageNotificationsPerm =>
      'Gérer l’autorisation des notifications';

  @override
  String get manageNotificationsDesc =>
      'Ouvrez les réglages de votre appareil pour modifier l’accès aux notifications.';

  @override
  String get localData => 'Données locales';

  @override
  String get clearLocalDataDesc =>
      'Supprimez les données Boshra stockées localement sur cet appareil.';

  @override
  String get clearDownloadsDesc =>
      'Supprimez les récitations du Corán et autres contenus téléchargés pour une utilisation hors ligne.';

  @override
  String get privacyNote => 'Note de confidentialité';

  @override
  String get privacyNoteDesc =>
      'Boshra utilise la localisation uniquement pour les fonctionnalités qui en ont besoin, telles que les horaires de prière et la direction de la Qibla.';

  @override
  String get boshraTagline =>
      'Votre compagnon quotidien pour le Coran, la prière et le rappel d’Allah.';

  @override
  String get boshraAboutDesc =>
      'Boshra est une application islamique conçue pour rendre votre pratique quotidienne plus simple, sereine et accessible.';

  @override
  String get whatYouCanDo => 'Ce que vous pouvez faire avec Boshra';

  @override
  String get quranDesc =>
      'Lisez le Coran avec une expérience claire et agréable.';

  @override
  String get quranRecitation => 'Récitation du Coran';

  @override
  String get quranRecitationDesc =>
      'Écoutez les récitations de votre récitant préféré.';

  @override
  String get azkarDesc =>
      'Gardez vos rappels quotidiens organisés et faciles à utiliser.';

  @override
  String get prayerTimesDesc =>
      'Consultez des horaires de prière précis selon votre localisation.';

  @override
  String get qiblaDesc =>
      'Trouvez la direction de la Kaaba grâce à la localisation et à la boussole de votre appareil.';

  @override
  String get reminders => 'Rappels';

  @override
  String get remindersDesc =>
      'Recevez des rappels au bon moment pour rester connecté à vos pratiques quotidiennes.';

  @override
  String get appInfo => 'Informations sur l’application';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Build';

  @override
  String get moreOptions => 'Plus';

  @override
  String get rateBoshra => 'Évaluer Boshra';

  @override
  String get rateBoshraDesc => 'Soutenez Boshra en laissant un avis.';

  @override
  String get shareBoshra => 'Partager Boshra';

  @override
  String get shareBoshraDesc =>
      'Partagez Boshra avec votre famille et vos amis.';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get contactUsDesc => 'Contactez Mahmoud Ashraf.';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String get openSourceDesc =>
      'Consultez les licences des logiciels open source utilisés par Boshra.';

  @override
  String get madeWithCare =>
      'Créé avec soin pour celles et ceux qui souhaitent se rapprocher du Coran et du rappel d’Allah.';

  @override
  String get locationText => 'Emplacement';

  @override
  String get privacyPolicyText => 'Politique de confidentialité';

  @override
  String get clearLocalDataText => 'Effacer les données locales';

  @override
  String get prayerTimesText => 'Horaires de prière';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeLightDesc => 'Interface claire et chaleureuse';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeDarkDesc => 'Interface sombre et profonde';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeSystemDesc => 'Suivre les paramètres de l\'appareil';

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
