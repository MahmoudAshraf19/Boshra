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

  @override
  String get adhanStopAction => 'Interrompi l’adhan';

  @override
  String get adhanBannerTitle => 'Banner dell’adhan';

  @override
  String get adhanBannerDesc =>
      'Appare in alto sullo schermo e nella schermata di blocco all’ora dell’adhan, con un pulsante per interromperlo.';

  @override
  String get adhanBannerPreview => 'Anteprima del banner';

  @override
  String get adhanBannerVerse =>
      'In verità, la preghiera è un obbligo per i credenti, a tempi stabiliti.';

  @override
  String get notifSettingsTitle => 'Notifiche e Adhan';

  @override
  String get modeSilent => 'Silenzioso';

  @override
  String get modeShort => 'Avviso breve';

  @override
  String get modeAdhan => 'Adhan completo';

  @override
  String get modeSilentDesc => 'Notifica senza suono';

  @override
  String get modeShortDesc => 'Suono di notifica normale';

  @override
  String get modeAdhanDesc => 'Adhan completo con pulsante Stop';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get remindersSection => 'Promemoria giornalieri';

  @override
  String afterFajrDesc(int minutes) {
    return '$minutes min dopo il Fajr';
  }

  @override
  String afterAsrDesc(int minutes) {
    return '$minutes min dopo l’Asr (prima del tramonto)';
  }

  @override
  String get ayahReminderTitle => 'Versetto del giorno';

  @override
  String get ayahReminderDesc =>
      'Un nuovo versetto ogni giorno all’ora che scegli';

  @override
  String get reminderTime => 'Orario';

  @override
  String get muadhinTitle => 'Muezzin';

  @override
  String get atAdhanTime => 'All’ora dell’Adhan';

  @override
  String get advancedSection => 'Precisione e calcolo';

  @override
  String get calcMethodTitle => 'Metodo di calcolo';

  @override
  String get calcMethodAuto => 'Automatico (in base alla posizione)';

  @override
  String get asrSchoolTitle => 'Calcolo dell’Asr';

  @override
  String get asrStandard => 'Standard (shafiita, malikita, hanbalita)';

  @override
  String get asrHanafi => 'Hanafita';

  @override
  String get adjustTimesTitle => 'Regolazione fine degli orari (minuti)';

  @override
  String get testAdhanButton => 'Prova l’Adhan ora';

  @override
  String get locationFallbackWarning =>
      'La tua posizione non è disponibile: gli orari sono calcolati per La Mecca. Attiva la posizione per orari precisi.';

  @override
  String get sadaqaJariyaTitle => 'Carità continua (Sadaqa Jariya)';

  @override
  String get sadaqaHadith =>
      '«Chi guida verso il bene avrà una ricompensa pari a chi lo compie.»';

  @override
  String get narratedByMuslim => 'Riportato da Muslim';

  @override
  String get yourInviteCode => 'Il tuo codice invito';

  @override
  String get codeCopied => 'Codice copiato';

  @override
  String get shareAppButton => 'Condividi l\'applicazione';

  @override
  String get shareViaWhatsApp => 'Condividi via WhatsApp';

  @override
  String get startFirstShare => 'Fai la tua prima condivisione 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'Hai condiviso l\'app $count volta/volte — che Allah accetti';
  }

  @override
  String get haveFriendCode => 'Hai il codice invito di un amico?';

  @override
  String recordedInviteFrom(Object code) {
    return 'Invito registrato di $code — che Allah lo ricompensi';
  }

  @override
  String get invalidInviteCode => 'Codice non valido (es: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'Questo è il tuo codice personale 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'Uso l\'applicazione «Boshra» per l\'Adhan, il Corano e gli Azkar — ve la consiglio 🌙\nCondividetela come carità continua — «Chi guida verso il bene avrà una ricompensa pari a chi lo compie.»\n\n$link\nCodice invito: $code';
  }

  @override
  String get diagTitle => 'L\'Adhan suonerà?';

  @override
  String get diagAllGood =>
      'Tutto a posto — l\'Adhan suonerà in orario insha\'Allah';

  @override
  String diagCanImprove(Object count) {
    return 'L\'Adhan dovrebbe suonare, ma ci sono $count punto/i da migliorare';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count problema/i potrebbero impedire l\'Adhan — risolvi con i pulsanti sotto';
  }

  @override
  String get diagFix => 'Risolvi';

  @override
  String get diagTestAdhanNow => 'Prova l\'Adhan adesso';

  @override
  String get diagReschedule => 'Riprogramma';

  @override
  String get diagRecentEvents => 'Eventi recenti';

  @override
  String get diagNoEvents => 'Nessun evento ancora';

  @override
  String get diagCopyReport => 'Copia report per assistenza';

  @override
  String get diagReportCopied => 'Report di supporto copiato';

  @override
  String get diagNotifications => 'Notifiche';

  @override
  String get diagNotifEnabled => 'Abilitate';

  @override
  String get diagNotifBlocked => 'Bloccate — l\'Adhan non potrà apparire';

  @override
  String get diagEnable => 'Attiva';

  @override
  String get diagChannels => 'Canali di notifica';

  @override
  String get diagChannelsAllEnabled => 'Tutti abilitati';

  @override
  String get diagChannelMuted =>
      'Un canale è silenziato nelle impostazioni di sistema';

  @override
  String get diagOpenSettings => 'Apri impostazioni';

  @override
  String get diagExactAlarms => 'Allarmi precisi';

  @override
  String get diagExactAlarmsAllowed =>
      'Consentito — l\'Adhan scatta al secondo esatto';

  @override
  String get diagExactAlarmsNotAllowed =>
      'Non consentito — l\'Adhan potrebbe ritardare';

  @override
  String get diagAllow => 'Consenti';

  @override
  String get diagBattery => 'Ottimizzazione batteria';

  @override
  String get diagBatteryExempt => 'Applicazione esentata';

  @override
  String get diagBatteryMayKill =>
      'Il sistema potrebbe arrestare l\'app in background';

  @override
  String get diagExempt => 'Esenta';

  @override
  String get diagPrayerMode => 'Modalità preghiera';

  @override
  String get diagPrayerModeFullSilence =>
      'Silenzio totale pronto (accesso Non Disturbare consentito)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'Senza accesso a «Non disturbare» possiamo solo vibrare';

  @override
  String get diagGrantPermission => 'Concedi permesso';

  @override
  String get diagAutostart => 'Avvio automatico';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'Configurato ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return 'I dispositivi $brand chiudono le app — attiva l\'avvio automatico';
  }

  @override
  String get diagOpen => 'Apri';

  @override
  String get diagLocation => 'Posizione';

  @override
  String diagLocationManual(Object city) {
    return 'Città manuale: $city';
  }

  @override
  String get diagLocationApprox => 'Approssimativa';

  @override
  String get diagLocationUnknown => 'Sconosciuta — uso città predefinita';

  @override
  String get diagLocationGpsOff =>
      'Il servizio di localizzazione (GPS) è disattivato';

  @override
  String get diagLocationDenied => 'Autorizzazione di posizione negata';

  @override
  String get diagLocationPermanentlyDenied =>
      'Permesso negato in modo permanente — apri impostazioni';

  @override
  String get diagLocationNoFix =>
      'Impossibile rilevare la posizione (segnale debole)';

  @override
  String get diagLocationMock => 'Posizione fittizia attiva — ignorata';

  @override
  String get diagLocationTzMismatch =>
      'La posizione contraddice il fuso orario del dispositivo';

  @override
  String get diagFixLocation => 'Correggi posizione';

  @override
  String get diagSetLocation => 'Imposta';

  @override
  String get diagLastScheduling => 'Ultima pianificazione';

  @override
  String get diagNeverScheduled => 'Non ancora programmato';

  @override
  String get diagScheduleNow => 'Pianifica adesso';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count avvisi';
  }

  @override
  String get diagScheduleIncomplete => 'incompleto (calcolo offline)';

  @override
  String get diagScheduleError => 'errore';

  @override
  String get diagNextAdhan => 'Prossimo Adhan';

  @override
  String get diagAllPrayersSilent =>
      'Tutte le preghiere sono impostate su silenzioso o notifica breve';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count Adhan programmati nel sistema';
  }

  @override
  String get diagNoAdhanArmed =>
      'Nessun Adhan programmato negli allarmi! Tocca pianifica';

  @override
  String get diagOfflineMode => 'Modalità offline';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count mesi in cache — funziona senza internet';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'Solo $count mese in cache (si completerà online)';
  }

  @override
  String get diagInternet => 'Internet';

  @override
  String get diagInternetConnected => 'Connesso al server degli orari';

  @override
  String get diagInternetUnavailable =>
      'Non disponibile ora — gli orari salvati sono sufficienti';

  @override
  String get diagTestAdhanTitle => 'Test dell\'Adhan';

  @override
  String get diagTestAdhanBody => 'Se senti questo, tutto funziona';

  @override
  String get diagStop => 'Stop';

  @override
  String get diagAgoJustNow => 'adesso';

  @override
  String diagAgoMinutes(Object m) {
    return '$m min fa';
  }

  @override
  String diagAgoHours(Object h) {
    return '$h ore fa';
  }

  @override
  String diagAgoDays(Object d) {
    return '$d giorni fa';
  }

  @override
  String get zakatCalculatorTitle => 'Calcolatore della Zakat';

  @override
  String get zakatCurrency => 'Valuta';

  @override
  String get zakatTodayPricesGram => 'Prezzi di oggi (al grammo)';

  @override
  String get zakatRefresh => 'Aggiorna';

  @override
  String get zakatEditManually => 'Modifica manualmente';

  @override
  String get zakatCouldNotLoadPrices =>
      'Impossibile caricare i prezzi (offline). Tocca ✏️ per inserire il prezzo al grammo.';

  @override
  String get zakatGold24 => 'Oro 24 carati';

  @override
  String get zakatGold21 => 'Oro 21 carati';

  @override
  String get zakatGold18 => 'Oro 18 carati';

  @override
  String get zakatSilver => 'Argento';

  @override
  String get zakatGram => 'g';

  @override
  String get zakatUsingManualPrices => '✏️ Utilizzo dei tuoi prezzi manuali';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'Prezzo globale × tasso di cambio — aggiornato $date';
  }

  @override
  String get zakatPriceOld => ' (vecchio)';

  @override
  String get zakatNisab => 'Nisab';

  @override
  String get zakatGoldNisab => 'Oro (85 g)';

  @override
  String get zakatSilverNisab => 'Argento (595 g)';

  @override
  String get zakatNisabExplanation =>
      'Usa il nisab indicato dalla tua autorità religiosa di fiducia. Il nisab d\'argento ha un valore inferiore e copre più persone.';

  @override
  String get zakatYourWealth => 'I tuoi beni';

  @override
  String get zakatCashSavings => 'Contanti, risparmi e conti bancari';

  @override
  String get zakatSharesInvestments => 'Azioni, investimenti e fondi';

  @override
  String get zakatTradeGoods => 'Merci commerciali (valore di mercato)';

  @override
  String get zakatMoneyOwedToYou => 'Crediti da riscuotere (sicuri)';

  @override
  String get zakatDebtsDue => 'Debiti a breve termine da pagare (dedotti)';

  @override
  String get zakatJewelleryNote =>
      'Gli studiosi divergono sulla Zakat per i gioielli personali; lascia vuoti i campi se segui l\'opinione di esenzione.';

  @override
  String get zakatTotalZakatableWealth => 'Totale dei beni soggetti a Zakat';

  @override
  String get zakatEnterPriceForNisab =>
      'Inserisci il prezzo dell\'oro/argento per calcolare il nisab';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'Nisab: $amount $cur';
  }

  @override
  String get zakatDue25 => 'Zakat dovuta (2,5%)';

  @override
  String get zakatHawlCondition =>
      'A condizione che sia trascorso un anno lunare completo (Hawl).';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'Sotto la soglia del nisab (mancano $amount $cur) — nessuna Zakat dovuta ora.';
  }

  @override
  String get zakatCopyResult => 'Copia risultato';

  @override
  String get zakatResultCopied => 'Risultato copiato';

  @override
  String get zakatYearlyReminder => 'Promemoria annuale Zakat';

  @override
  String get zakatReminderExplanation =>
      'Scegli la data in cui hai raggiunto il nisab. Ti ricorderemo una settimana prima e il giorno esatto ogni anno lunare.';

  @override
  String get zakatSetDate => 'Imposta data';

  @override
  String zakatNextDue(Object date) {
    return 'Prossima scadenza: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'Nota: guida generale. Per casi particolari (azioni societarie, immobili commerciali...), consulta uno studioso.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'Prezzi locali manuali ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'Il prezzo locale dell\'orefice può differire da quello mondiale. Inserisci il prezzo al grammo o lascia vuoto.';

  @override
  String get zakatGold24PerGram => 'Oro 24k al grammo';

  @override
  String get zakatSilverPerGram => 'Argento al grammo';

  @override
  String get zakatPickHawlHelp => 'Data in cui hai raggiunto il nisab';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'Zakat — Boshra\nTotale beni imponibili: $total $cur\nNisab ($nisabType): $nisabVal $cur\nZakat dovuta (2,5%): $due $cur';
  }

  @override
  String get trackerTitle => 'Monitoraggio preghiere';

  @override
  String get trackerTimeNotStarted =>
      'L\'orario di questa preghiera non è ancora iniziato 🌙';

  @override
  String get trackerLearningHabits => '🧠 Analisi delle tue abitudini';

  @override
  String get trackerLearningDesc =>
      'Registra le tue preghiere per almeno 5 giorni e ti suggeriremo miglioramenti su misura (analisi solo sul dispositivo).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 Il Fajr ti sfugge: $missed degli ultimi $days giorni';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'Il promemoria per dormire presto è attivo alle $time ogni sera 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'Perdere il Fajr è spesso dovuto al dormire tardi. Vuoi un promemoria serale per dormire presto?';

  @override
  String trackerTurnOnTime(Object time) {
    return 'Attiva ($time)';
  }

  @override
  String get trackerNotNow => 'Non ora';

  @override
  String get trackerChangeTime => 'Modifica orario';

  @override
  String get trackerTurnOff => 'Disattiva';

  @override
  String get trackerPickAnotherTime => 'Scegli un altro orario';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer viene spesso pregata verso la fine del suo tempo';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'Il promemoria per $prayer ora arriverà prima (a metà finestra invece che alla fine).';
  }

  @override
  String get trackerGreatConsistency => '✨ Ottima costanza';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 Preghiera meno frequente: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'Nessuna preghiera viene persa ripetutamente. Continua così!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'Mancata $missed volte negli ultimi $days giorni. Il promemoria gentile ti aiuterà.';
  }

  @override
  String get trackerTurnOffNudge => 'Disattiva promemoria gentile';

  @override
  String get trackerTurnOnNudge => 'Attiva promemoria gentile';

  @override
  String get trackerStopLearning => 'Interrompi analisi abitudini';

  @override
  String get trackerStartLearning => 'Analizza le mie abitudini';

  @override
  String get trackerStartStreakToday => 'Inizia la tua serie oggi';

  @override
  String trackerStreakDays(Object count) {
    return 'Serie di $count giorni, tutte e cinque le preghiere';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'Miglior serie: $best — questa settimana: $pct%';
  }

  @override
  String get trackerToday => 'Oggi';

  @override
  String get trackerYesterday => 'Ieri';

  @override
  String get trackerYourGarden => 'Il tuo giardino 🌳';

  @override
  String get trackerGardenDesc =>
      'Ogni preghiera ha un albero che cresce ogni giorno di costanza';

  @override
  String get trackerDayUnit => 'g';

  @override
  String get trackerTodayPrayers => 'Preghiere di oggi';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'Preghiere del $date';
  }

  @override
  String get trackerPrayedMark => 'Pregata ✓';

  @override
  String get trackerNotMarked => 'Non registrata';

  @override
  String get trackerThisWeek => 'Questa settimana';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'Totale registrato: $count preghiere';
  }

  @override
  String get gardenTitle => 'Il mio giardino';

  @override
  String get gardenHomeCardTitle => 'Il tuo giardino di preghiere 🌳';

  @override
  String get gardenEnterFull => 'Entra nel tuo giardino completo 🌿';

  @override
  String get gardenTooEarlySeed => 'Troppo presto… il seme attende 🌱';

  @override
  String get gardenChooseMonth => 'Scegli il mese';

  @override
  String get gardenOf => 'Giardino di';

  @override
  String get gardenHijriSuffix => 'H';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count giorni perfetti';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'Miglior serie $count';
  }

  @override
  String get gardenBlessedForest => 'Una foresta benedetta';

  @override
  String gardenWeekNumber(Object num) {
    return 'Settimana $num';
  }

  @override
  String get gardenMsgFlourishing =>
      'Masha Allah! Un giardino rigoglioso 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'Un bel giardino — continua così e diventerà una foresta 🌿';

  @override
  String get gardenMsgWaterToday =>
      'Ogni preghiera innaffia un albero. Inizia oggi 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'Il giardino ti aspetta… la prima preghiera pianta il primo albero 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'Pregata ✓ alle $time';
  }

  @override
  String get plantStatusPrayed => 'Pregata ✓';

  @override
  String get plantStatusPending =>
      'L\'orario è giunto — non ancora registrata 💧';

  @override
  String get plantStatusMissed =>
      'Non registrata — l\'albero ha bisogno d\'acqua';

  @override
  String get plantStatusUpcoming => 'Non è ancora l\'ora 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return 'Un albero da frutto! $streak giorni consecutivi per $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return '$streak giorni di fila per $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'Giorno $streak della tua serie per $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'Ogni preghiera fa crescere l\'albero — la costanza è la sua acqua 💧';

  @override
  String get plantUndo => 'Annulla';

  @override
  String get plantWaterAction => 'Ho pregato — innaffia l\'albero 💧';

  @override
  String get plantStageSeed => 'Seme';

  @override
  String get plantStageSprout => 'Germoglio';

  @override
  String get plantStageSapling => 'Arbusto';

  @override
  String get plantStageYoungTree => 'Alberello';

  @override
  String get plantStageTree => 'Albero';

  @override
  String get plantStageFruitTree => 'Albero da frutto';

  @override
  String get treeCherryBlossom => 'Ciliegio in fiore';

  @override
  String get treeDatePalm => 'Palma da dattero';

  @override
  String get treeOrangeTree => 'Arancio';

  @override
  String get treePomegranate => 'Melograno';

  @override
  String get treeCypress => 'Cipresso';

  @override
  String get weeklySummaryTitle => 'Riepilogo settimanale';

  @override
  String get weeklyShareAsImage => 'Condividi come immagine';

  @override
  String get weeklyNoPrayersLogged =>
      'Nessuna preghiera registrata questa settimana. Inizia dal tuo giardino nella Home 🌱';

  @override
  String get weeklyShareYourTree => 'Condividi il tuo albero settimanale';

  @override
  String get weeklyNotificationHint =>
      'Ogni venerdì sera dopo l\'Isha riceverai una notifica con il tuo riepilogo settimanale.';

  @override
  String get weeklyImageError => 'Impossibile creare l\'immagine, riprova';

  @override
  String get weeklyCardTitle => 'Il mio riepilogo settimanale';

  @override
  String get weeklyCardTreeSubtitle =>
      'Il mio albero delle preghiere questa settimana 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% delle mie preghiere eseguite puntualmente';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'Preghiera più costante: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'Meno costante: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 Serie di $count giorni, tutte le preghiere';
  }

  @override
  String get weeklyCardAppBranding => 'Boshra — Adhan, Azkar & Corano';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'Hai pregato $total su $max';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'la più costante: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'e la meno costante: $prayer';
  }

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';
}
