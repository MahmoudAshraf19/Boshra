import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/config/maps_config.dart';
import '../../../../core/services/places_service.dart';

/// Search-as-you-type for any place on Earth (Google Places), with a built-in cities fallback
/// when offline. Shows its results right under the field.
class PlaceSearchBox extends StatefulWidget {
  final ValueChanged<PickedPlace> onPicked;
  final ValueChanged<bool>? onActiveChanged;
  final double? biasLat;
  final double? biasLng;
  final bool autofocus;
  final int maxResultsHeight;

  const PlaceSearchBox({
    super.key,
    required this.onPicked,
    this.onActiveChanged,
    this.biasLat,
    this.biasLng,
    this.autofocus = false,
    this.maxResultsHeight = 320,
  });

  @override
  State<PlaceSearchBox> createState() => _PlaceSearchBoxState();
}

class _PlaceSearchBoxState extends State<PlaceSearchBox> {
  final _c = TextEditingController();
  final _service = PlacesService.instance;
  Timer? _debounce;
  late String _session = _service.newSessionToken();
  List<PlaceSuggestion> _results = const [];
  bool _loading = false;
  bool _searched = false;
  bool _active = false;
  int _seq = 0;

  String get _lang => Localizations.localeOf(context).languageCode == 'ar' ? 'ar' : Localizations.localeOf(context).languageCode;
  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void dispose() {
    _debounce?.cancel();
    _c.dispose();
    super.dispose();
  }

  void _setActive(bool v) {
    if (_active == v) return;
    _active = v;
    widget.onActiveChanged?.call(v);
  }

  void _onChanged(String v) {
    _debounce?.cancel();
    final q = v.trim();
    if (q.length < 2) {
      _seq++;
      setState(() {
        _results = const [];
        _loading = false;
        _searched = false;
      });
      _setActive(false);
      return;
    }
    _setActive(true);
    setState(() => _loading = true);
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(q));
  }

  Future<void> _search(String q) async {
    final my = ++_seq;
    final r = await _service.autocomplete(
      q,
      lang: _lang,
      sessionToken: _session,
      biasLat: widget.biasLat,
      biasLng: widget.biasLng,
    );
    if (!mounted || my != _seq) return; // a newer query is already running
    setState(() {
      _results = r;
      _loading = false;
      _searched = true;
    });
  }

  Future<void> _pick(PlaceSuggestion s) async {
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    final place = await _service.details(s, lang: _lang, sessionToken: _session);
    _session = _service.newSessionToken(); // the billing session ends with the details call
    if (!mounted) return;
    setState(() => _loading = false);
    if (place == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('تعذّر تحديد هذا المكان، جرّب غيره', 'Could not locate that place, try another'))));
      return;
    }
    await _service.addRecent(place);
    widget.onPicked(place);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
      TextField(
        controller: _c,
        autofocus: widget.autofocus,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _loading
              ? const Padding(padding: EdgeInsets.all(12), child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)))
              : (_c.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        _c.clear();
                        _onChanged('');
                      },
                    )),
          hintText: t('ابحث عن مدينة أو حي أو عنوان…', 'Search a city, neighbourhood or address…'),
          filled: true,
          fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.6),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          isDense: true,
        ),
      ),
      if (_active && (_results.isNotEmpty || (_searched && !_loading)))
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxResultsHeight.toDouble()),
          child: _results.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(t('لا نتائج لـ «${_c.text.trim()}»', 'No results for "${_c.text.trim()}"'),
                      style: TextStyle(color: cs.onSurfaceVariant)),
                )
              : Column(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 6),
                      itemCount: _results.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final s = _results[i];
                        return ListTile(
                          dense: true,
                          leading: Icon(s.resolved != null && s.placeId == null ? Icons.location_city_rounded : Icons.place_rounded, color: cs.primary),
                          title: Text(s.primary, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: s.secondary.isEmpty ? null : Text(s.secondary, maxLines: 1, overflow: TextOverflow.ellipsis),
                          onTap: () => _pick(s),
                        );
                      },
                    ),
                  ),
                  if (MapsConfig.enabled)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('Powered by Google', style: TextStyle(fontSize: 10.5, color: cs.onSurfaceVariant)),
                    ),
                ]),
        ),
    ]);
  }
}
