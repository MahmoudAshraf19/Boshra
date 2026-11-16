import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../core/services/location_service.dart';
import 'city_picker_sheet.dart';

/// Step-by-step help for "my phone can't get / gets the wrong location", tailored to the
/// phone's brand (Samsung, Xiaomi, Huawei, Oppo/Vivo/Realme/OnePlus, generic Android).
/// Returns true when the user asks to retry.
class LocationHelpSheet extends StatelessWidget {
  final String? issue;
  const LocationHelpSheet({super.key, this.issue});

  static Future<bool> show(BuildContext context, {String? issue}) async {
    final r = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => LocationHelpSheet(issue: issue),
    );
    return r ?? false;
  }

  List<String> _steps(String brand, bool ar) {
    String t(String a, String e) => ar ? a : e;
    final common = [
      t('تأكد إن «الموقع» مفعّل من شريط الإشعارات.', 'Make sure Location is ON from the quick settings.'),
    ];
    if (brand.contains('samsung')) {
      return [
        ...common,
        t('الإعدادات ← الموقع ← خدمات الموقع ← «تحسين الدقة» وفعّل: البحث عن شبكات Wi-Fi + البحث عن أجهزة Bluetooth.',
            'Settings → Location → Location services → "Improve accuracy": turn on Wi-Fi scanning and Bluetooth scanning.'),
        t('في نفس الصفحة فعّل «دقة الموقع من Google» (Google Location Accuracy).',
            'On the same page turn on "Google Location Accuracy".'),
        t('الإعدادات ← التطبيقات ← بُشرى ← الأذونات ← الموقع: اختر «السماح أثناء استخدام التطبيق» وفعّل «استخدام الموقع الدقيق».',
            'Settings → Apps → Boshra → Permissions → Location: "Allow only while using the app" and turn on "Use precise location".'),
        t('أوقف «توفير الطاقة» مؤقتًا (بيحدّ من الـ GPS)، ثم اضغط «إعادة المحاولة» وانتظر 20 ثانية قرب شباك.',
            'Turn off Power saving (it limits GPS), then tap Retry and wait ~20 s near a window.'),
        t('لو في «موقع وهمي» (Mock location) في خيارات المطوّر، أوقفه.', 'If a Mock location app is set in Developer options, turn it off.'),
      ];
    }
    if (brand.contains('xiaomi') || brand.contains('redmi') || brand.contains('poco')) {
      return [
        ...common,
        t('الإعدادات ← الموقع ← «دقة الموقع من Google» شغّلها.', 'Settings → Location → turn on Google Location Accuracy.'),
        t('الإعدادات ← التطبيقات ← إدارة التطبيقات ← بُشرى ← الأذونات ← الموقع: «السماح أثناء الاستخدام» + الموقع الدقيق.',
            'Settings → Apps → Manage apps → Boshra → Permissions → Location: Allow while using + precise.'),
        t('الإعدادات ← البطارية ← بُشرى ← «بدون قيود».', 'Settings → Battery → Boshra → "No restrictions".'),
      ];
    }
    if (brand.contains('huawei') || brand.contains('honor')) {
      return [
        ...common,
        t('جهازك على الأغلب بدون خدمات Google، فبنستخدم مدير الموقع الأصلي. فعّل: الإعدادات ← الموقع ← متقدم ← «تحسين دقة الموقع».',
            'Your phone likely has no Google services, so we use the system location manager. Enable Settings → Location → Advanced → improve accuracy.'),
        t('اسمح للتطبيق بالموقع «دائمًا أو أثناء الاستخدام» من إذن التطبيق.', 'Allow the app location "always / while in use".'),
      ];
    }
    if (brand.contains('oppo') || brand.contains('realme') || brand.contains('vivo') || brand.contains('oneplus')) {
      return [
        ...common,
        t('الإعدادات ← الموقع ← «دقة الموقع من Google» شغّلها.', 'Settings → Location → turn on Google Location Accuracy.'),
        t('الإعدادات ← إدارة التطبيقات ← بُشرى ← الأذونات ← الموقع: «أثناء الاستخدام» + الموقع الدقيق.',
            'Settings → App management → Boshra → Permissions → Location: while using + precise.'),
        t('الإعدادات ← البطارية ← بُشرى ← اسمح بالنشاط في الخلفية.', 'Settings → Battery → Boshra → allow background activity.'),
      ];
    }
    return [
      ...common,
      t('الإعدادات ← الموقع ← «دقة الموقع من Google» شغّلها.', 'Settings → Location → turn on Google Location Accuracy.'),
      t('إذن التطبيق ← الموقع: «أثناء الاستخدام» + الموقع الدقيق.', 'App permission → Location: while using + precise.'),
    ];
  }

  String _headline(bool ar) {
    switch (issue) {
      case 'service_off':
        return ar ? 'خدمة الموقع (GPS) مقفولة' : 'Location service (GPS) is off';
      case 'permission_denied':
      case 'permission_forever':
        return ar ? 'إذن الموقع مش مسموح' : 'Location permission is not granted';
      case 'mock_location':
        return ar ? 'الجهاز بيستخدم موقع وهمي' : 'The phone is using a mock location';
      case 'tz_mismatch':
        return ar ? 'الموقع متعارض مع المنطقة الزمنية للجهاز' : 'Location contradicts the device time zone';
      default:
        return ar ? 'الجهاز ما قدرش يحدد موقعك بدقة' : 'The phone could not get an accurate fix';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final cs = Theme.of(context).colorScheme;
    return FutureBuilder<String>(
      future: PermissionCenter.brand(),
      builder: (context, snap) {
        final steps = _steps(snap.data ?? '', ar);
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Text(_headline(ar), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              ar ? 'جرّب الخطوات دي بالترتيب (بتحل 95% من الحالات):' : 'Try these steps in order (fixes ~95% of cases):',
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            for (var i = 0; i < steps.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CircleAvatar(radius: 12, backgroundColor: cs.primary, child: Text('${i + 1}', style: TextStyle(color: cs.onPrimary, fontSize: 12))),
                  const SizedBox(width: 10),
                  Expanded(child: Text(steps[i], style: const TextStyle(height: 1.5))),
                ]),
              ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => LocationService().openAccuracySettings(),
              icon: const Icon(Icons.location_searching_rounded),
              label: Text(ar ? 'فتح إعدادات دقة الموقع' : 'Open location accuracy settings'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => Geolocator.openAppSettings(),
              icon: const Icon(Icons.settings_applications_rounded),
              label: Text(ar ? 'إعدادات التطبيق (الأذونات)' : 'App settings (permissions)'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () async {
                final changed = await CityPickerSheet.show(context);
                if (changed && context.mounted) Navigator.pop(context, false);
              },
              icon: const Icon(Icons.location_city_rounded),
              label: Text(ar ? 'اختيار المدينة يدويًا (مضمون 100%)' : 'Choose city manually (100% reliable)'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(ar ? 'إعادة المحاولة' : 'Retry'),
            ),
          ],
        );
      },
    );
  }
}
