import 'package:flutter/material.dart';
import '../../../../core/data/known_cities.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/places_service.dart';
import '../../../../core/services/telemetry.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../data/repositories/prayer_repository.dart';
import '../screens/map_picker_screen.dart';
import 'place_search_box.dart';

/// Choose where the prayer times are calculated: search ANY place (Google Places), pick it on the
/// map, use a recent place, a quick city, or go back to automatic GPS. Applies the change
/// everywhere (Home + notifications). The class name is kept so every existing call site works.
class CityPickerSheet extends StatefulWidget {
  const CityPickerSheet({super.key});

  /// Returns true when something changed.
  static Future<bool> show(BuildContext context) async {
    final r = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => FractionallySizedBox(heightFactor: 0.94, child: const CityPickerSheet()),
    );
    return r ?? false;
  }

  /// Applies a location change app-wide.
  static Future<void> applyEverywhere() async {
    PrayerRepository.invalidateLocation();
    await HomeController.instance?.refreshData();
    await NotificationCoordinator.instance.rescheduleAll(force: true);
  }

  /// Saves [place] as the manual location and refreshes everything.
  static Future<void> choose(PickedPlace place) async {
    await LocationService().setManualPlace(place.lat, place.lng, place.name);
    await PlacesService.instance.addRecent(place);
    Telemetry.log('location_picked');
    await applyEverywhere();
  }

  @override
  State<CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<CityPickerSheet> {
  bool _manual = false;
  bool _typing = false;
  bool _busy = false;
  List<PickedPlace> _recents = const [];
  double? _lat;
  double? _lng;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    LocationService().isManual().then((v) {
      if (mounted) setState(() => _manual = v);
    });
    PlacesService.instance.recents().then((v) {
      if (mounted) setState(() => _recents = v);
    });
    LocationService().resolve(allowGps: false).then((r) {
      if (mounted) setState(() {
            _lat = r.lat;
            _lng = r.lng;
          });
    });
  }

  Future<void> _apply(PickedPlace p) async {
    setState(() => _busy = true);
    await CityPickerSheet.choose(p);
    if (mounted) Navigator.pop(context, true);
  }

  Future<void> _openMap() async {
    final p = await Navigator.push<PickedPlace>(
      context,
      MaterialPageRoute(builder: (_) => MapPickerScreen(initialLat: _lat, initialLng: _lng), fullscreenDialog: true),
    );
    if (p != null) await _apply(p);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Text(t('أين تحسب مواعيد الصلاة؟', 'Where should prayer times be calculated?'),
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(t('ابحث عن أي مدينة أو حي أو عنوان في العالم، أو اختره من الخريطة.',
                'Search any city, neighbourhood or address in the world, or pick it on the map.'),
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 12),
            PlaceSearchBox(
              biasLat: _lat,
              biasLng: _lng,
              maxResultsHeight: 420,
              onActiveChanged: (v) => setState(() => _typing = v),
              onPicked: _apply,
            ),
            if (!_typing) ...[
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: _openMap,
                icon: const Icon(Icons.map_rounded),
                label: Text(t('اختيار من الخريطة', 'Pick on the map')),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              ),
              if (_manual)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      setState(() => _busy = true);
                      await LocationService().clearManualCity();
                      await CityPickerSheet.applyEverywhere();
                      if (context.mounted) Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.my_location_rounded),
                    label: Text(t('استخدام موقعي تلقائيًا (GPS)', 'Use my location automatically (GPS)')),
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  ),
                ),
              if (_recents.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(t('أماكن أخيرة', 'Recent places'), style: const TextStyle(fontWeight: FontWeight.bold)),
                for (final p in _recents)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.history_rounded, color: cs.primary),
                    title: Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    onTap: () => _apply(p),
                  ),
              ],
              const SizedBox(height: 18),
              Text(t('مدن سريعة', 'Quick cities'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 4, children: [
                for (final c in KnownCities.all.take(16))
                  ActionChip(
                    label: Text(c.name(_ar).split(RegExp(r'[،,]')).first.trim()),
                    onPressed: () => _apply(PickedPlace(c.lat, c.lng, c.name(_ar))),
                  ),
              ]),
            ],
          ],
        ),
        if (_busy)
          Positioned.fill(
            child: ColoredBox(
              color: cs.surface.withValues(alpha: 0.7),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ]),
    );
  }
}
