import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../../../features/layout/presentation/screens/main_layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
      
    // Request notification permissions safely after UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().requestPermissions();
    });
    
    _animationController.forward().then((_) async {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => hasSeenOnboarding ? const MainLayoutScreen() : const OnboardingScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppAssets.splashBackground,
              fit: BoxFit.cover,
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Logo
                Image.asset(
                  AppAssets.splashLogo,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback icon if image is missing during development
                    return const Icon(Icons.mosque, size: 100, color: AppColors.lightGoldenAccent);
                  },
                ),
                
                const SizedBox(height: 16),
                
                // "Bushra" text
                const Text(
                  'Bushra',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightGoldenAccent,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // "بشرى" text
                const Text(
                  'بشرى',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGoldenAccent,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Quranic Ayah
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'هُدًى وَبُشْرَىٰ لِلْمُؤْمِنِينَ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.5,
                      color: AppColors.lightGoldenAccent,
                      fontFamily: 'Uthmanic',
                    ),
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Loading Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _animationController.value,
                      backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                      minHeight: 6,
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
