import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../core/services/telemetry.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/layout/presentation/screens/main_layout_screen.dart';
import '../../../prayer/presentation/widgets/city_picker_sheet.dart';

/// First-run onboarding: 3 screens, each explains WHY and asks for ONE thing, in order:
///   1) Location (accurate prayer times)  2) Notifications + exact alarms (Adhan on time)
///   3) Background (battery / auto-start)  → then the app.
/// Nothing is forced: every step can be skipped, and the status is re-checked when the
/// user comes back from Android settings.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _busy = false;
  ReliabilityStatus? _st;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Telemetry.log('onboarding_start');
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    final st = await PermissionCenter.check(force: true);
    if (mounted) setState(() => _st = st);
  }

  bool _granted(int page) {
    final st = _st;
    if (st == null) return false;
    switch (page) {
      case 0:
        return st.location;
      case 1:
        return st.notifications && st.exactAlarm;
      default:
        return st.battery && !st.needsAutostart;
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    final st = await PermissionCenter.logState('onboarding_end');
    Telemetry.log('onboarding_done', {'location': st.location, 'notif': st.notifications});
    NotificationCoordinator.instance.rescheduleAll(force: true); // first schedule right away
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
      );
    }
  }

  void _next() {
    if (_currentPage < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _act() async {
    if (_busy) return;
    if (_granted(_currentPage)) return _next();
    setState(() => _busy = true);
    try {
      switch (_currentPage) {
        case 0:
          await PermissionCenter.requestLocation();
          break;
        case 1:
          await PermissionCenter.requestNotifications();
          final st = await PermissionCenter.check(force: true);
          if (st.notifications && !st.exactAlarm) await PermissionCenter.requestExactAlarm();
          break;
        default:
          await PermissionCenter.requestBatteryExemption();
          final st = await PermissionCenter.check(force: true);
          if (st.needsAutostart) {
            await PermissionCenter.openAutostart();
            await PermissionCenter.markAutostartDone();
          }
      }
    } finally {
      await _refresh();
      await PermissionCenter.logState('onboarding_p${_currentPage + 1}');
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickCity() async {
    final changed = await CityPickerSheet.show(context);
    if (changed) {
      await _refresh();
      Telemetry.log('onboarding_manual_city');
      _next();
    }
  }

  List<_OnboardingData> _pages() => [
        _OnboardingData(
          title: _ar ? 'موقعك… لمواعيد صلاة دقيقة' : 'Your location, for exact prayer times',
          description: _ar
              ? 'بنحتاج موقعك علشان نحسب مواعيد الصلاة والقبلة لمدينتك بالظبط. مش بنتتبّع تحركاتك، وتقدر بدل كده تختار مدينتك يدويًا.'
              : 'We use your location to compute prayer times and Qibla for your city. We never track your movements, and you can pick your city manually instead.',
          image: AppAssets.onboarding1,
        ),
        _OnboardingData(
          title: _ar ? 'الأذان في وقته بالثانية' : 'The Adhan right on time',
          description: _ar
              ? 'علشان الأذان والتذكيرات يظهروا ويشتغلوا حتى والتطبيق مقفول، محتاجين إذن الإشعارات وإذن "المنبّهات والتذكيرات" (أندرويد 12+).'
              : 'So the Adhan and reminders show and play even when the app is closed, we need the Notifications permission and "Alarms & reminders" (Android 12+).',
          image: AppAssets.onboarding2,
        ),
        _OnboardingData(
          title: _ar ? 'يشتغل في الخلفية بدون توقف' : 'Works in the background, always',
          description: _ar
              ? 'بعض الموبايلات (شاومي، أوبو، سامسونج، هواوي…) بتقفل التطبيقات لتوفير البطارية فالأذان ممكن ما يشتغلش. السماح بالعمل في الخلفية بيمنع ده تمامًا.'
              : 'Some phones (Xiaomi, Oppo, Samsung, Huawei…) kill apps to save battery, which can silence the Adhan. Allowing background activity prevents that.',
          image: AppAssets.onboarding3,
        ),
      ];

  String _actionLabel(int page) {
    final ok = _granted(page);
    if (page == 2 && ok) return _ar ? 'ابدأ رحلتك' : 'Start your journey';
    if (ok) return _ar ? 'تم ✓ — التالي' : 'Done ✓ — Next';
    switch (page) {
      case 0:
        return _ar ? 'السماح بالموقع' : 'Allow location';
      case 1:
        return _ar ? 'تفعيل الإشعارات والمنبّهات' : 'Enable notifications & alarms';
      default:
        return _ar ? 'السماح بالعمل في الخلفية' : 'Allow background activity';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages();
    final cs = Theme.of(context).colorScheme;
    final ok = _granted(_currentPage);
    final isLast = _currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                physics: const NeverScrollableScrollPhysics(), // go on only via the buttons
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _OnboardingPageWidget(data: pages[i]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == i ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? cs.primaryContainer
                        : cs.primaryContainer.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _busy ? null : _act,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ok ? Colors.green.shade700 : cs.primaryContainer,
                      foregroundColor: cs.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: _busy
                        ? const SizedBox(
                            width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                        : Text(_actionLabel(_currentPage),
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: _currentPage == 0 && !ok
                      ? OutlinedButton.icon(
                          onPressed: _busy ? null : _pickCity,
                          icon: const Icon(Icons.location_city_rounded),
                          label: Text(_ar ? 'اختيار المدينة يدويًا' : 'Choose city manually'),
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        )
                      : (ok || isLast && ok)
                          ? const SizedBox()
                          : TextButton(
                              onPressed: _busy
                                  ? null
                                  : () {
                                      Telemetry.log('onboarding_skip', {'page': _currentPage + 1});
                                      _next();
                                    },
                              child: Text(_ar ? 'لاحقًا' : 'Later'),
                            ),
                ),
                if (_currentPage == 0 && !ok)
                  TextButton(
                    onPressed: _busy ? null : () {
                      Telemetry.log('onboarding_skip', {'page': 1});
                      _next();
                    },
                    child: Text(_ar ? 'لاحقًا' : 'Later'),
                  ),
                const SizedBox(height: 16),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String description;
  final String image;

  _OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

class _OnboardingPageWidget extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPageWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.6,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Center Image
          Expanded(
            child: Image.asset(
              data.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                 return Container(
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Theme.of(context).dividerColor,
                     borderRadius: BorderRadius.circular(24),
                   ),
                   child: const Center(
                     child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                   ),
                 );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
