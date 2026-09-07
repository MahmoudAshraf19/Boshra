import 'dart:io';
import 'dart:convert';

void main() {
  final Map<String, Map<String, String>> translations = {
    'en': {
      'themeLight': 'Light',
      'themeLightDesc': 'Clean warm cream interface',
      'themeDark': 'Dark',
      'themeDarkDesc': 'Deep olive dark interface',
      'themeSystem': 'System',
      'themeSystemDesc': 'Follow device settings',
    },
    'ar': {
      'themeLight': 'فاتح',
      'themeLightDesc': 'واجهة بيضاء دافئة ونظيفة',
      'themeDark': 'داكن',
      'themeDarkDesc': 'واجهة ليلية مريحة للعين',
      'themeSystem': 'النظام',
      'themeSystemDesc': 'متابعة إعدادات الجهاز',
    },
    'es': {
      'themeLight': 'Claro',
      'themeLightDesc': 'Interfaz clara y cálida',
      'themeDark': 'Oscuro',
      'themeDarkDesc': 'Interfaz oscura y profunda',
      'themeSystem': 'Sistema',
      'themeSystemDesc': 'Seguir ajustes del dispositivo',
    },
    'fr': {
      'themeLight': 'Clair',
      'themeLightDesc': 'Interface claire et chaleureuse',
      'themeDark': 'Sombre',
      'themeDarkDesc': 'Interface sombre et profonde',
      'themeSystem': 'Système',
      'themeSystemDesc': 'Suivre les paramètres de l\'appareil',
    },
    'it': {
      'themeLight': 'Chiaro',
      'themeLightDesc': 'Interfaccia chiara e calda',
      'themeDark': 'Scuro',
      'themeDarkDesc': 'Interfaccia scura e profonda',
      'themeSystem': 'Sistema',
      'themeSystemDesc': 'Segui impostazioni dispositivo',
    },
    'fa': {
      'themeLight': 'روشن',
      'themeLightDesc': 'رابط کاربری تمیز و روشن',
      'themeDark': 'تاریک',
      'themeDarkDesc': 'رابط کاربری تاریک و عمیق',
      'themeSystem': 'سیستم',
      'themeSystemDesc': 'پیروی از تنظیمات دستگاه',
    },
    'ur': {
      'themeLight': 'روشن',
      'themeLightDesc': 'صاف اور روشن انٹرفیس',
      'themeDark': 'تاریک',
      'themeDarkDesc': 'گہرا اور تاریک انٹرفیس',
      'themeSystem': 'سسٹم',
      'themeSystemDesc': 'ڈیوائس کی ترتیبات کے مطابق',
    },
    'hi': {
      'themeLight': 'हल्का',
      'themeLightDesc': 'साफ और हल्का इंटरफ़ेस',
      'themeDark': 'गहरा',
      'themeDarkDesc': 'गहरा और आरामदायक इंटरफ़ेस',
      'themeSystem': 'सिस्टम',
      'themeSystemDesc': 'डिवाइस सेटिंग्स का पालन करें',
    },
  };

  final dir = Directory('lib/l10n');
  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));

  for (final file in files) {
    final fileName = file.uri.pathSegments.last;
    final langCode = fileName.replaceAll('app_', '').replaceAll('.arb', '');
    
    if (translations.containsKey(langCode)) {
      final content = file.readAsStringSync();
      final Map<String, dynamic> json = jsonDecode(content);
      
      bool updated = false;
      translations[langCode]!.forEach((key, value) {
        json[key] = value;
        updated = true;
      });
      
      if (updated) {
        final encoder = JsonEncoder.withIndent('  ');
        file.writeAsStringSync(encoder.convert(json));
        print('Updated $langCode with theme translations.');
      }
    }
  }
}
