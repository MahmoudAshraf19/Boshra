import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' show LocationPermission;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/data/known_cities.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/places_service.dart';
import '../widgets/map_styles.dart';
import '../widgets/place_search_box.dart';

/// Pick the prayer-times location on a map styled like the app: search at the top, a centre pin
/// you move by dragging the map, the place name resolved live, and a "my location" button.
/// Returns a [PickedPlace] (or null if cancelled).
class MapPickerScreen extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;
  const MapPickerScreen({super.key, this.initialLat, this.initialLng});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _ctl;
  LatLng _center = const LatLng(30.0444, 31.2357);
  bool _ready = false;
  bool _moving = false;
  bool _locating = false;
  bool _gpsAllowed = false;
  String? _name;
  bool _resolving = false;
  Timer? _debounce;
  int _seq = 0;
  final Map<String, String> _nameCache = {};

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;
  String get _lang => Localizations.localeOf(context).languageCode == 'ar' ? 'ar' : Localizations.localeOf(context).languageCode;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _ctl?.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    double? lat = widget.initialLat, lng = widget.initialLng;
    if (lat == null || lng == null) {
      final r = await LocationService().resolve(allowGps: false);
      lat = r.lat;
      lng = r.lng;
    }
    final st = await LocationService().status();
    if (!mounted) return;
    setState(() {
      _center = LatLng(lat!, lng!);
      _gpsAllowed = st.serviceOn &&
          (st.permission == LocationPermission.whileInUse || st.permission == LocationPermission.always);
      _ready = true;
    });
    _resolveName();
  }

  String _key(LatLng p) => '${p.latitude.toStringAsFixed(3)},${p.longitude.toStringAsFixed(3)}';

  void _scheduleResolve() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _resolveName);
  }

  Future<void> _resolveName() async {
    final p = _center;
    final k = _key(p);
    if (_nameCache.containsKey(k)) {
      setState(() => _name = _nameCache[k]);
      return;
    }
    final my = ++_seq;
    setState(() => _resolving = true);
    var name = await PlacesService.instance.reverse(p.latitude, p.longitude, lang: _lang);
    name ??= _nearestKnown(p);
    if (!mounted || my != _seq) return;
    if (name != null) _nameCache[k] = name;
    setState(() {
      _name = name;
      _resolving = false;
    });
  }

  String? _nearestKnown(LatLng p) {
    KnownCity? best;
    var bd = 80.0;
    for (final c in KnownCities.all) {
      final d = LocationService.distanceKm(p.latitude, p.longitude, c.lat, c.lng);
      if (d < bd) {
        bd = d;
        best = c;
      }
    }
    return best?.name(_ar);
  }

  Future<void> _goTo(double lat, double lng, {double zoom = 14, String? name}) async {
    final p = LatLng(lat, lng);
    setState(() {
      _center = p;
      if (name != null) {
        _name = name;
        _nameCache[_key(p)] = name;
      }
    });
    await _ctl?.animateCamera(CameraUpdate.newLatLngZoom(p, zoom));
  }

  Future<void> _myLocation() async {
    setState(() => _locating = true);
    final r = await LocationService().resolve(allowGps: true, requestPermission: true, timeout: const Duration(seconds: 12));
    if (!mounted) return;
    setState(() {
      _locating = false;
      _gpsAllowed = r.isReal;
    });
    if (r.isReal) {
      await _goTo(r.lat, r.lng, zoom: 15);
      _resolveName();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('تعذّر تحديد موقعك الحالي', 'Could not get your current location'))));
    }
  }

  void _confirm() {
    final name = _name ?? '${_center.latitude.toStringAsFixed(4)}, ${_center.longitude.toStringAsFixed(4)}';
    Navigator.pop(context, PickedPlace(_center.latitude, _center.longitude, name));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final media = MediaQuery.of(context);

    return Scaffold(
      body: !_ready
          ? const Center(child: CircularProgressIndicator())
          : Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target: _center, zoom: 12.5),
                style: dark ? kDarkMapStyle : kLightMapStyle,
                onMapCreated: (c) => _ctl = c,
                onCameraMoveStarted: () => setState(() => _moving = true),
                onCameraMove: (pos) => _center = pos.target,
                onCameraIdle: () {
                  setState(() => _moving = false);
                  _scheduleResolve();
                },
                myLocationEnabled: _gpsAllowed,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                buildingsEnabled: false,
                padding: EdgeInsets.only(bottom: 200 + media.padding.bottom, top: 100),
              ),
              // centre pin (lifts while the map moves)
              IgnorePointer(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100 + media.padding.bottom / 2 + (_moving ? 22 : 0) + 22),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.location_on_rounded, size: 54, color: cs.primary, shadows: const [Shadow(blurRadius: 6, color: Colors.black38)]),
                    ]),
                  ),
                ),
              ),
              // top: back + search
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(20),
                    color: cs.surface,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
                        Expanded(
                          child: PlaceSearchBox(
                            biasLat: _center.latitude,
                            biasLng: _center.longitude,
                            maxResultsHeight: 300,
                            onPicked: (p) => _goTo(p.lat, p.lng, zoom: 14, name: p.name),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              // my-location button
              Positioned(
                right: 16,
                bottom: 190 + media.padding.bottom,
                child: FloatingActionButton.small(
                  heroTag: 'my_loc',
                  onPressed: _locating ? null : _myLocation,
                  child: _locating
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.my_location_rounded),
                ),
              ),
              // bottom card
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + media.padding.bottom),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                    boxShadow: const [BoxShadow(blurRadius: 18, color: Colors.black26)],
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t('موقع مواعيد الصلاة', 'Prayer-times location'), style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12.5)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Expanded(
                        child: Text(
                          _resolving ? t('جارٍ تحديد الاسم…', 'Finding the name…') : (_name ?? t('موقع على الخريطة', 'Point on the map')),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 2),
                    Text('${_center.latitude.toStringAsFixed(4)}, ${_center.longitude.toStringAsFixed(4)}',
                        textDirection: TextDirection.ltr, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _moving ? null : _confirm,
                        icon: const Icon(Icons.check_rounded),
                        label: Text(t('تأكيد هذا الموقع', 'Confirm this location'), style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
    );
  }
}
