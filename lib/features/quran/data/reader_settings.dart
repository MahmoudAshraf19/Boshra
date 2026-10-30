import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User-adjustable reading preferences (persisted).
class ReaderSettings {
  ReaderSettings._();
  static const double minFont = 22;
  static const double maxFont = 44;
  static final ValueNotifier<double> fontSize = ValueNotifier<double>(28);
  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final p = await SharedPreferences.getInstance();
      fontSize.value = (p.getDouble('reader_font_size') ?? 28).clamp(minFont, maxFont);
    } catch (_) {}
  }

  static Future<void> setFontSize(double v) async {
    fontSize.value = v.clamp(minFont, maxFont);
    try {
      final p = await SharedPreferences.getInstance();
      await p.setDouble('reader_font_size', fontSize.value);
    } catch (_) {}
  }
}
