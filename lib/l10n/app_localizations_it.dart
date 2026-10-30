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
  String get live => 'In diretta';

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
  String get azkarScreenSubtitle => 'Vicino ad Allah… in ogni momento';

  @override
  String get azkarCategoryMorning => 'Azkar del mattino';

  @override
  String get azkarCategoryMorningSub => 'Invocazioni per il mattino';

  @override
  String get azkarCategoryEvening => 'Azkar della sera';

  @override
  String get azkarCategoryEveningSub => 'Invocazioni per la sera';

  @override
  String get azkarCategoryPrayer => 'Dopo la preghiera';

  @override
  String get azkarCategoryPrayerSub => 'Invocazioni dopo la preghiera';

  @override
  String get azkarCategorySleep => 'Azkar del sonno';

  @override
  String get azkarCategorySleepSub => 'Invocazioni prima di dormire';

  @override
  String get azkarCategoryProtection => 'Azkar di protezione';

  @override
  String get azkarCategoryProtectionSub => 'Per protezione e serenità';

  @override
  String get azkarCategoryDaily => 'Azkar quotidiani';

  @override
  String get azkarCategoryDailySub => 'Varie invocazioni per la giornata';

  @override
  String get azkarAllCategories => 'Tutte le categorie';

  @override
  String get quranMessageNotificationTitle => 'Messaggio dal Corano 🌿';

  @override
  String get saveBookmark => 'Salva Segnalibro';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'Segnalibro salvato a Sura $surahName Ayah $ayahNumber';
  }

  @override
  String get qiblaDirection => 'Direzione della Qibla';

  @override
  String get qiblaAccurate => 'Qibla esatta';

  @override
  String get youAreFacingQibla => 'Ora sei di fronte alla Qibla';

  @override
  String get qiblaCalibration => 'Calibrazione della Qibla';

  @override
  String get qiblaCalibrationDesc =>
      'Muovi lentamente il telefono a forma di 8 per calibrare la bussola.';

  @override
  String get findingLocation => 'Ricerca posizione...';

  @override
  String get locationPermissionError =>
      'Impossibile accedere alla posizione. Abilita il GPS.';

  @override
  String get locationPermissionTitle => 'Consenti l’accesso alla posizione';

  @override
  String get locationPermissionDesc =>
      'Abbiamo bisogno della tua posizione per calcolare con precisione la direzione della Qibla.';

  @override
  String get preciseQibla => 'Qibla precisa';

  @override
  String get exactLocation => 'La tua posizione esatta';

  @override
  String get alwaysUpToDate => 'Sempre aggiornato';

  @override
  String get allowLocationBtn => 'Consenti accesso';

  @override
  String get notNow => 'Non ora';

  @override
  String get startupLocationTitle => 'Accesso alla posizione';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'Abbiamo bisogno della tua posizione per orari di preghiera e direzione della Qibla precisi.\n\nSe non consenti, useremo l’ultima posizione salvata: $locationName.';
  }

  @override
  String get startupLocationDescDefault =>
      'Abbiamo bisogno della tua posizione per orari di preghiera e direzione della Qibla precisi.\n\nSe non consenti, useremo la posizione predefinita: La Mecca, Arabia Saudita.';

  @override
  String get moreScreenTitle => 'Altro';

  @override
  String get generalSettings => 'Generale';

  @override
  String get appearance => 'Aspetto';

  @override
  String get systemDefault => 'Predefinito';

  @override
  String get appLanguage => 'Lingua dell\'App';

  @override
  String get alertsSettings => 'Avvisi';

  @override
  String get notifications => 'Notifiche';

  @override
  String get adhanAndReminders => 'Adhan e promemoria';

  @override
  String get dataAndStorage => 'Dati e Archiviazione';

  @override
  String get storage => 'Archiviazione';

  @override
  String get storageDesc => 'Gestisci Sure scaricate';

  @override
  String get infoAndSupport => 'Info e Supporto';

  @override
  String get privacyAndPermissions => 'Privacy e Autorizzazioni';

  @override
  String get aboutBoshra => 'Informazioni su Boshra';

  @override
  String get downloadedOption => 'Scaricato';

  @override
  String get totalUsed => 'Totale Usato';

  @override
  String get systemApp => 'Sistema (App)';

  @override
  String get downloadedSurahs => 'Sure scaricate';

  @override
  String get cache => 'Cache';

  @override
  String get manageDownloads => 'Gestisci Download';

  @override
  String get clearCache => 'Svuota Cache';

  @override
  String get clearAllDownloads => 'Cancella tutti i download';

  @override
  String get clearWarning => 'Questo rimuoverà tutti i contenuti scaricati.';

  @override
  String get notEnoughSpace => 'Spazio insufficiente (limite 3GB raggiunto).';

  @override
  String get clearCacheWarning =>
      'Sei sicuro? Questo eliminerà i dati temporanei.';

  @override
  String get clearAllData => 'Cancella tutti i dati';

  @override
  String get clearDataWarning =>
      'Sei sicuro? L\'app tornerà allo stato iniziale.';

  @override
  String get yesClear => 'Sì, Cancella';

  @override
  String get cancel => 'Annulla';

  @override
  String get yourPrivacyMatters => 'La tua privacy è importante per noi.';

  @override
  String get privacyRequestsDesc =>
      'Boshra richiede solo le autorizzazioni necessarie per offrire le sue funzioni.';

  @override
  String get permissions => 'Autorizzazioni';

  @override
  String get locationPermDesc =>
      'Utilizzata per calcolare con precisione gli orari di preghiera e determinare la direzione della Qibla in base alla tua posizione.';

  @override
  String get statusAllowed => 'Consentito';

  @override
  String get statusDenied => 'Negato';

  @override
  String get notificationsPermDesc =>
      'Utilizzate per inviare gli orari di preghiera, gli avvisi dell\'Adhan e i promemoria degli Azkar.';

  @override
  String get yourData => 'I tuoi dati';

  @override
  String get yourDataDesc1 => 'Boshra non richiede un account né l\'accesso.';

  @override
  String get yourDataDesc2 =>
      'Le tue preferenze, i contenuti scaricati e le impostazioni locali possono essere memorizzati sul dispositivo per fornire le funzionalità dell\'app.';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyPolicyDesc =>
      'Scopri come Boshra raccoglie, utilizza, conserva e protegge le informazioni.';

  @override
  String get termsAndConditions => 'Termini e condizioni';

  @override
  String get termsDesc =>
      'Consulta i termini che regolano l\'utilizzo di Boshra.';

  @override
  String get dataAndPrivacy => 'Dati e privacy';

  @override
  String get dataPrivacyDesc =>
      'Scopri quali dati vengono elaborati da Boshra e quali sono le tue opzioni sulla privacy.';

  @override
  String get permissionManagement => 'Gestione autorizzazioni';

  @override
  String get manageLocationPerm => 'Gestisci autorizzazione posizione';

  @override
  String get manageLocationDesc =>
      'Apri le impostazioni del dispositivo per modificare l\'accesso alla posizione.';

  @override
  String get manageNotificationsPerm => 'Gestisci autorizzazione notifiche';

  @override
  String get manageNotificationsDesc =>
      'Apri le impostazioni del dispositivo per modificare l\'accesso alle notifiche.';

  @override
  String get localData => 'Dati locali';

  @override
  String get clearLocalDataDesc =>
      'Rimuovi i dati Boshra archiviati localmente sul dispositivo.';

  @override
  String get clearDownloadsDesc =>
      'Rimuovi le recitazioni del Corano e altri contenuti scaricati per l\'utilizzo offline.';

  @override
  String get privacyNote => 'Nota sulla privacy';

  @override
  String get privacyNoteDesc =>
      'Boshra utilizza la posizione esclusivamente per le funzioni che ne hanno bisogno, come gli orari di preghiera e la direzione della Qibla.';

  @override
  String get boshraTagline =>
      'Il tuo compagno quotidiano per il Corano, la preghiera e il ricordo di Allah.';

  @override
  String get boshraAboutDesc =>
      'Boshra è un\'app islamica progettata per rendere la pratica quotidiana più semplice, serena e accessibile.';

  @override
  String get whatYouCanDo => 'Cosa puoi fare con Boshra';

  @override
  String get quranDesc =>
      'Leggi il Corano con un\'esperienza chiara e confortevole.';

  @override
  String get quranRecitation => 'Recitazione del Corano';

  @override
  String get quranRecitationDesc =>
      'Ascolta le recitazioni del tuo recitatore preferito.';

  @override
  String get azkarDesc =>
      'Mantieni i tuoi Azkar quotidiani organizzati e facili da utilizzare.';

  @override
  String get prayerTimesDesc =>
      'Consulta orari di preghiera accurati in base alla tua posizione.';

  @override
  String get qiblaDesc =>
      'Trova la direzione della Kaaba utilizzando la posizione e la bussola del dispositivo.';

  @override
  String get reminders => 'Promemoria';

  @override
  String get remindersDesc =>
      'Ricevi promemoria puntuali per restare costante durante la giornata.';

  @override
  String get appInfo => 'Informazioni sull\'app';

  @override
  String get version => 'Versione';

  @override
  String get buildNumber => 'Build';

  @override
  String get moreOptions => 'Altro';

  @override
  String get rateBoshra => 'Valuta Boshra';

  @override
  String get rateBoshraDesc => 'Sostieni Boshra lasciando una recensione.';

  @override
  String get shareBoshra => 'Condividi Boshra';

  @override
  String get shareBoshraDesc => 'Condividi Boshra con familiari e amici.';

  @override
  String get contactUs => 'Contattaci';

  @override
  String get contactUsDesc => 'Contatta Mahmoud Ashraf.';

  @override
  String get openSourceLicenses => 'Licenze open source';

  @override
  String get openSourceDesc =>
      'Visualizza le licenze del software open source di terze parti utilizzato da Boshra.';

  @override
  String get madeWithCare =>
      'Realizzato con cura per chi desidera una connessione più vicina al Corano e al ricordo di Allah.';

  @override
  String get locationText => 'Posizione';

  @override
  String get privacyPolicyText => 'Informativa sulla privacy';

  @override
  String get clearLocalDataText => 'Cancella dati locali';

  @override
  String get prayerTimesText => 'Tempi di preghiera';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeLightDesc => 'Interfaccia chiara e calda';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeDarkDesc => 'Interfaccia scura e profonda';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemDesc => 'Segui impostazioni dispositivo';

  @override
  String get soundType => 'Tipo di notifica';

  @override
  String get soundSilent => 'Silenzioso (senza suono)';

  @override
  String get soundShort => 'Segnale breve';

  @override
  String get soundAdhan => 'Adhan completo';

  @override
  String get prePrayerAlertDesc => 'Avvisami prima dell’Adhan di';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'È l’ora della preghiera di $prayerName';
  }

  @override
  String get prayerNotifBody => 'Affrettatevi alla preghiera';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return 'La preghiera di $prayerName si avvicina';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'Mancano $minutes minuti all’Adhan';
  }

  @override
  String get notifDisabledTitle => 'Le notifiche sono disattivate';

  @override
  String get notifDisabledDesc =>
      'Attiva le notifiche per ricevere Adhan e promemoria in orario.';

  @override
  String get exactAlarmTitle => 'Le sveglie esatte sono disattivate';

  @override
  String get exactAlarmDesc =>
      'Consenti «Sveglie e promemoria» affinché l’Adhan arrivi all’ora esatta.';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get retry => 'Riprova';

  @override
  String get errorGeneric => 'Qualcosa è andato storto. Riprova.';

  @override
  String get errorNoInternet =>
      'Nessuna connessione internet. Controlla la connessione e riprova.';

  @override
  String get errorLoadFailed => 'Impossibile caricare il contenuto.';

  @override
  String get downloadingProgress => 'Download in corso…';

  @override
  String get downloadSuccess => 'Download completato';

  @override
  String get downloadFailed => 'Download non riuscito. Riprova.';

  @override
  String get shareFailed => 'Impossibile creare l’immagine. Riprova.';

  @override
  String get audioLoadFailed =>
      'Impossibile riprodurre l’audio. Controlla la connessione.';

  @override
  String get radioLoadFailed => 'Impossibile caricare le stazioni';

  @override
  String get continueReadingBtn => 'Continua a leggere';

  @override
  String get permSetupTitle => 'Non perdere nessuna preghiera';

  @override
  String get permSetupSubtitle =>
      'Consenti alcune autorizzazioni una volta sola: Adhan e promemoria arriveranno sempre in orario, anche con l’app chiusa.';

  @override
  String get permNotifTitle => 'Notifiche';

  @override
  String get permNotifDesc =>
      'Per mostrare Adhan, promemoria di preghiera, Azkar e messaggi del Corano.';

  @override
  String get permExactTitle => 'Sveglie e promemoria';

  @override
  String get permExactDesc =>
      'Permette ad Android di emettere l’Adhan al minuto esatto.';

  @override
  String get permBatteryTitle => 'Batteria senza restrizioni';

  @override
  String get permBatteryDesc =>
      'Impedisce al sistema di sospendere l’app e perdere notifiche.';

  @override
  String get permAutostartTitle => 'Avvio automatico e background';

  @override
  String permAutostartDesc(String brand) {
    return 'Il tuo telefono ($brand) può bloccare le app in background. Consenti a Boshra l’avvio automatico e l’esecuzione in background.';
  }

  @override
  String get permChannelsTitle => 'Categorie di notifica e suono';

  @override
  String get permChannelsDesc =>
      'Alcune categorie di notifica sono disattivate. Attivale per sentire l’Adhan.';

  @override
  String get permAllowAll => 'Consenti tutto';

  @override
  String get permAllow => 'Consenti';

  @override
  String get permGranted => 'Consentito';

  @override
  String get permContinue => 'Continua';

  @override
  String get permLater => 'Più tardi';

  @override
  String get permAllSet =>
      'Tutto pronto! Le notifiche arriveranno in modo affidabile.';

  @override
  String get permMissingNote =>
      'Alcune autorizzazioni sono ancora disattivate. Le notifiche potrebbero ritardare o non arrivare.';

  @override
  String get permFix => 'Risolvi ora';
}
