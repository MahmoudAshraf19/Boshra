import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

import 'core/services/notification_service.dart';

import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'features/azkar/presentation/providers/azkar_provider.dart';
import 'features/radio/presentation/providers/radio_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.platform.boshra.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  
  await NotificationService().init();
  
  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AzkarProvider()),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        title: 'Boshra',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Default to light mode
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // Arabic
        Locale('en'), // English
        Locale('fr'), // French
        Locale('es'), // Spanish
        Locale('fa'), // Persian
        Locale('hi'), // Hindi
        Locale('it'), // Italian
        Locale('ur'), // Urdu
      ],
      locale: kIsWeb ? DevicePreview.locale(context) : null, // null allows Flutter to auto-detect system language
      builder: DevicePreview.appBuilder,
      home: const SplashScreen(),
      ),
    );
  }
}
