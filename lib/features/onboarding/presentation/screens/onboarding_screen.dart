import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/layout/presentation/screens/main_layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
      );
    }
  }

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onSkip() {
    _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Fallbacks just in case l10n is not generated yet during initial build
    final title1 = l10n?.onboarding1Title ?? 'بُشرى… رفيقك في طريق الخير';
    final desc1 = l10n?.onboarding1Desc ?? 'اجعل يومك أقرب إلى الله، بخطوات بسيطة وعبادات حاضرة معك في كل وقت.';
    
    final title2 = l10n?.onboarding2Title ?? 'كل ما تحتاجه لعبادتك، في مكان واحد';
    final desc2 = l10n?.onboarding2Desc ?? 'القرآن، أوقات الصلاة، الأذكار، القبلة، والأدعية… بتجربة بسيطة تساعدك على الاستمرار.';
    
    final title3 = l10n?.onboarding3Title ?? 'خطوة صغيرة كل يوم… تصنع أثرًا كبيرًا';
    final desc3 = l10n?.onboarding3Desc ?? 'ابنِ عاداتك الإيمانية، واغتنم لحظات يومك بما يقربك إلى الله.';

    final pages = [
      _OnboardingData(
        title: title1,
        description: desc1,
        image: AppAssets.onboarding1,
      ),
      _OnboardingData(
        title: title2,
        description: desc2,
        image: AppAssets.onboarding2,
      ),
      _OnboardingData(
        title: title3,
        description: desc3,
        image: AppAssets.onboarding3,
      ),
    ];

    final isLastPage = _currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.lightBackground, // Cream background
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _OnboardingPageWidget(data: pages[index]);
                },
              ),
            ),
            
            // Dot Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index 
                        ? Theme.of(context).colorScheme.primaryContainer 
                        : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Next / Start Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isLastPage 
                            ? (l10n?.startJourney ?? 'ابدأ رحلتك')
                            : (l10n?.next ?? 'التالي'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Skip Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: isLastPage 
                      ? const SizedBox() // Hide on last page
                      : OutlinedButton(
                          onPressed: _onSkip,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            side: const BorderSide(
                              color: AppColors.lightDivider, 
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n?.skip ?? 'تخطي',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
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
