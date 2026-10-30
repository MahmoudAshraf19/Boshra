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
}
