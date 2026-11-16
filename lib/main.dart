import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'core/error/error_handler.dart';
import 'core/notifications/background_refresh.dart';
import 'core/notifications/notification_coordinator.dart';
import 'core/providers/locale_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_logger.dart';
import 'core/navigation/app_navigator.dart';
import 'core/services/telemetry.dart';
import 'core/widgets/adhan_banner_host.dart';
import 'features/azkar/presentation/providers/azkar_provider.dart';
import 'features/radio/presentation/providers/radio_provider.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  // Everything runs inside one guarded zone: no uncaught error can leave a white/frozen screen.
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppErrorHandler.install();
    // Every logged error also goes to the local black-box (+ Crashlytics when you plug it in).
    AppLogger.onError = Telemetry.recordError;
    Telemetry.log('app_start');

    // Each start-up step is isolated: a failure in one must never block the app.
    await _safe('JustAudioBackground', () => JustAudioBackground.init(
          androidNotificationChannelId: 'com.app.boshra.channel.audio',
          androidNotificationChannelName: 'Audio playback',
          androidNotificationOngoing: true,
        ));
    await _safe('NotificationService', () => NotificationService().init());
    await _safe('BackgroundRefresh', () => BackgroundRefresh.init());

    WidgetsBinding.instance.addObserver(NotificationLifecycleObserver());

    runApp(DevicePreview(
      // Only for desktop/web debugging – never in a release build.
      enabled: kDebugMode && kIsWeb,
      builder: (context) => const MyApp(),
    ));
  }, (error, stack) => AppLogger.e('Zone', error, stack));
}

Future<void> _safe(String name, Future<void> Function() job) async {
  try {
    await job().timeout(const Duration(seconds: 8));
  } catch (e, s) {
    AppLogger.e('Startup', e, s, '$name failed');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AzkarProvider()),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, localeProvider, themeProvider, child) {
          return MaterialApp(
            onGenerateTitle: (ctx) => AppLocalizations.of(ctx)?.appTitle ?? 'Boshra',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            navigatorKey: appNavigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeProvider.locale,
            // AdhanBannerHost = in-app Adhan banner (above every screen).
            builder: (context, child) =>
                AdhanBannerHost(child: DevicePreview.appBuilder(context, child)),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
