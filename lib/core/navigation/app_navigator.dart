import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/azkar/presentation/providers/azkar_provider.dart';
import '../../features/azkar/presentation/screens/azkar_details_screen.dart';
import '../../features/tracker/presentation/screens/prayer_garden_screen.dart';
import '../../features/tracker/presentation/screens/prayer_tracker_screen.dart';
import '../../features/tracker/presentation/screens/weekly_summary_screen.dart';
import '../../features/zakat/presentation/screens/zakat_screen.dart';
import '../services/adhan_native_service.dart';
import '../services/telemetry.dart';

/// Root navigator, so a notification tap can open the right screen from anywhere.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

/// Opens the screen a notification asked for.
///   azkar:morning | azkar:evening | azkar:sleep | azkar:after   → that dhikr category
///   weekly   → weekly summary    zakat → zakat calculator    tracker → prayer tracker
///   garden   → the full prayer garden
///
/// Taps that arrive before the main screen is ready (cold start, splash, onboarding) are kept
/// and opened as soon as [markReady] is called.
class AppRoutes {
  AppRoutes._();

  static bool _ready = false;
  static String? _pending;

  /// Called by the main layout once it is on screen: flushes a cold-start route.
  static Future<void> markReady() async {
    _ready = true;
    final cold = await AdhanNativeService.instance.launchRoute();
    final r = _pending ?? cold;
    _pending = null;
    if (r != null && r.isNotEmpty) await handle(r);
  }

  static Future<void> handle(String route) async {
    if (route.isEmpty) return;
    if (!_ready) {
      _pending = route;
      return;
    }
    final nav = appNavigatorKey.currentState;
    final ctx = appNavigatorKey.currentContext;
    if (nav == null || ctx == null) {
      _pending = route;
      return;
    }
    Telemetry.log('notif_route', {'route': route});
    try {
      if (route.startsWith('azkar:')) {
        await _openAzkar(nav, ctx, route.substring(6));
      } else if (route == 'weekly') {
        nav.push(MaterialPageRoute(builder: (_) => const WeeklySummaryScreen()));
      } else if (route == 'zakat') {
        nav.push(MaterialPageRoute(builder: (_) => const ZakatScreen()));
      } else if (route == 'garden') {
        nav.push(MaterialPageRoute(builder: (_) => const PrayerGardenScreen()));
      } else if (route == 'tracker') {
        nav.push(MaterialPageRoute(builder: (_) => const PrayerTrackerScreen()));
      }
    } catch (_) {}
  }

  static Future<void> _openAzkar(NavigatorState nav, BuildContext ctx, String which) async {
    final (ar, en) = switch (which) {
      'morning' => ('أذكار الصباح', 'Morning'),
      'evening' => ('أذكار المساء', 'Evening'),
      'sleep' => ('أذكار النوم', 'Sleep'),
      _ => ('الأذكار بعد السلام من الصلاة', 'Prayer'),
    };
    final provider = Provider.of<AzkarProvider>(ctx, listen: false);
    if (provider.groupedAzkar.isEmpty && !provider.isLoading) {
      await provider.loadAzkar(ctx);
    }
    var key = ar;
    if (!provider.groupedAzkar.containsKey(ar)) {
      final hit = provider.groupedAzkar.keys
          .where((k) => k.toLowerCase().contains(en.toLowerCase()) || k.contains(ar));
      if (hit.isNotEmpty) {
        key = hit.first;
      } else if (provider.groupedAzkar.isNotEmpty) {
        key = provider.groupedAzkar.keys.first;
      }
    }
    nav.push(MaterialPageRoute(builder: (_) => AzkarDetailsScreen(categoryName: key)));
  }
}
