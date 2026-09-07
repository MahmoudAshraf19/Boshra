import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    if (kIsWeb) return; // Web notifications aren't fully supported for offline exact alarms

    // Initialize timezone data
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const WebInitializationSettings initializationSettingsWeb =
        WebInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
      web: initializationSettingsWeb,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );
    
    _isInitialized = true;
  }

  Future<void> requestPermissions() async {
    if (kIsWeb) return;
    
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
      await androidImplementation?.requestExactAlarmsPermission();
    }
  }

  Future<void> scheduleDailyAzkarNotifications(AppLocalizations l10n) async {
    if (kIsWeb) return; // Web doesn't support offline exact background alarms via this plugin

    // Morning Azkar (9:00 AM)
    await _scheduleDailyNotification(
      id: 1,
      title: l10n.morningAzkarNotificationTitle,
      body: l10n.morningAzkarNotificationBody,
      hour: 9,
      minute: 0,
    );

    // Evening Azkar (7:00 PM)
    await _scheduleDailyNotification(
      id: 2,
      title: l10n.eveningAzkarNotificationTitle,
      body: l10n.eveningAzkarNotificationBody,
      hour: 19,
      minute: 0,
    );
  }

  Future<void> scheduleDailyQuranMessage(AppLocalizations l10n) async {
    if (kIsWeb) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/boshra_120_quran_verses.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> verses = jsonData['verses'];
      
      final random = Random();
      
      final now = tz.TZDateTime.now(tz.local);
      
      for (int i = 0; i < 30; i++) {
        final verseIndex = random.nextInt(verses.length);
        final verseText = verses[verseIndex]['text'] as String;
        
        var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9, 0);
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }
        scheduledDate = scheduledDate.add(Duration(days: i));

        await flutterLocalNotificationsPlugin.zonedSchedule(
          id: 100 + i, // Use IDs from 100 to 129
          title: l10n.quranMessageNotificationTitle,
          body: verseText,
          scheduledDate: scheduledDate,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'quran_messages_channel_v3',
              'Quran Messages',
              channelDescription: 'Daily message from the Quran',
              importance: Importance.high,
              priority: Priority.high,
              sound: RawResourceAndroidNotificationSound('notification'),
              playSound: true,
            ),
            iOS: DarwinNotificationDetails(
              sound: 'notification.mp3',
              presentSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }
    } catch (e) {
      print('Error scheduling daily Quran messages: $e');
    }
  }

  Future<void> _scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_azkar_channel_v3',
      'Daily Azkar Notifications',
      channelDescription: 'Notifications for morning and evening Azkar',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification'),
      playSound: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      sound: 'notification.mp3',
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  Future<void> testNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'test_channel_v3',
      'Test Notifications',
      channelDescription: 'Channel for testing notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification'),
      playSound: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      sound: 'notification.mp3',
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id: 999,
      title: 'إشعار تجريبي 🔔',
      body: 'هذا إشعار للتأكد من عمل الصوت والإشعارات بشكل صحيح!',
      notificationDetails: platformChannelSpecifics,
    );
  }
}
