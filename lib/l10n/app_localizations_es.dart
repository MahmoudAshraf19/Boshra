// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Boshra';

  @override
  String get onboarding1Title => 'Bushra... Tu compañero en el camino del bien';

  @override
  String get onboarding1Desc =>
      'Haz que tu día esté más cerca de Allah, con pasos simples.';

  @override
  String get onboarding2Title =>
      'Todo lo que necesitas para tu adoración, en un solo lugar';

  @override
  String get onboarding2Desc =>
      'Corán, tiempos de oración, Adhkar, Qibla y súplicas.';

  @override
  String get onboarding3Title =>
      'Un pequeño paso cada día... hace un gran impacto';

  @override
  String get onboarding3Desc =>
      'Construye tus hábitos de fe y aprovecha los momentos de tu día.';

  @override
  String get startJourney => 'Comienza tu viaje';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get navHome => 'Inicio';

  @override
  String get navQuran => 'Corán';

  @override
  String get navAzkar => 'Azkar';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navRadio => 'Radio';

  @override
  String get navMore => 'Más';

  @override
  String nextPrayerTitle(String prayerName) {
    return '$prayerName';
  }

  @override
  String untilNextPrayer(String prayerName) {
    return 'Hasta $prayerName';
  }

  @override
  String get greeting => 'As-salamu alaykum👋';

  @override
  String get surahs => 'Suras';

  @override
  String get juzs => 'Juzs';

  @override
  String get prayerSettingsTitle => 'Ajustes de Oración y Adhan';

  @override
  String get prePrayerAlertTitle => 'Alerta antes de la Oración';

  @override
  String minutesBeforeAdhan(int minutes) {
    return '$minutes minutos antes del Adhan';
  }

  @override
  String get enablePrayerAlertsTitle => 'Activar Alertas de Oración';

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
  String get ayahOfTheDay => 'Aleya del Día';

  @override
  String get listen => 'Escuchar';

  @override
  String get tafseer => 'Tafsir';

  @override
  String surahAndVerse(String surahName, String verseNumber) {
    return '$surahName • Aleya $verseNumber';
  }

  @override
  String get dailyWird => 'Completa tu Wird diario';

  @override
  String get morningAzkar => 'Azkar de la mañana';

  @override
  String get eveningAzkar => 'Azkar de la tarde';

  @override
  String get continueReading => 'Continuar';

  @override
  String get morningAzkarNotificationTitle => 'Azkar de la Mañana 🌅';

  @override
  String get morningAzkarNotificationBody =>
      'Comienza tu día con el recuerdo de Allah';

  @override
  String get eveningAzkarNotificationTitle => 'Azkar de la Tarde 🌙';

  @override
  String get eveningAzkarNotificationBody =>
      'Termina tu día con el recuerdo de Allah';

  @override
  String get quickAccess => 'Acceso Rápido';

  @override
  String get qibla => 'Qibla';

  @override
  String get recitation => 'Recitación';

  @override
  String get quran => 'Corán';

  @override
  String get quranRadio => 'Radio del Corán';

  @override
  String get azkar => 'Azkar';

  @override
  String get continueReadingCardTitle => 'Continuar Leyendo';

  @override
  String surahName(String surahName) {
    return 'Sura $surahName';
  }

  @override
  String ayahNumber(String number) {
    return 'Aleya $number';
  }

  @override
  String get selectedRecitationTitle => 'Recitación Seleccionada';

  @override
  String get live => 'En vivo';

  @override
  String get quranScreenTitle => 'El Sagrado Corán';

  @override
  String get startQuranJourney => 'Comienza tu viaje con el Corán';

  @override
  String get openSurahAndRead => 'Abre una Sura y comienza a leer';

  @override
  String get browseSurahs => 'Explorar Suras';

  @override
  String get searchSurah => 'Buscar una Sura...';

  @override
  String get tabSurahs => 'Suras';

  @override
  String get tabJuzs => 'Juzs';

  @override
  String get tabHizbs => 'Hizbs';

  @override
  String get meccan => 'Mequinense';

  @override
  String get medinan => 'Medinense';

  @override
  String ayahsCount(Object count) {
    return '$count Versos';
  }

  @override
  String get tafsirOption => 'Tafsir';

  @override
  String get recitationOption => 'Recitación';

  @override
  String get downloadOption => 'Descargar';

  @override
  String get shareOption => 'Compartir';

  @override
  String get infoOption => 'Información';

  @override
  String get copyOption => 'Copiar';

  @override
  String get copiedSuccessfully => 'Versículo copiado al portapapeles';

  @override
  String get azkarScreenTitle => 'Azkar';

  @override
  String get azkarScreenSubtitle => 'Cerca de Allah… en cada momento';

  @override
  String get azkarCategoryMorning => 'Azkar de la mañana';

  @override
  String get azkarCategoryMorningSub => 'Invocaciones para la mañana';

  @override
  String get azkarCategoryEvening => 'Azkar de la tarde';

  @override
  String get azkarCategoryEveningSub => 'Invocaciones para la tarde';

  @override
  String get azkarCategoryPrayer => 'Después de la oración';

  @override
  String get azkarCategoryPrayerSub => 'Invocaciones tras la oración';

  @override
  String get azkarCategorySleep => 'Azkar para dormir';

  @override
  String get azkarCategorySleepSub => 'Invocaciones antes de dormir';

  @override
  String get azkarCategoryProtection => 'Azkar de protección';

  @override
  String get azkarCategoryProtectionSub => 'Para protección y serenidad';

  @override
  String get azkarCategoryDaily => 'Azkar diarios';

  @override
  String get azkarCategoryDailySub => 'Diversas invocaciones para el día';

  @override
  String get azkarAllCategories => 'Todas las categorías';

  @override
  String get quranMessageNotificationTitle => 'Mensaje del Corán 🌿';

  @override
  String get saveBookmark => 'Guardar Marcador';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'Marcador guardado en Sura $surahName Aleya $ayahNumber';
  }

  @override
  String get qiblaDirection => 'Dirección de la Qibla';

  @override
  String get qiblaAccurate => 'Qibla exacta';

  @override
  String get youAreFacingQibla => 'Ahora estás frente a la Qibla';

  @override
  String get qiblaCalibration => 'Calibración de la Qibla';

  @override
  String get qiblaCalibrationDesc =>
      'Mueva su teléfono lentamente en forma de 8 para calibrar la brújula.';

  @override
  String get findingLocation => 'Buscando ubicación...';

  @override
  String get locationPermissionError =>
      'No se puede acceder a la ubicación. Habilite el GPS.';

  @override
  String get locationPermissionTitle => 'Permitir acceso a la ubicación';

  @override
  String get locationPermissionDesc =>
      'Necesitamos tu ubicación para calcular con precisión la dirección de la Qibla desde tu posición actual.';

  @override
  String get preciseQibla => 'Qibla precisa';

  @override
  String get exactLocation => 'Tu ubicación exacta';

  @override
  String get alwaysUpToDate => 'Siempre al día';

  @override
  String get allowLocationBtn => 'Permitir acceso';

  @override
  String get notNow => 'Ahora no';

  @override
  String get startupLocationTitle => 'Acceso a la ubicación';

  @override
  String startupLocationDescSaved(String locationName) {
    return 'Necesitamos tu ubicación para ofrecer horarios de oración y dirección de la Qibla precisos.\n\nSi no la permites, usaremos tu última ubicación guardada: $locationName.';
  }

  @override
  String get startupLocationDescDefault =>
      'Necesitamos tu ubicación para ofrecer horarios de oración y dirección de la Qibla precisos.\n\nSi no la permites, usaremos la ubicación predeterminada: La Meca, Arabia Saudita.';

  @override
  String get moreScreenTitle => 'Más';

  @override
  String get generalSettings => 'General';

  @override
  String get appearance => 'Apariencia';

  @override
  String get systemDefault => 'Predeterminado';

  @override
  String get appLanguage => 'Idioma de la App';

  @override
  String get alertsSettings => 'Alertas';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get adhanAndReminders => 'Adhan y Recordatorios';

  @override
  String get dataAndStorage => 'Datos y Almacenamiento';

  @override
  String get storage => 'Almacenamiento';

  @override
  String get storageDesc => 'Gestionar Suras descargadas';

  @override
  String get infoAndSupport => 'Info y Soporte';

  @override
  String get privacyAndPermissions => 'Privacidad y Permisos';

  @override
  String get aboutBoshra => 'Acerca de Boshra';

  @override
  String get downloadedOption => 'Descargado';

  @override
  String get totalUsed => 'Total Utilizado';

  @override
  String get systemApp => 'Sistema (App)';

  @override
  String get downloadedSurahs => 'Suras Descargadas';

  @override
  String get cache => 'Caché';

  @override
  String get manageDownloads => 'Gestionar Descargas';

  @override
  String get clearCache => 'Borrar Caché';

  @override
  String get clearAllDownloads => 'Borrar todas las descargas';

  @override
  String get clearWarning => 'Esto eliminará todo el contenido descargado.';

  @override
  String get notEnoughSpace =>
      'No hay suficiente espacio (límite de 3GB alcanzado).';

  @override
  String get clearCacheWarning =>
      '¿Estás seguro? Esto eliminará datos temporales.';

  @override
  String get clearAllData => 'Borrar todos los datos';

  @override
  String get clearDataWarning =>
      '¿Estás seguro? Esto devolverá la app a su estado inicial.';

  @override
  String get yesClear => 'Sí, Borrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yourPrivacyMatters => 'Tu privacidad es importante para nosotros.';

  @override
  String get privacyRequestsDesc =>
      'Boshra solicita únicamente los permisos necesarios para ofrecer sus funciones.';

  @override
  String get permissions => 'Permisos';

  @override
  String get locationPermDesc =>
      'Se utiliza para calcular los horarios de oración con precisión y determinar la dirección de la Qibla según tu ubicación.';

  @override
  String get statusAllowed => 'Permitido';

  @override
  String get statusDenied => 'Denegado';

  @override
  String get notificationsPermDesc =>
      'Se utilizan para enviar horarios de oración, alertas del Adhan y recordatorios de Azkar.';

  @override
  String get yourData => 'Tus datos';

  @override
  String get yourDataDesc1 =>
      'Boshra no requiere una cuenta ni inicio de sesión.';

  @override
  String get yourDataDesc2 =>
      'Tus preferencias, contenido descargado y configuraciones locales pueden almacenarse en tu dispositivo para proporcionar las funciones de la aplicación.';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyPolicyDesc =>
      'Consulta cómo Boshra recopila, utiliza, almacena y protege la información.';

  @override
  String get termsAndConditions => 'Términos y condiciones';

  @override
  String get termsDesc => 'Consulta los términos que regulan el uso de Boshra.';

  @override
  String get dataAndPrivacy => 'Datos y privacidad';

  @override
  String get dataPrivacyDesc =>
      'Obtén información sobre los datos procesados por Boshra y tus opciones de privacidad.';

  @override
  String get permissionManagement => 'Gestión de permisos';

  @override
  String get manageLocationPerm => 'Gestionar permiso de ubicación';

  @override
  String get manageLocationDesc =>
      'Abre los ajustes del dispositivo para cambiar el acceso a la ubicación.';

  @override
  String get manageNotificationsPerm => 'Gestionar permiso de notificaciones';

  @override
  String get manageNotificationsDesc =>
      'Abre los ajustes del dispositivo para cambiar el acceso a las notificaciones.';

  @override
  String get localData => 'Datos locales';

  @override
  String get clearLocalDataDesc =>
      'Elimina los datos locales de Boshra almacenados en este dispositivo.';

  @override
  String get clearDownloadsDesc =>
      'Elimina las recitaciones del Corán y otros contenidos descargados para su uso sin conexión.';

  @override
  String get privacyNote => 'Nota de privacidad';

  @override
  String get privacyNoteDesc =>
      'Boshra utiliza la ubicación únicamente para funciones que la necesitan, como los horarios de oración y la dirección de la Qibla.';

  @override
  String get boshraTagline =>
      'Tu compañero diario para el Corán, la oración y el recuerdo de Allah.';

  @override
  String get boshraAboutDesc =>
      'Boshra es una aplicación islámica diseñada para hacer que tu adoración diaria sea más sencilla, tranquila y accesible.';

  @override
  String get whatYouCanDo => 'Lo que puedes hacer con Boshra';

  @override
  String get quranDesc => 'Lee el Corán con una experiencia clara y cómoda.';

  @override
  String get quranRecitation => 'Recitación del Corán';

  @override
  String get quranRecitationDesc =>
      'Escucha las recitaciones de tu recitador favorito.';

  @override
  String get azkarDesc =>
      'Mantén tus recuerdos diarios organizados y fáciles de usar.';

  @override
  String get prayerTimesDesc =>
      'Consulta horarios de oración precisos según tu ubicación.';

  @override
  String get qiblaDesc =>
      'Encuentra la dirección de la Kaaba mediante la ubicación y la brújula de tu dispositivo.';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get remindersDesc =>
      'Recibe recordatorios oportunos para mantener tus prácticas durante el día.';

  @override
  String get appInfo => 'Información de la aplicación';

  @override
  String get version => 'Versión';

  @override
  String get buildNumber => 'Compilación';

  @override
  String get moreOptions => 'Más';

  @override
  String get rateBoshra => 'Valorar Boshra';

  @override
  String get rateBoshraDesc => 'Apoya Boshra dejando una valoración.';

  @override
  String get shareBoshra => 'Compartir Boshra';

  @override
  String get shareBoshraDesc => 'Comparte Boshra con familiares y amigos.';

  @override
  String get contactUs => 'Contactarnos';

  @override
  String get contactUsDesc => 'Ponte en contacto con Mahmoud Ashraf.';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String get openSourceDesc =>
      'Consulta las licencias del software de código abierto utilizado por Boshra.';

  @override
  String get madeWithCare =>
      'Creado con cuidado para quienes buscan una conexión más cercana con el Corán y el recuerdo de Allah.';

  @override
  String get locationText => 'Ubicación';

  @override
  String get privacyPolicyText => 'Política de Privacidad';

  @override
  String get clearLocalDataText => 'Borrar datos locales';

  @override
  String get prayerTimesText => 'Tiempos de oración';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeLightDesc => 'Interfaz clara y cálida';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeDarkDesc => 'Interfaz oscura y profunda';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemDesc => 'Seguir ajustes del dispositivo';

  @override
  String get soundType => 'Tipo de notificación';

  @override
  String get soundSilent => 'Silencio (sin sonido)';

  @override
  String get soundShort => 'Tono corto';

  @override
  String get soundAdhan => 'Adhan completo';

  @override
  String get prePrayerAlertDesc => 'Avisarme antes del Adhan';

  @override
  String prayerNotifTitle(String prayerName) {
    return 'Es hora de la oración de $prayerName';
  }

  @override
  String get prayerNotifBody => 'Acude a la oración';

  @override
  String prePrayerNotifTitle(String prayerName) {
    return 'La oración de $prayerName se acerca';
  }

  @override
  String prePrayerNotifBody(int minutes) {
    return 'Faltan $minutes minutos para el Adhan';
  }

  @override
  String get notifDisabledTitle => 'Las notificaciones están desactivadas';

  @override
  String get notifDisabledDesc =>
      'Activa las notificaciones para recibir el Adhan y los recordatorios a tiempo.';

  @override
  String get exactAlarmTitle => 'Las alarmas exactas están desactivadas';

  @override
  String get exactAlarmDesc =>
      'Permite «Alarmas y recordatorios» para que el Adhan llegue a la hora exacta.';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get retry => 'Reintentar';

  @override
  String get errorGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get errorNoInternet =>
      'Sin conexión a internet. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get errorLoadFailed => 'No se pudo cargar el contenido.';

  @override
  String get downloadingProgress => 'Descargando…';

  @override
  String get downloadSuccess => 'Descarga completada';

  @override
  String get downloadFailed => 'La descarga falló. Inténtalo de nuevo.';

  @override
  String get shareFailed => 'No se pudo crear la imagen. Inténtalo de nuevo.';

  @override
  String get audioLoadFailed =>
      'No se pudo reproducir el audio. Revisa tu conexión.';

  @override
  String get radioLoadFailed => 'No se pudieron cargar las emisoras';

  @override
  String get continueReadingBtn => 'Continuar leyendo';

  @override
  String get permSetupTitle => 'No pierdas ninguna oración';

  @override
  String get permSetupSubtitle =>
      'Concede unos permisos una sola vez para que el Adhan y los recordatorios lleguen siempre a tiempo, incluso con la app cerrada.';

  @override
  String get permNotifTitle => 'Notificaciones';

  @override
  String get permNotifDesc =>
      'Para mostrar el Adhan, recordatorios de oración, Azkar y mensajes del Corán.';

  @override
  String get permExactTitle => 'Alarmas y recordatorios';

  @override
  String get permExactDesc =>
      'Permite que Android emita el Adhan en el minuto exacto.';

  @override
  String get permBatteryTitle => 'Batería sin restricciones';

  @override
  String get permBatteryDesc =>
      'Evita que el sistema suspenda la app y descarte notificaciones.';

  @override
  String get permAutostartTitle => 'Inicio automático y segundo plano';

  @override
  String permAutostartDesc(String brand) {
    return 'Tu teléfono ($brand) puede bloquear apps en segundo plano. Permite que Boshra se inicie sola y funcione en segundo plano.';
  }

  @override
  String get permChannelsTitle => 'Categorías de notificación y sonido';

  @override
  String get permChannelsDesc =>
      'Algunas categorías de notificación están desactivadas. Actívalas para oír el Adhan.';

  @override
  String get permAllowAll => 'Permitir todo';

  @override
  String get permAllow => 'Permitir';

  @override
  String get permGranted => 'Permitido';

  @override
  String get permContinue => 'Continuar';

  @override
  String get permLater => 'Más tarde';

  @override
  String get permAllSet =>
      '¡Todo listo! Las notificaciones llegarán de forma fiable.';

  @override
  String get permMissingNote =>
      'Algunos permisos siguen desactivados. Las notificaciones pueden retrasarse o no llegar.';

  @override
  String get permFix => 'Arreglar ahora';

  @override
  String get adhanStopAction => 'Detener el adhan';

  @override
  String get adhanBannerTitle => 'Banner del adhan';

  @override
  String get adhanBannerDesc =>
      'Aparece en la parte superior de la pantalla y en la pantalla de bloqueo a la hora del adhan, con un botón para detenerlo.';

  @override
  String get adhanBannerPreview => 'Vista previa del banner';

  @override
  String get adhanBannerVerse =>
      'En verdad, la oración es una obligación prescrita para los creyentes en tiempos determinados.';

  @override
  String get notifSettingsTitle => 'Notificaciones y Adhan';

  @override
  String get modeSilent => 'Silencioso';

  @override
  String get modeShort => 'Aviso corto';

  @override
  String get modeAdhan => 'Adhan completo';

  @override
  String get modeSilentDesc => 'Notificación sin sonido';

  @override
  String get modeShortDesc => 'Sonido de notificación normal';

  @override
  String get modeAdhanDesc => 'Adhan completo con botón de detener';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get remindersSection => 'Recordatorios diarios';

  @override
  String afterFajrDesc(int minutes) {
    return '$minutes min después del Fajr';
  }

  @override
  String afterAsrDesc(int minutes) {
    return '$minutes min después del Asr (antes del atardecer)';
  }

  @override
  String get ayahReminderTitle => 'Aleya del día';

  @override
  String get ayahReminderDesc =>
      'Un versículo nuevo cada día a la hora que elijas';

  @override
  String get reminderTime => 'Hora';

  @override
  String get muadhinTitle => 'Muecín';

  @override
  String get atAdhanTime => 'A la hora del Adhan';

  @override
  String get advancedSection => 'Precisión y cálculo';

  @override
  String get calcMethodTitle => 'Método de cálculo';

  @override
  String get calcMethodAuto => 'Automático (según tu ubicación)';

  @override
  String get asrSchoolTitle => 'Cálculo del Asr';

  @override
  String get asrStandard => 'Estándar (shafií, maliki, hanbalí)';

  @override
  String get asrHanafi => 'Hanafí';

  @override
  String get adjustTimesTitle => 'Ajuste fino de horarios (minutos)';

  @override
  String get testAdhanButton => 'Probar el Adhan ahora';

  @override
  String get locationFallbackWarning =>
      'Tu ubicación no está disponible; los horarios se calculan para La Meca. Activa la ubicación para horarios precisos.';

  @override
  String get sadaqaJariyaTitle => 'Caridad continua (Sadaqa Yariya)';

  @override
  String get sadaqaHadith =>
      '«Quien guía hacia el bien tendrá una recompensa como la de quien lo hace.»';

  @override
  String get narratedByMuslim => 'Transmitido por Muslim';

  @override
  String get yourInviteCode => 'Tu código de invitación';

  @override
  String get codeCopied => 'Código copiado';

  @override
  String get shareAppButton => 'Compartir la aplicación';

  @override
  String get shareViaWhatsApp => 'Compartir por WhatsApp';

  @override
  String get startFirstShare => 'Haz tu primer envío 🌱';

  @override
  String sharedTimesCount(Object count) {
    return 'Has compartido la app $count vez/veces — que Alá lo acepte';
  }

  @override
  String get haveFriendCode => '¿Tienes el código de invitación de un amigo?';

  @override
  String recordedInviteFrom(Object code) {
    return 'Invitación registrada de $code — que Alá le recompense';
  }

  @override
  String get invalidInviteCode => 'Código no válido (ej: BSH-AB3K9)';

  @override
  String get ownInviteCodeError => 'Ese es tu propio código 🙂';

  @override
  String inviteShareMessage(Object code, Object link) {
    return 'Uso la aplicación «Boshra» para el Adhan, el Corán y las Súplicas — te la recomiendo 🌙\nCompártela como caridad continua — «Quien guía hacia el bien tendrá una recompensa como la de quien lo hace.»\n\n$link\nCódigo de invitación: $code';
  }

  @override
  String get diagTitle => '¿Sonará el Adhán?';

  @override
  String get diagAllGood =>
      'Todo en orden — el Adhán sonará a tiempo insha\'Allah';

  @override
  String diagCanImprove(Object count) {
    return 'El Adhán debería sonar, pero hay $count punto(s) a mejorar';
  }

  @override
  String diagProblemsFound(Object count) {
    return '$count problema(s) pueden impedir el Adhán — corrígelos abajo';
  }

  @override
  String get diagFix => 'Corregir';

  @override
  String get diagTestAdhanNow => 'Probar Adhán ahora';

  @override
  String get diagReschedule => 'Reprogramar';

  @override
  String get diagRecentEvents => 'Eventos recientes';

  @override
  String get diagNoEvents => 'Aún no hay eventos';

  @override
  String get diagCopyReport => 'Copiar informe para soporte';

  @override
  String get diagReportCopied => 'Informe de soporte copiado';

  @override
  String get diagNotifications => 'Notificaciones';

  @override
  String get diagNotifEnabled => 'Activadas';

  @override
  String get diagNotifBlocked => 'Bloqueadas — el Adhán no podrá mostrarse';

  @override
  String get diagEnable => 'Activar';

  @override
  String get diagChannels => 'Canales de notificación';

  @override
  String get diagChannelsAllEnabled => 'Todos activados';

  @override
  String get diagChannelMuted =>
      'Un canal está silenciado en los ajustes del sistema';

  @override
  String get diagOpenSettings => 'Abrir ajustes';

  @override
  String get diagExactAlarms => 'Alarmas exactas';

  @override
  String get diagExactAlarmsAllowed =>
      'Permitido — el Adhán suena al segundo exacto';

  @override
  String get diagExactAlarmsNotAllowed =>
      'No permitido — el Adhán podría retrasarse';

  @override
  String get diagAllow => 'Permitir';

  @override
  String get diagBattery => 'Optimización de batería';

  @override
  String get diagBatteryExempt => 'Aplicación excluida';

  @override
  String get diagBatteryMayKill =>
      'El sistema podría detener la aplicación en segundo plano';

  @override
  String get diagExempt => 'Excluir';

  @override
  String get diagPrayerMode => 'Modo oración';

  @override
  String get diagPrayerModeFullSilence =>
      'Silencio total listo (permiso No Molestar concedido)';

  @override
  String get diagPrayerModeVibrateOnly =>
      'Sin acceso a «No molestar», solo podemos activar la vibración';

  @override
  String get diagGrantPermission => 'Conceder permiso';

  @override
  String get diagAutostart => 'Inicio automático';

  @override
  String diagAutostartConfigured(Object brand) {
    return 'Configurado ($brand)';
  }

  @override
  String diagAutostartNeeds(Object brand) {
    return 'Los dispositivos $brand cierran apps en segundo plano — activa el inicio automático';
  }

  @override
  String get diagOpen => 'Abrir';

  @override
  String get diagLocation => 'Ubicación';

  @override
  String diagLocationManual(Object city) {
    return 'Ciudad manual: $city';
  }

  @override
  String get diagLocationApprox => 'Aproximada';

  @override
  String get diagLocationUnknown =>
      'Desconocida — usando ciudad predeterminada';

  @override
  String get diagLocationGpsOff =>
      'El servicio de ubicación (GPS) está apagado';

  @override
  String get diagLocationDenied => 'Permiso de ubicación denegado';

  @override
  String get diagLocationPermanentlyDenied =>
      'Permiso denegado permanentemente — abre ajustes';

  @override
  String get diagLocationNoFix =>
      'No se pudo determinar la ubicación (señal débil)';

  @override
  String get diagLocationMock => 'Ubicación simulada activa — ignorada';

  @override
  String get diagLocationTzMismatch =>
      'La posición contradice la zona horaria del dispositivo';

  @override
  String get diagFixLocation => 'Corregir ubicación';

  @override
  String get diagSetLocation => 'Establecer';

  @override
  String get diagLastScheduling => 'Última programación';

  @override
  String get diagNeverScheduled => 'Aún no se ha programado';

  @override
  String get diagScheduleNow => 'Programar ahora';

  @override
  String diagScheduleAlertsCount(Object count) {
    return '$count alertas';
  }

  @override
  String get diagScheduleIncomplete => 'incompleto (cálculo sin conexión)';

  @override
  String get diagScheduleError => 'error';

  @override
  String get diagNextAdhan => 'Próximo Adhán';

  @override
  String get diagAllPrayersSilent =>
      'Todas las oraciones están en silencio o tono corto';

  @override
  String diagArmedAdhansCount(Object count) {
    return '$count Adhán programados en el sistema';
  }

  @override
  String get diagNoAdhanArmed =>
      '¡No hay ningún Adhán programado! Pulsa programar';

  @override
  String get diagOfflineMode => 'Modo sin conexión';

  @override
  String diagOfflineMonthsCached(Object count) {
    return '$count meses en caché — funciona sin internet';
  }

  @override
  String diagOfflineMonthsOnly(Object count) {
    return 'Solo $count mes en caché (se completará con conexión)';
  }

  @override
  String get diagInternet => 'Internet';

  @override
  String get diagInternetConnected => 'Conectado al servidor de horarios';

  @override
  String get diagInternetUnavailable =>
      'No disponible ahora — los horarios guardados bastan';

  @override
  String get diagTestAdhanTitle => 'Prueba del Adhán';

  @override
  String get diagTestAdhanBody =>
      'Si escuchas esto, todo funciona correctamente';

  @override
  String get diagStop => 'Detener';

  @override
  String get diagAgoJustNow => 'ahora mismo';

  @override
  String diagAgoMinutes(Object m) {
    return 'hace $m min';
  }

  @override
  String diagAgoHours(Object h) {
    return 'hace $h h';
  }

  @override
  String diagAgoDays(Object d) {
    return 'hace $d d';
  }

  @override
  String get zakatCalculatorTitle => 'Calculadora de Zakat';

  @override
  String get zakatCurrency => 'Moneda';

  @override
  String get zakatTodayPricesGram => 'Precios de hoy (por gramo)';

  @override
  String get zakatRefresh => 'Actualizar';

  @override
  String get zakatEditManually => 'Editar manualmente';

  @override
  String get zakatCouldNotLoadPrices =>
      'No se pudieron cargar los precios (sin conexión). Pulsa ✏️ para introducirlos manualmente.';

  @override
  String get zakatGold24 => 'Oro de 24 quilates';

  @override
  String get zakatGold21 => 'Oro de 21 quilates';

  @override
  String get zakatGold18 => 'Oro de 18 quilates';

  @override
  String get zakatSilver => 'Plata';

  @override
  String get zakatGram => 'g';

  @override
  String get zakatUsingManualPrices => '✏️ Usando tus precios manuales';

  @override
  String zakatWorldPriceStamp(Object date) {
    return 'Precio global × tipo de cambio — actualizado $date';
  }

  @override
  String get zakatPriceOld => ' (antiguo)';

  @override
  String get zakatNisab => 'Nisab';

  @override
  String get zakatGoldNisab => 'Oro (85 g)';

  @override
  String get zakatSilverNisab => 'Plata (595 g)';

  @override
  String get zakatNisabExplanation =>
      'Usa el nisab recomendado por las autoridades académicas de tu confianza. El nisab de plata es menor, beneficiando a más necesitados.';

  @override
  String get zakatYourWealth => 'Tus bienes';

  @override
  String get zakatCashSavings => 'Efectivo, ahorros y cuentas bancarias';

  @override
  String get zakatSharesInvestments => 'Acciones, inversiones y fondos';

  @override
  String get zakatTradeGoods => 'Mercancías de comercio (valor de mercado)';

  @override
  String get zakatMoneyOwedToYou => 'Dinero que te deben (de cobro seguro)';

  @override
  String get zakatDebtsDue => 'Deudas inmediatas que debes (a deducir)';

  @override
  String get zakatJewelleryNote =>
      'Los eruditos difieren sobre las joyas de uso personal; déjalas vacías si sigues la opinión de exención.';

  @override
  String get zakatTotalZakatableWealth => 'Total de bienes sujetos a Zakat';

  @override
  String get zakatEnterPriceForNisab =>
      'Introduce el precio del oro/plata para calcular el nisab';

  @override
  String zakatNisabValue(Object amount, Object cur) {
    return 'Nisab: $amount $cur';
  }

  @override
  String get zakatDue25 => 'Zakat a pagar (2,5%)';

  @override
  String get zakatHawlCondition =>
      'Siempre que haya transcurrido un año lunar completo (Hawl).';

  @override
  String zakatNotEligibleShort(Object amount, Object cur) {
    return 'Por debajo del nisab (faltan $amount $cur) — no corresponde Zakat ahora.';
  }

  @override
  String get zakatCopyResult => 'Copiar resultado';

  @override
  String get zakatResultCopied => 'Resultado copiado';

  @override
  String get zakatYearlyReminder => 'Recordatorio anual de Zakat';

  @override
  String get zakatReminderExplanation =>
      'Elige la fecha en que tu riqueza alcanzó el nisab. Te avisaremos una semana antes y el día que se cumpla el año lunar.';

  @override
  String get zakatSetDate => 'Fijar fecha';

  @override
  String zakatNextDue(Object date) {
    return 'Próximo vencimiento: $date';
  }

  @override
  String get zakatScholarsDisclaimer =>
      'Aviso: guía general. Para casos específicos (acciones, empresas, bienes raíces comerciales...), consulta a un sabio.';

  @override
  String zakatManualPricesTitle(Object cur) {
    return 'Precios locales manuales ($cur)';
  }

  @override
  String get zakatManualPricesDesc =>
      'El precio local de joyería puede variar del precio global. Introduce tu precio por gramo o déjalo vacío para usar el automático.';

  @override
  String get zakatGold24PerGram => 'Oro 24k por gramo';

  @override
  String get zakatSilverPerGram => 'Plata por gramo';

  @override
  String get zakatPickHawlHelp => 'Fecha en que alcanzaste el nisab';

  @override
  String zakatSummaryShare(
    Object cur,
    Object due,
    Object nisabType,
    Object nisabVal,
    Object total,
  ) {
    return 'Zakat — Boshra\nBienes sujetos a Zakat: $total $cur\nNisab ($nisabType): $nisabVal $cur\nZakat debida (2,5%): $due $cur';
  }

  @override
  String get trackerTitle => 'Seguimiento de oraciones';

  @override
  String get trackerTimeNotStarted =>
      'Aún no ha entrado la hora de esta oración 🌙';

  @override
  String get trackerLearningHabits => '🧠 Aprendiendo tus hábitos';

  @override
  String get trackerLearningDesc =>
      'Registra tus oraciones durante al menos 5 días y te sugeriremos mejoras personalizadas (análisis solo en tu dispositivo).';

  @override
  String trackerFajrSlips(Object days, Object missed) {
    return '🌅 Se te pasa el Fáyr: $missed de los últimos $days días';
  }

  @override
  String trackerSleepReminderActive(Object time) {
    return 'Tu recordatorio de acostarte temprano está activo a las $time cada noche 🌿';
  }

  @override
  String get trackerSleepReminderSuggest =>
      'Perderse el Fáyr suele deberse a trasnochar. ¿Deseas un recordatorio nocturno para dormir temprano?';

  @override
  String trackerTurnOnTime(Object time) {
    return 'Activar ($time)';
  }

  @override
  String get trackerNotNow => 'Ahora no';

  @override
  String get trackerChangeTime => 'Cambiar hora';

  @override
  String get trackerTurnOff => 'Desactivar';

  @override
  String get trackerPickAnotherTime => 'Elegir otra hora';

  @override
  String trackerPrayerNearEnd(Object prayer) {
    return '⏰ $prayer suele rezarse cerca del final de su hora';
  }

  @override
  String trackerPrayerNearEndDesc(Object prayer) {
    return 'El recordatorio suave para $prayer llegará antes (a mitad del tiempo).';
  }

  @override
  String get trackerGreatConsistency => '✨ Excelente constancia';

  @override
  String trackerWeakestPrayer(Object prayer) {
    return '🌿 Oración que más descuidas: $prayer';
  }

  @override
  String get trackerNoPrayerSlipping =>
      'Ninguna oración se te escapa habitualmente. ¡Sigue así!';

  @override
  String trackerPrayerMissedCount(Object days, Object missed) {
    return 'Perdida $missed veces en los últimos $days días. El recordatorio suave te ayudará.';
  }

  @override
  String get trackerTurnOffNudge => 'Desactivar recordatorio suave';

  @override
  String get trackerTurnOnNudge => 'Activar recordatorio suave';

  @override
  String get trackerStopLearning => 'Dejar de aprender mis hábitos';

  @override
  String get trackerStartLearning => 'Aprender mis hábitos';

  @override
  String get trackerStartStreakToday => 'Empieza tu racha hoy';

  @override
  String trackerStreakDays(Object count) {
    return 'Racha de $count días, las cinco oraciones';
  }

  @override
  String trackerBestStreakStats(Object best, Object pct) {
    return 'Mejor racha: $best — esta semana: $pct%';
  }

  @override
  String get trackerToday => 'Hoy';

  @override
  String get trackerYesterday => 'Ayer';

  @override
  String get trackerYourGarden => 'Tu jardín 🌳';

  @override
  String get trackerGardenDesc =>
      'Cada oración tiene un árbol que crece cada día que eres constante';

  @override
  String get trackerDayUnit => 'd';

  @override
  String get trackerTodayPrayers => 'Oraciones de hoy';

  @override
  String trackerPrayersOnDate(Object date) {
    return 'Oraciones del $date';
  }

  @override
  String get trackerPrayedMark => 'Rezată ✓';

  @override
  String get trackerNotMarked => 'No marcada';

  @override
  String get trackerThisWeek => 'Esta semana';

  @override
  String trackerTotalPrayedCount(Object count) {
    return 'Total registrado: $count oraciones';
  }

  @override
  String get gardenTitle => 'Mi jardín';

  @override
  String get gardenHomeCardTitle => 'Tu jardín de oraciones 🌳';

  @override
  String get gardenEnterFull => 'Entrar a tu jardín completo 🌿';

  @override
  String get gardenTooEarlySeed => 'Demasiado pronto… la semilla espera 🌱';

  @override
  String get gardenChooseMonth => 'Elegir el mes';

  @override
  String get gardenOf => 'Jardín de';

  @override
  String get gardenHijriSuffix => 'H';

  @override
  String gardenPerfectDaysCount(Object count) {
    return '$count días perfectos';
  }

  @override
  String gardenBestStreakCount(Object count) {
    return 'Mejor racha $count';
  }

  @override
  String get gardenBlessedForest => 'Un bosque bendito';

  @override
  String gardenWeekNumber(Object num) {
    return 'Semana $num';
  }

  @override
  String get gardenMsgFlourishing =>
      '¡Masha Allah! Un jardín floreciente 🌳🌳🌳';

  @override
  String get gardenMsgKeepGoing =>
      'Un hermoso jardín — sigue así y se convertirá en un bosque 🌿';

  @override
  String get gardenMsgWaterToday =>
      'Cada oración riega un árbol. Empieza hoy 💧';

  @override
  String get gardenMsgWaitingFirst =>
      'El jardín espera… tu primera oración planta el primer árbol 🌱';

  @override
  String plantStatusPrayedAt(Object time) {
    return 'Rezată ✓ a las $time';
  }

  @override
  String get plantStatusPrayed => 'Rezată ✓';

  @override
  String get plantStatusPending => 'Ya es su hora — aún no registrada 💧';

  @override
  String get plantStatusMissed => 'No registrada — el árbol necesita agua';

  @override
  String get plantStatusUpcoming => 'Aún no es la hora 🌱';

  @override
  String plantStreakFruit(Object prayer, Object streak) {
    return '¡Árbol frutal! $streak días seguidos en $prayer 🍎';
  }

  @override
  String plantStreakWeekPlus(Object prayer, Object streak) {
    return '$streak días seguidos en $prayer 🔥';
  }

  @override
  String plantStreakDayNum(Object prayer, Object streak) {
    return 'Día $streak de tu racha en $prayer';
  }

  @override
  String get plantWaterConsistency =>
      'Cada oración hace crecer el árbol — tu constancia es su agua 💧';

  @override
  String get plantUndo => 'Deshacer';

  @override
  String get plantWaterAction => 'La he rezado — regar el árbol 💧';

  @override
  String get plantStageSeed => 'Semilla';

  @override
  String get plantStageSprout => 'Brote';

  @override
  String get plantStageSapling => 'Plántula';

  @override
  String get plantStageYoungTree => 'Árbol joven';

  @override
  String get plantStageTree => 'Árbol';

  @override
  String get plantStageFruitTree => 'Árbol frutal';

  @override
  String get treeCherryBlossom => 'Cerezo en flor';

  @override
  String get treeDatePalm => 'Palmera datilera';

  @override
  String get treeOrangeTree => 'Naranjo';

  @override
  String get treePomegranate => 'Granado';

  @override
  String get treeCypress => 'Ciprés';

  @override
  String get weeklySummaryTitle => 'Resumen semanal';

  @override
  String get weeklyShareAsImage => 'Compartir como imagen';

  @override
  String get weeklyNoPrayersLogged =>
      'Aún no has registrado oraciones esta semana. Comienza desde tu jardín en el inicio 🌱';

  @override
  String get weeklyShareYourTree => 'Comparte tu árbol semanal';

  @override
  String get weeklyNotificationHint =>
      'Cada viernes después de Isha recibes una notificación con tu resumen semanal.';

  @override
  String get weeklyImageError =>
      'No se pudo generar la imagen, inténtalo de nuevo';

  @override
  String get weeklyCardTitle => 'Mi resumen semanal';

  @override
  String get weeklyCardTreeSubtitle => 'Mi árbol de oraciones esta semana 🌳';

  @override
  String weeklyCardPercentLogged(Object pct) {
    return '$pct% de mis oraciones cumplidas a tiempo';
  }

  @override
  String weeklyCardStrongest(Object prayer) {
    return 'Oración más constante: $prayer';
  }

  @override
  String weeklyCardWeakest(Object prayer) {
    return 'Menos constante: $prayer';
  }

  @override
  String weeklyCardStreak(Object count) {
    return '🔥 Racha de $count días, todas las oraciones';
  }

  @override
  String get weeklyCardAppBranding => 'Boshra — Adhán, Súplicas y Corán';

  @override
  String weeklySentencePrayed(Object max, Object total) {
    return 'Has rezado $total de $max';
  }

  @override
  String weeklySentenceStrongest(Object prayer) {
    return 'tu más constante: $prayer';
  }

  @override
  String weeklySentenceWeakest(Object prayer) {
    return 'y la menos constante: $prayer';
  }

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';
}
