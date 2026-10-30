import '../../../permissions/presentation/permission_gate.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../quran/presentation/screens/quran_screen.dart';
import '../../../azkar/presentation/screens/azkar_screen.dart';
import '../../../radio/presentation/screens/radio_screen.dart';
import '../../../more/presentation/screens/more_screen.dart';
import '../widgets/startup_location_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/location_service.dart';
import 'package:flutter/services.dart';
import 'package:boshra/features/home/presentation/controllers/home_controller.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  static bool _hasShownLocationDialog = false;
  int _currentIndex = 0;
  DateTime? _lastBackPressTime;

  late final List<Widget> _screens = [
    HomeScreen(
      onTabChange: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
    const QuranScreen(),
    const AzkarScreen(),
    const RadioScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startupChecks();
    });
  }

  /// 1) location dialog (if needed)  2) notification / alarm / battery setup.
  Future<void> _startupChecks() async {
    await _checkLocationPermission();
    if (!mounted) return;
    await PermissionGate.maybeShow(context);
  }

  Future<void> _checkLocationPermission() async {
    if (_hasShownLocationDialog) return;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      _hasShownLocationDialog = true;
      
      // Fetch saved location if exists
      String? savedLocationName;
      try {
        final prefs = await SharedPreferences.getInstance();
        final lat = prefs.getDouble('last_latitude');
        final lng = prefs.getDouble('last_longitude');
        if (lat != null && lng != null) {
          savedLocationName = await LocationService().getLocationName(lat, lng);
        }
      } catch (e) {
        debugPrint('Error fetching saved location for dialog: $e');
      }

      if (mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StartupLocationDialog(
            savedLocationName: savedLocationName,
            onAllow: () {
              HomeController.instance?.refreshData();
            },
          ),
        );
      }
    } else {
      _hasShownLocationDialog = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 1) If on another tab, return to home tab first
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return;
        }

        // 2) If already on home tab, require double back press to exit
        final now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          final message = isArabic
              ? 'اضغط مرة أخرى للخروج من التطبيق'
              : 'Press back again to exit';

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 24, left: 48, right: 48),
            ),
          );
          return;
        }

        // Double press within 2 seconds -> exit application
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.darkSurface 
                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkGoldenAccent 
                : AppColors.lightPrimaryDark, // الزيتي الغامق
            unselectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.6)
                : AppColors.lightPrimaryDark.withValues(alpha: 0.5),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: l10n.navHome,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book_outlined),
                activeIcon: const Icon(Icons.menu_book),
                label: l10n.navQuran,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.mosque_outlined),
                activeIcon: const Icon(Icons.mosque),
                label: l10n.navAzkar,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.radio_outlined),
                activeIcon: const Icon(Icons.radio),
                label: l10n.navRadio,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.more_horiz_outlined),
                activeIcon: const Icon(Icons.more_horiz),
                label: l10n.navMore,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
