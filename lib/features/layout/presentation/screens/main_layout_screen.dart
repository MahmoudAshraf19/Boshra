import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../quran/presentation/screens/quran_screen.dart';
import '../../../azkar/presentation/screens/azkar_screen.dart';
import '../../../qibla/presentation/screens/qibla_screen.dart';
import '../../../radio/presentation/screens/radio_screen.dart';
import '../../../more/presentation/screens/more_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
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
    );
  }
}
