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
  String get live => 'Live';

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
  String get quranMessageNotificationTitle => 'Mensaje del Corán 🌿';

  @override
  String get saveBookmark => 'Guardar Marcador';

  @override
  String bookmarkSavedSuccessfully(String surahName, String ayahNumber) {
    return 'Marcador guardado en Sura $surahName Aleya $ayahNumber';
  }
}
