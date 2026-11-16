/// Google Maps Platform configuration.
///
/// The Maps SDK key itself lives in AndroidManifest (placeholder `MAPS_API_KEY`, read from
/// `android/local.properties`). This class is only for the REST calls made from Dart
/// (Places autocomplete / details, Geocoding).
///
/// Production advice (important — an API key inside an app can always be extracted):
///   1. Restrict the Maps SDK key to "Android apps" (package + SHA-1) and to "Maps SDK for Android".
///   2. Use a SECOND key for the REST calls restricted to "Places API (New)" + "Geocoding API"
///      (and set a daily quota / budget alert), passed with
///      `--dart-define=MAPS_REST_KEY=...`. Ideally call Google through your own backend.
///   3. If the REST key is restricted to Android apps, also pass
///      `--dart-define=ANDROID_CERT_SHA1=AABBCC…` (SHA-1 without colons): the requests then
///      send the X-Android-Package / X-Android-Cert headers Google expects.
class MapsConfig {
  MapsConfig._();

  static const String restKey = String.fromEnvironment(
    'MAPS_REST_KEY',
    defaultValue: 'AIzaSyCGQw2-PW8mSiS-3lBxoS9nyWlR3jgIMlg',
  );

  static const String androidPackage = 'com.app.boshra';
  static const String androidCertSha1 = String.fromEnvironment('ANDROID_CERT_SHA1', defaultValue: '');

  static bool get enabled => restKey.isNotEmpty;
}
