import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:ui';
import '../../../core/services/notification_service.dart';
import '../data/repositories/prayer_repository.dart';
import '../data/models/prayer_times_model.dart';
import 'prayer_settings.dart';

class PrayerSchedulerService {
  final NotificationService _notificationService = NotificationService();
  final PrayerRepository _prayerRepository = PrayerRepository();

  Future<void> schedulePrayersForNextDays(int days) async {
    if (kIsWeb) return; // Not supported on web

    await _notificationService.flutterLocalNotificationsPlugin.cancelAll();
    
    final settings = await PrayerSettings.load();
    final now = DateTime.now();

    for (int i = 0; i < days; i++) {
      final date = now.add(Duration(days: i));
      final prayerTimesModel = await _prayerRepository.getPrayerTimesForDate(date);
      
      if (prayerTimesModel != null) {
        await _scheduleDayPrayers(date, prayerTimesModel, settings);
      }
    }
  }

  Future<void> scheduleTestNotification(String langCode) async {
    final now = DateTime.now().add(const Duration(seconds: 10));
    final settings = await PrayerSettings.load();
    await _schedulePrayer(999999, 'Test / اختبار', now, settings, 'adhan', langCode);
  }

  Future<void> _scheduleDayPrayers(DateTime date, PrayerTimesModel model, PrayerSettings settings) async {
    final int dayBaseId = date.year * 10000 + date.month * 100 + date.day;
    final timings = model.timings;
    
    // Parse times
    final fajrTime = _parseTime(date, timings.fajr);
    final dhuhrTime = _parseTime(date, timings.dhuhr);
    final asrTime = _parseTime(date, timings.asr);
    final maghribTime = _parseTime(date, timings.maghrib);
    final ishaTime = _parseTime(date, timings.isha);

    final langCode = PlatformDispatcher.instance.locale.languageCode;
    
    String getPrayerName(String key) {
      if (langCode == 'ar') {
        switch (key) {
          case 'Fajr': return 'الفجر';
          case 'Dhuhr': return 'الظهر';
          case 'Asr': return 'العصر';
          case 'Maghrib': return 'المغرب';
          case 'Isha': return 'العشاء';
        }
      }
      return key; // Default to English/API names
    }

    if (settings.enabledFajr && fajrTime != null) {
      await _schedulePrayer(dayBaseId + 1, getPrayerName('Fajr'), fajrTime, settings, settings.fajrSound, langCode);
    }
    if (settings.enabledDhuhr && dhuhrTime != null) {
      await _schedulePrayer(dayBaseId + 2, getPrayerName('Dhuhr'), dhuhrTime, settings, settings.dhuhrSound, langCode);
    }
    if (settings.enabledAsr && asrTime != null) {
      await _schedulePrayer(dayBaseId + 3, getPrayerName('Asr'), asrTime, settings, settings.asrSound, langCode);
    }
    if (settings.enabledMaghrib && maghribTime != null) {
      await _schedulePrayer(dayBaseId + 4, getPrayerName('Maghrib'), maghribTime, settings, settings.maghribSound, langCode);
    }
    if (settings.enabledIsha && ishaTime != null) {
      await _schedulePrayer(dayBaseId + 5, getPrayerName('Isha'), ishaTime, settings, settings.ishaSound, langCode);
    }
  }

  Future<void> _schedulePrayer(int baseId, String prayerName, DateTime time, PrayerSettings settings, String soundType, String langCode) async {
    String title = langCode == 'ar' ? 'حان الآن موعد صلاة $prayerName' : 'It is time for $prayerName prayer';
    String body = langCode == 'ar' ? 'حي على الصلاة' : 'Hasten to the prayer';
    
    await _scheduleSingleNotification(
      id: baseId,
      title: title,
      body: body,
      time: time,
      soundType: soundType,
    );
    
    if (settings.beforePrayerMinutes > 0) {
      String preTitle = langCode == 'ar' ? 'صلاة $prayerName' : '$prayerName Prayer';
      String preBody = langCode == 'ar' 
          ? 'باقي ${settings.beforePrayerMinutes} دقيقة على الأذان'
          : '${settings.beforePrayerMinutes} minutes left until Adhan';
          
      await _scheduleSingleNotification(
        id: baseId + 100,
        title: preTitle,
        body: preBody,
        time: time.subtract(Duration(minutes: settings.beforePrayerMinutes)),
        soundType: 'short', // pre-prayer alert is always short beep
      );
    }
  }

  DateTime? _parseTime(DateTime date, String timeString) {
    try {
      final cleanTime = timeString.split(' ')[0]; // "04:58"
      final parts = cleanTime.split(':');
      if (parts.length == 2) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      }
    } catch (e) {
      print('Error parsing time: $e');
    }
    return null;
  }

  Future<void> _scheduleSingleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
    required String soundType,
  }) async {
    if (time.isBefore(DateTime.now())) return;

    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(time, tz.local);

    AndroidNotificationDetails androidDetails;
    DarwinNotificationDetails iOSDetails;

    if (soundType == 'adhan') {
      androidDetails = const AndroidNotificationDetails(
        'adhan_channel_v1',
        'Adhan Notifications',
        channelDescription: 'Full Adhan sound for prayers',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('adhan'),
        playSound: true,
        audioAttributesUsage: AudioAttributesUsage.alarm,
      );
      iOSDetails = const DarwinNotificationDetails(
        sound: 'adhan.mp3',
        presentSound: true,
      );
    } else if (soundType == 'short') {
      androidDetails = const AndroidNotificationDetails(
        'notification_channel_v1',
        'Standard Notifications',
        channelDescription: 'Standard beep for prayers and alerts',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notification'),
        playSound: true,
      );
      iOSDetails = const DarwinNotificationDetails(
        sound: 'notification.mp3',
        presentSound: true,
      );
    } else { // silent
      androidDetails = const AndroidNotificationDetails(
        'silent_channel_v1',
        'Silent Notifications',
        channelDescription: 'Silent notifications for prayers',
        importance: Importance.max,
        priority: Priority.high,
        playSound: false,
        enableVibration: true,
      );
      iOSDetails = const DarwinNotificationDetails(
        presentSound: false,
      );
    }

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    try {
      await _notificationService.flutterLocalNotificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      print('🔥 Failed to schedule exact alarm: $e. Falling back to inexact.');
      // Fallback for Android 14+ if exact alarm permission is denied
      try {
        await _notificationService.flutterLocalNotificationsPlugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: platformChannelSpecifics,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      } catch (fallbackError) {
        print('🔥 Fallback also failed: $fallbackError');
      }
    }
  }
}
