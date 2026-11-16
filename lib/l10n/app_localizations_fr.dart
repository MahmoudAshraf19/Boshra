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
  String get live => 'En direct';

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
  String get azkarScreenSubtitle => 'Proche d’Allah… à chaque instant';

  @override
  String get azkarCategoryMorning => 'Azkar du matin';

  @override
  String get azkarCategoryMorningSub => 'Rappels pour le matin';

  @override
  String get azkarCategoryEvening => 'Azkar du soir';

  @override
  String get azkarCategoryEveningSub => 'Rappels pour le soir';

  @override
  String get azkarCategoryPrayer => 'Après la prière';

  @override
  String get azkarCategoryPrayerSub => 'Rappels après la prière';

  @override
  String get azkarCategorySleep => 'Azkar du sommeil';

  @override
  String get azkarCategorySleepSub => 'Rappels avant de dormir';

  @override
  String get azkarCategoryProtection => 'Azkar de protection';

  @override
  String get azkarCategoryProtectionSub => 'Pour la protection et la sérénité';

  @override
  String get azkarCategoryDaily => 'Azkar quotidiens';

  @override
  String get azkarCategoryDailySub => 'Divers rappels pour la journée';

  @override
  String get azkarAllCategories => 'Toutes les catégories';

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
  String get locationPermissionTitle => 'Autoriser l’accès à la position';

  @override
  String get locationPermissionDesc =>
      'Nous avons besoin de votre position pour calculer avec précision la direction de la Qibla depuis votre emplacement.';

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
  String get startupLocationTitle => 'Accès à la position';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'Nous avons besoin de votre position pour des horaires de prière et une direction de la Qibla précis.\n\nSi vous refusez, nous utiliserons votre dernière position enregistrée : $locationName.';
  }

  @override
  String get startupLocationDescDefault =>
      'Nous avons besoin de votre position pour des horaires de prière et une direction de la Qibla précis.\n\nSi vous refusez, nous utiliserons la position par défaut : La Mecque, Arabie saoudite.';

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
  String get soundType => 'Type de notification';

  @override
  String get soundSilent => 'Silencieux (sans son)';

  @override
  String get soundShort => 'Bip court';

  @override
  String get soundAdhan => 'Adhan complet';

  @override
  String get prePrayerAlertDesc => 'Me prévenir avant l’Adhan de';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'C’est l’heure de la prière de $prayerName';
  }

  @override
  String get prayerNotifBody => 'Hâtez-vous vers la prière';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return 'La prière de $prayerName approche';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'Il reste $minutes minutes avant l’Adhan';
  }

  @override
  String get notifDisabledTitle => 'Les notifications sont désactivées';

  @override
  String get notifDisabledDesc =>
      'Activez les notifications pour recevoir l’Adhan et les rappels à l’heure.';

  @override
  String get exactAlarmTitle => 'Les alarmes exactes sont désactivées';

  @override
  String get exactAlarmDesc =>
      'Autorisez « Alarmes et rappels » pour que l’Adhan arrive à l’heure exacte.';

  @override
  String get openSettings => 'Ouvrir les réglages';

  @override
  String get retry => 'Réessayer';

  @override
  String get errorGeneric => 'Une erreur s’est produite. Veuillez réessayer.';

  @override
  String get errorNoInternet =>
      'Pas de connexion internet. Vérifiez votre connexion et réessayez.';

  @override
  String get errorLoadFailed => 'Impossible de charger le contenu.';

  @override
  String get downloadingProgress => 'Téléchargement…';

  @override
  String get downloadSuccess => 'Téléchargement réussi';

  @override
  String get downloadFailed => 'Échec du téléchargement. Réessayez.';

  @override
  String get shareFailed => 'Impossible de créer l’image. Réessayez.';

  @override
  String get audioLoadFailed =>
      'Impossible de lire l’audio. Vérifiez votre connexion.';

  @override
  String get radioLoadFailed => 'Impossible de charger les stations';

  @override
  String get continueReadingBtn => 'Continuer la lecture';

  @override
  String get permSetupTitle => 'Ne manquez aucune prière';

  @override
  String get permSetupSubtitle =>
      'Autorisez quelques permissions une seule fois pour que l’Adhan et les rappels arrivent toujours à l’heure, même app fermée.';

  @override
  String get permNotifTitle => 'Notifications';

  @override
  String get permNotifDesc =>
      'Pour afficher l’Adhan, les rappels de prière, les Azkar et les messages du Coran.';

  @override
  String get permExactTitle => 'Alarmes et rappels';

  @override
  String get permExactDesc =>
      'Permet à Android de déclencher l’Adhan à la minute exacte.';

  @override
  String get permBatteryTitle => 'Batterie sans restriction';

  @override
  String get permBatteryDesc =>
      'Empêche le système de mettre l’app en veille et de perdre des notifications.';

  @override
  String get permAutostartTitle => 'Démarrage auto et arrière-plan';

  @override
  String permAutostartDesc(String brand) {
    return 'Votre téléphone ($brand) peut bloquer les apps en arrière-plan. Autorisez Boshra à démarrer seule et à tourner en arrière-plan.';
  }

  @override
  String get permChannelsTitle => 'Catégories de notification et son';

  @override
  String get permChannelsDesc =>
      'Certaines catégories de notification sont désactivées. Activez-les pour entendre l’Adhan.';

  @override
  String get permAllowAll => 'Tout autoriser';

  @override
  String get permAllow => 'Autoriser';

  @override
  String get permGranted => 'Autorisé';

  @override
  String get permContinue => 'Continuer';

  @override
  String get permLater => 'Plus tard';

  @override
  String get permAllSet =>
      'Tout est prêt ! Les notifications arriveront de façon fiable.';

  @override
  String get permMissingNote =>
      'Certaines permissions sont encore désactivées. Les notifications peuvent être en retard ou manquer.';

  @override
  String get permFix => 'Corriger';

  @override
  String get adhanStopAction => 'Arrêter l’adhan';

  @override
  String get adhanBannerTitle => 'Bannière de l’adhan';

  @override
  String get adhanBannerDesc =>
      'S’affiche en haut de l’écran et sur l’écran de verrouillage à l’heure de l’adhan, avec un bouton pour l’arrêter.';

  @override
  String get adhanBannerPreview => 'Aperçu de la bannière';

  @override
  String get adhanBannerVerse =>
      'En vérité, la prière est prescrite aux croyants à des heures déterminées.';

  @override
  String get notifSettingsTitle => 'Notifications et Adhan';

  @override
  String get modeSilent => 'Silencieux';

  @override
  String get modeShort => 'Alerte courte';

  @override
  String get modeAdhan => 'Adhan complet';

  @override
  String get modeSilentDesc => 'Notification sans son';

  @override
  String get modeShortDesc => 'Son de notification normal';

  @override
  String get modeAdhanDesc => 'Adhan complet avec bouton d’arrêt';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get remindersSection => 'Rappels quotidiens';

  @override
  String afterFajrDesc(int minutes) {
    return '$minutes min après le Fajr';
  }

  @override
  String afterAsrDesc(int minutes) {
    return '$minutes min après l’Asr (avant le coucher du soleil)';
  }

  @override
  String get ayahReminderTitle => 'Verset du jour';

  @override
  String get ayahReminderDesc =>
      'Un nouveau verset chaque jour à l’heure de votre choix';

  @override
  String get reminderTime => 'Heure';

  @override
  String get muadhinTitle => 'Muezzin';

  @override
  String get atAdhanTime => 'À l’heure de l’Adhan';

  @override
  String get advancedSection => 'Précision et calcul';

  @override
  String get calcMethodTitle => 'Méthode de calcul';

  @override
  String get calcMethodAuto => 'Automatique (selon votre position)';

  @override
  String get asrSchoolTitle => 'Calcul de l’Asr';

  @override
  String get asrStandard => 'Standard (chafi’ite, malikite, hanbalite)';

  @override
  String get asrHanafi => 'Hanafite';

  @override
  String get adjustTimesTitle => 'Réglage fin des horaires (minutes)';

  @override
  String get testAdhanButton => 'Tester l’Adhan maintenant';

  @override
  String get locationFallbackWarning =>
      'Votre position est indisponible : les horaires sont calculés pour La Mecque. Activez la localisation pour des horaires précis.';

  @override
  String get sadaqaJariyaTitle => 'Aumône continue (Sadaqa Jariya)';

  @override
  String get sadaqaHadith =>
      '« Celui qui guide vers un bien a la même récompense que celui qui l\'a accompli. »';

  @override
  String get narratedByMuslim => 'Rapporté par Mouslim';

  @override
  String get yourInviteCode => 'Votre code d\'invitation';

  @override
  String get codeCopied => 'Code copié';

  @override
  String get shareAppButton => 'Partager l\'application';

  @override
  String get shareViaWhatsApp => 'Partager via WhatsApp';

  @override
  String get startFirstShare => 'Faites votre premier partage 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'Vous avez partagé l\'application $count fois — qu\'Allah accepte';
  }

  @override
  String get haveFriendCode => 'Avez-vous le code d\'un ami ?';

  @override
  String recordedInviteFrom(Object code) {
    return 'Invitation enregistrée de $code — qu\'Allah le récompense';
  }

  @override
  String get invalidInviteCode => 'Code invalide (ex: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'C\'est votre propre code 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'J\'utilise l\'application « Boshra » pour l\'Adhan, le Coran et les Invocations — je vous la recommande 🌙\nPartagez-la comme aumône continue (Sadaqa Jariya) — « Celui qui guide vers un bien a la même récompense que celui qui l\'a accompli. »\n\n$link\nCode d\'invitation : $code';
  }

  @override
  String get diagTitle => 'L\'Adhan va-t-il sonner ?';

  @override
  String get diagAllGood =>
      'Tout est en ordre — l\'Adhan sonnera à l\'heure insha\'Allah';

  @override
  String diagCanImprove(Object count) {
    return 'L\'Adhan devrait sonner, mais $count point(s) peuvent être améliorés';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count problème(s) peuvent bloquer l\'Adhan — réparez avec les boutons ci-dessous';
  }

  @override
  String get diagFix => 'Réparer';

  @override
  String get diagTestAdhanNow => 'Tester l\'Adhan maintenant';

  @override
  String get diagReschedule => 'Re-planifier';

  @override
  String get diagRecentEvents => 'Événements récents';

  @override
  String get diagNoEvents => 'Aucun événement pour le moment';

  @override
  String get diagCopyReport => 'Copier le rapport pour le support';

  @override
  String get diagReportCopied => 'Rapport de support copié';

  @override
  String get diagNotifications => 'Notifications';

  @override
  String get diagNotifEnabled => 'Activées';

  @override
  String get diagNotifBlocked =>
      'Bloquées — l\'Adhan ne pourra pas s\'afficher';

  @override
  String get diagEnable => 'Activer';

  @override
  String get diagChannels => 'Canaux de notification';

  @override
  String get diagChannelsAllEnabled => 'Tous activés';

  @override
  String get diagChannelMuted =>
      'Un canal est mis en sourdine dans les paramètres du système';

  @override
  String get diagOpenSettings => 'Ouvrir les paramètres';

  @override
  String get diagExactAlarms => 'Alarmes précises';

  @override
  String get diagExactAlarmsAllowed =>
      'Autorisé — l\'Adhan sonne à la seconde exacte';

  @override
  String get diagExactAlarmsNotAllowed =>
      'Non autorisé — l\'Adhan risque d\'être en retard';

  @override
  String get diagAllow => 'Autoriser';

  @override
  String get diagBattery => 'Optimisation de batterie';

  @override
  String get diagBatteryExempt => 'Application exemptée';

  @override
  String get diagBatteryMayKill =>
      'Le système risque d\'arrêter l\'app en arrière-plan';

  @override
  String get diagExempt => 'Exempter';

  @override
  String get diagPrayerMode => 'Mode prière';

  @override
  String get diagPrayerModeFullSilence =>
      'Silence total prêt (accès Ne pas déranger accordé)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'Sans accès « Ne pas déranger », nous ne pouvons passer qu\'en vibreur';

  @override
  String get diagGrantPermission => 'Accorder l\'accès';

  @override
  String get diagAutostart => 'Démarrage automatique';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'Configuré ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return 'L\'appareil $brand ferme les applications — activez le démarrage automatique';
  }

  @override
  String get diagOpen => 'Ouvrir';

  @override
  String get diagLocation => 'Localisation';

  @override
  String diagLocationManual(Object city) {
    return 'Ville manuelle : $city';
  }

  @override
  String get diagLocationApprox => 'Approximatif';

  @override
  String get diagLocationUnknown =>
      'Inconnu — utilisation d\'une ville par défaut';

  @override
  String get diagLocationGpsOff =>
      'Le service de localisation (GPS) est désactivé';

  @override
  String get diagLocationDenied => 'Autorisation de localisation refusée';

  @override
  String get diagLocationPermanentlyDenied =>
      'Autorisation refusée définitivement — ouvrez les paramètres';

  @override
  String get diagLocationNoFix =>
      'Impossible de déterminer la position (signal faible)';

  @override
  String get diagLocationMock => 'Une fausse localisation est active — ignorée';

  @override
  String get diagLocationTzMismatch =>
      'La position contredit le fuseau horaire de l\'appareil';

  @override
  String get diagFixLocation => 'Corriger la position';

  @override
  String get diagSetLocation => 'Définir';

  @override
  String get diagLastScheduling => 'Dernière planification';

  @override
  String get diagNeverScheduled => 'Pas encore planifié';

  @override
  String get diagScheduleNow => 'Planifier maintenant';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count alertes';
  }

  @override
  String get diagScheduleIncomplete => 'incomplet (calcul hors ligne)';

  @override
  String get diagScheduleError => 'erreur';

  @override
  String get diagNextAdhan => 'Prochain Adhan';

  @override
  String get diagAllPrayersSilent =>
      'Toutes les prières sont sur silencieux ou notification courte';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count Adhans programmés dans le système';
  }

  @override
  String get diagNoAdhanArmed =>
      'Aucun Adhan n\'est armé dans les alarmes ! Appuyez sur planifier';

  @override
  String get diagOfflineMode => 'Mode hors ligne';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count mois en cache — fonctionne sans internet';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'Seulement $count mois en cache (se complètera en ligne)';
  }

  @override
  String get diagInternet => 'Internet';

  @override
  String get diagInternetConnected => 'Connecté au serveur des horaires';

  @override
  String get diagInternetUnavailable =>
      'Indisponible actuellement — les horaires en cache suffisent';

  @override
  String get diagTestAdhanTitle => 'Test de l\'Adhan';

  @override
  String get diagTestAdhanBody => 'Si vous entendez cela, tout fonctionne';

  @override
  String get diagStop => 'Arrêter';

  @override
  String get diagAgoJustNow => 'à l\'instant';

  @override
  String diagAgoMinutes(Object m) {
    return 'il y a $m min';
  }

  @override
  String diagAgoHours(Object h) {
    return 'il y a $h h';
  }

  @override
  String diagAgoDays(Object d) {
    return 'il y a $d j';
  }

  @override
  String get zakatCalculatorTitle => 'Calculateur de Zakat';

  @override
  String get zakatCurrency => 'Devise';

  @override
  String get zakatTodayPricesGram => 'Prix du jour (au gramme)';

  @override
  String get zakatRefresh => 'Actualiser';

  @override
  String get zakatEditManually => 'Modifier manuellement';

  @override
  String get zakatCouldNotLoadPrices =>
      'Impossible de charger les cours (hors ligne). Appuyez sur ✏️ pour saisir le prix au gramme.';

  @override
  String get zakatGold24 => 'Or 24 carats';

  @override
  String get zakatGold21 => 'Or 21 carats';

  @override
  String get zakatGold18 => 'Or 18 carats';

  @override
  String get zakatSilver => 'Argent';

  @override
  String get zakatGram => 'g';

  @override
  String get zakatUsingManualPrices => '✏️ Utilisation de vos prix manuels';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'Cours mondial × taux de change — mis à jour $date';
  }

  @override
  String get zakatPriceOld => ' (ancien)';

  @override
  String get zakatNisab => 'Nissab';

  @override
  String get zakatGoldNisab => 'Or (85 g)';

  @override
  String get zakatSilverNisab => 'Argent (595 g)';

  @override
  String get zakatNisabExplanation =>
      'Utilisez le nissab préconisé par votre autorité religieuse de confiance. Le nissab d\'argent étant plus bas, il concerne davantage de donateurs.';

  @override
  String get zakatYourWealth => 'Vos biens';

  @override
  String get zakatCashSavings => 'Espèces, épargne et comptes bancaires';

  @override
  String get zakatSharesInvestments => 'Actions, investissements et fonds';

  @override
  String get zakatTradeGoods => 'Marchandises commerciales (valeur marchande)';

  @override
  String get zakatMoneyOwedToYou => 'Argent qu\'on vous doit (recouvrable)';

  @override
  String get zakatDebtsDue => 'Dettes immédiates que vous devez (déduites)';

  @override
  String get zakatJewelleryNote =>
      'Les savants divergent sur la Zakat des bijoux portés ; si vous suivez l\'avis dispensateur, laissez les champs vides.';

  @override
  String get zakatTotalZakatableWealth =>
      'Total des biens assujettis à la Zakat';

  @override
  String get zakatEnterPriceForNisab =>
      'Saisissez le cours de l\'or ou de l\'argent pour calculer le nissab';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'Nissab : $amount $cur';
  }

  @override
  String get zakatDue25 => 'Zakat due (2,5%)';

  @override
  String get zakatHawlCondition =>
      'À condition qu\'une année lunaire complète (Hawl) se soit écoulée.';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'En dessous du nissab (il manque $amount $cur) — aucune Zakat due pour le moment.';
  }

  @override
  String get zakatCopyResult => 'Copier le résultat';

  @override
  String get zakatResultCopied => 'Résultat copié';

  @override
  String get zakatYearlyReminder => 'Rappel annuel de Zakat';

  @override
  String get zakatReminderExplanation =>
      'Choisissez la date où vos biens ont atteint le nissab. Nous vous rappellerons une semaine avant et le jour même chaque année lunaire.';

  @override
  String get zakatSetDate => 'Définir la date';

  @override
  String zakatNextDue(Object date) {
    return 'Prochaine échéance : $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'Remarque : guide indicatif. Pour les cas particuliers (actions complexes, immobilier commercial...), consultez un savant.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'Prix locaux manuels ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'Le cours chez votre bijoutier local peut différer du cours mondial. Saisissez votre prix au gramme ou laissez vide.';

  @override
  String get zakatGold24PerGram => 'Or 24 carats par gramme';

  @override
  String get zakatSilverPerGram => 'Argent par gramme';

  @override
  String get zakatPickHawlHelp => 'Date où vos biens ont atteint le nissab';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'Zakat — Boshra\nTotal des biens imposables : $total $cur\nNissab ($nisabType) : $nisabVal $cur\nZakat due (2,5%) : $due $cur';
  }

  @override
  String get trackerTitle => 'Suivi des prières';

  @override
  String get trackerTimeNotStarted =>
      'L\'heure de cette prière n\'a pas encore commencé 🌙';

  @override
  String get trackerLearningHabits => '🧠 Apprentissage de vos habitudes';

  @override
  String get trackerLearningDesc =>
      'Enregistrez vos prières pendant au moins 5 jours et nous vous suggérerons des améliorations sur mesure (analyse 100% locale).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 Le Fajr vous échappe : $missed fois sur les $days derniers jours';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'Votre rappel pour dormir tôt est actif à $time chaque soir 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'Manquer le Fajr est souvent dû au coucher tardif. Voulez-vous un rappel pour dormir tôt chaque soir ?';

  @override
  String trackerTurnOnTime(Object time) {
    return 'Activer ($time)';
  }

  @override
  String get trackerNotNow => 'Pas maintenant';

  @override
  String get trackerChangeTime => 'Changer l\'heure';

  @override
  String get trackerTurnOff => 'Désactiver';

  @override
  String get trackerPickAnotherTime => 'Choisir une autre heure';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer est souvent accomplie vers la fin de son heure';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'Le rappel doux pour $prayer arrive désormais plus tôt (au milieu plutôt qu\'à la fin).';
  }

  @override
  String get trackerGreatConsistency => '✨ Excellente régularité';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 Prière la moins régulière : $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'Aucune prière ne vous échappe régulièrement. Continuez ainsi !';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'Manquée $missed fois sur les $days derniers jours. Le rappel doux vous aide.';
  }

  @override
  String get trackerTurnOffNudge => 'Désactiver le rappel doux';

  @override
  String get trackerTurnOnNudge => 'Activer le rappel doux';

  @override
  String get trackerStopLearning => 'Arrêter l\'analyse des habitudes';

  @override
  String get trackerStartLearning => 'Analyser mes habitudes';

  @override
  String get trackerStartStreakToday => 'Commencez votre série aujourd\'hui';

  @override
  String trackerStreakDays(Object count) {
    return 'Série de $count jours, les cinq prières';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'Meilleure série : $best — cette semaine : $pct%';
  }

  @override
  String get trackerToday => 'Aujourd\'hui';

  @override
  String get trackerYesterday => 'Hier';

  @override
  String get trackerYourGarden => 'Votre jardin 🌳';

  @override
  String get trackerGardenDesc =>
      'Chaque prière a son arbre qui grandit à mesure que vous êtes assidu';

  @override
  String get trackerDayUnit => 'j';

  @override
  String get trackerTodayPrayers => 'Prières d\'aujourd\'hui';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'Prières du $date';
  }

  @override
  String get trackerPrayedMark => 'Priée ✓';

  @override
  String get trackerNotMarked => 'Non marquée';

  @override
  String get trackerThisWeek => 'Cette semaine';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'Total enregistré : $count prières';
  }

  @override
  String get gardenTitle => 'Mon jardin';

  @override
  String get gardenHomeCardTitle => 'Votre jardin de prières 🌳';

  @override
  String get gardenEnterFull => 'Entrer dans votre jardin complet 🌿';

  @override
  String get gardenTooEarlySeed => 'Trop tôt… la graine attend 🌱';

  @override
  String get gardenChooseMonth => 'Choisir le mois';

  @override
  String get gardenOf => 'Jardin de';

  @override
  String get gardenHijriSuffix => 'H';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count jours parfaits';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'Meilleure série $count';
  }

  @override
  String get gardenBlessedForest => 'Une forêt bénie';

  @override
  String gardenWeekNumber(Object num) {
    return 'Semaine $num';
  }

  @override
  String get gardenMsgFlourishing => 'Machallah ! Un jardin florissant 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'Un beau jardin — continuez pour en faire une forêt 🌿';

  @override
  String get gardenMsgWaterToday =>
      'Chaque prière arrose un arbre. Commencez dès aujourd\'hui 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'Le jardin vous attend… votre première prière plante le premier arbre 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'Priée ✓ à $time';
  }

  @override
  String get plantStatusPrayed => 'Priée ✓';

  @override
  String get plantStatusPending => 'Son heure est entrée — pas encore notée 💧';

  @override
  String get plantStatusMissed => 'Non notée — l\'arbre a besoin d\'eau';

  @override
  String get plantStatusUpcoming => 'Son heure n\'est pas encore venue 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'Un arbre fruitier ! $streak jours d\'affilée pour $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return '$streak jours consécutifs pour $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'Jour $streak de votre série sur $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'Chaque prière fait grandir l\'arbre — votre assiduité est son eau 💧';

  @override
  String get plantUndo => 'Annuler';

  @override
  String get plantWaterAction => 'Je l\'ai priée — arroser l\'arbre 💧';

  @override
  String get plantStageSeed => 'Graine';

  @override
  String get plantStageSprout => 'Pousse';

  @override
  String get plantStageSapling => 'Jeune pousse';

  @override
  String get plantStageYoungTree => 'Jeune arbre';

  @override
  String get plantStageTree => 'Arbre';

  @override
  String get plantStageFruitTree => 'Arbre fruitier';

  @override
  String get treeCherryBlossom => 'Cerisier en fleur';

  @override
  String get treeDatePalm => 'Palmier dattier';

  @override
  String get treeOrangeTree => 'Oranger';

  @override
  String get treePomegranate => 'Grenadier';

  @override
  String get treeCypress => 'Cyprès';

  @override
  String get weeklySummaryTitle => 'Bilan hebdomadaire';

  @override
  String get weeklyShareAsImage => 'Partager comme image';

  @override
  String get weeklyNoPrayersLogged =>
      'Aucune prière enregistrée cette semaine. Commencez depuis votre jardin sur l\'accueil 🌱';

  @override
  String get weeklyShareYourTree => 'Partager votre arbre de la semaine';

  @override
  String get weeklyNotificationHint =>
      'Chaque vendredi soir après l\'Isha, recevez une notification avec votre résumé hebdomadaire.';

  @override
  String get weeklyImageError => 'Impossible de créer l\'image, réessayez';

  @override
  String get weeklyCardTitle => 'Mon bilan hebdomadaire';

  @override
  String get weeklyCardTreeSubtitle => 'Mon arbre de prières cette semaine 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% de mes prières accomplies à l\'heure';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'Prière la plus assidue : $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'Moins assidue : $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 $count jours consécutifs, toutes les prières';
  }

  @override
  String get weeklyCardAppBranding => 'Boshra — Adhan, Invocations & Coran';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'Vous avez accompli $total prières sur $max';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'la plus régulière : $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'la moins régulière : $prayer';
  }

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';
}
