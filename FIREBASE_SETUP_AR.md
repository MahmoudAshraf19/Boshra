# تفعيل Crashlytics + Analytics (اختياري — 10 دقائق)

التطبيق دلوقتي عنده **سجل أحداث محلي** (`Telemetry`) بيظهر في شاشة "هل الأذان هيشتغل؟" وبيتنسخ مع تقرير الدعم، **بدون أي حزمة جديدة**. عشان تشوف الأعطال والأحداث من كل المستخدمين على Firebase، محتاج الخطوات دي (لأنها بتحتاج `pubspec.yaml` و`google-services.json` الخاصين بمشروعك، وهما مش في الملفات اللي رفعتها).

1. اعمل مشروع على Firebase Console، وأضف تطبيق Android بنفس `applicationId`، ونزّل `google-services.json` في `android/app/`.
2. شغّل: `flutterfire configure` ثم
   `flutter pub add firebase_core firebase_crashlytics firebase_analytics`
3. في `android/settings.gradle.kts` أضف plugins: `com.google.gms.google-services` و`com.google.firebase.crashlytics`، ثم طبّقهم في `android/app/build.gradle.kts`.
4. في `main.dart` بعد `AppErrorHandler.install();` أضف:

```dart
await Firebase.initializeApp();
Telemetry.sink = (name, params) => FirebaseAnalytics.instance.logEvent(
    name: name, parameters: params.map((k, v) => MapEntry(k, v?.toString() ?? '')));
Telemetry.errorSink = (e, s, tag) =>
    FirebaseCrashlytics.instance.recordError(e, s, reason: tag);
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
```

الأحداث اللي بتتسجل تلقائيًا: `app_start`, `schedule_ok / schedule_incomplete / schedule_failed`, `perm_state` (حالة كل الأذونات بعد أي طلب), `onboarding_*`, `notif_preview`, `notif_types_saved`, `diag_test_adhan`, `invite_share`, `invite_code_entered`, `error`. ولا بنسجّل إحداثيات ولا أسماء.
