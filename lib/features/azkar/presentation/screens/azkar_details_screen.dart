import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/azkar_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class AzkarDetailsScreen extends StatefulWidget {
  final String categoryName;

  const AzkarDetailsScreen({super.key, required this.categoryName});

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  
  // Track counts for each zekr index
  final Map<int, int> _counts = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementCount(int index, int targetCount) {
    setState(() {
      final current = _counts[index] ?? 0;
      if (current < targetCount) {
        _counts[index] = current + 1;
        
        // Auto-swipe if reached target
        if (_counts[index] == targetCount) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted && _currentPage < context.read<AzkarProvider>().groupedAzkar[widget.categoryName]!.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AzkarProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = isDark ? AppColors.darkMainText : AppColors.lightMainText;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(context, provider, isDark),
    );
  }

  Widget _buildBody(BuildContext context, AzkarProvider provider, bool isDark) {
    final textColor = isDark ? AppColors.darkMainText : AppColors.lightMainText;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(provider.error!),
          ],
        ),
      );
    }

    final azkarList = provider.groupedAzkar[widget.categoryName] ?? [];

    if (azkarList.isEmpty) {
      return const Center(child: Text('No Azkar found for this category.'));
    }

    return Column(
      children: [
        // Top counter: Current / Total
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${_currentPage + 1} / ${azkarList.length}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: azkarList.length,
            itemBuilder: (context, index) {
              final zekr = azkarList[index];
              int targetCount = 1; // Default
              if (zekr.count.isNotEmpty) {
                targetCount = int.tryParse(zekr.count) ?? 1;
              }
              final currentCount = _counts[index] ?? 0;
              final isCompleted = currentCount >= targetCount;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              zekr.zekr,
                              style: TextStyle(
                                fontSize: 24,
                                height: 1.8,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontFamily: 'Amiri', // Or default font for Arabic
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (zekr.description.isNotEmpty) ...[
                              const SizedBox(height: 24),
                              Text(
                                zekr.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withValues(alpha: 0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    
                    // Bottom Navigation & Counter
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Arrow
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            color: _currentPage > 0 
                                ? textColor 
                                : Colors.transparent,
                            onPressed: _currentPage > 0 
                                ? () {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } 
                                : null,
                          ),
                          
                          // Circular Progress Button
                          GestureDetector(
                            onTap: () => _incrementCount(index, targetCount),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    value: targetCount > 0 ? (currentCount / targetCount) : 1.0,
                                    strokeWidth: 6,
                                    backgroundColor: textColor.withValues(alpha: 0.1),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      isCompleted ? Colors.green : AppColors.lightGoldenAccent, // Match image gold/yellow
                                    ),
                                  ),
                                ),
                                Text(
                                  '${targetCount - currentCount}x',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Next Arrow
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: _currentPage < azkarList.length - 1 
                                ? textColor 
                                : Colors.transparent,
                            onPressed: _currentPage < azkarList.length - 1 
                                ? () {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } 
                                : null,
                          ),
                        ],
                      ),
                    ),
                    
                    // Swipe for next hint
                    Text(
                      AppLocalizations.of(context)!.localeName == 'ar' ? 'اسحب للتالي' : 'Swipe for next',
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
