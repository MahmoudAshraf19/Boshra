import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/ayah_of_the_day_card.dart';
import '../widgets/daily_wird_card.dart';
import '../widgets/quick_access_card.dart';
import '../widgets/continue_reading_card.dart';
import '../widgets/selected_recitation_card.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/notification_service.dart';
import '../../../prayer/presentation/screens/prayer_settings_screen.dart';
import '../../../quran/data/repositories/quran_repository.dart';
import '../../../azkar/presentation/screens/azkar_details_screen.dart';
import '../../../azkar/presentation/providers/azkar_provider.dart';
import 'package:provider/provider.dart';
import '../../../quran/presentation/widgets/tafsir_bottom_sheet.dart';
import '../../../quran/presentation/widgets/recitation_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onTabChange;
  
  const HomeScreen({super.key, this.onTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) {
        NotificationService().scheduleDailyAzkarNotifications(l10n);
        NotificationService().scheduleDailyQuranMessage(l10n);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.55,
            pinned: true,
            elevation: 0,
            stretch: true,
            toolbarHeight: 60.0,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: Theme.of(context).colorScheme.primaryContainer,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerSettingsScreen()));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              title: LayoutBuilder(
                builder: (context, constraints) {
                  // When expanded, we don't show the title.
                  // When collapsed (app bar mode), we show a mini version of the header.
                  final bool isCollapsed = constraints.biggest.height <= kToolbarHeight + 60;
                  if (!isCollapsed) return const SizedBox.shrink();
                  
                  final headerMainColor = isDark ? Colors.black87 : Colors.white;
                  final headerSubColor = isDark ? Colors.black54 : Colors.white70;
                  final headerAccentColor = isDark ? const Color(0xFF8B5A2B) : AppColors.lightGoldenAccent;
                  
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.greeting,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                ),
                              ),
                              Text(
                                _controller.locationName,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.radio,
                            color: Theme.of(context).colorScheme.primaryContainer,
                            size: 20,
                          ),
                        ],
                      );
                    }
                  );
                },
              ),
              background: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      Image.asset(
                        isDark 
                            ? 'assets/images/banner_header_dark.png' 
                            : 'assets/images/banner_header_light.png',
                        fit: BoxFit.cover,
                      ),
                      
                      // Gradient Overlay for readability
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.black.withValues(alpha: 0.2),
                              isDark ? Colors.black.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.1),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      
                      // Content
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final headerMainColor = isDark ? Colors.black87 : Colors.white;
                          final headerSubColor = isDark ? Colors.black54 : Colors.white70;
                          final headerAccentColor = isDark ? const Color(0xFF8B5A2B) : AppColors.lightGoldenAccent;
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SafeArea(
                                bottom: false,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.volunteer_activism, color: headerAccentColor, size: 20),
                                                const SizedBox(width: 8),
                                                Text(
                                                  l10n.greeting,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: headerMainColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined, color: headerSubColor, size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  _controller.locationName,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: headerSubColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (_controller.hijriDate != null) ...[
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_today_outlined, color: headerSubColor, size: 14),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${_controller.hijriDate!.day} ${Localizations.localeOf(context).languageCode == 'ar' ? _controller.hijriDate!.monthAr : _controller.hijriDate!.monthEn} ${_controller.hijriDate!.year}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: headerSubColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              const Spacer(),
                              
                              // Center Dome Area: Next Prayer Info
                              if (_controller.prayerTimes != null) ...[
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        l10n.nextPrayerTitle(_controller.nextPrayerName), 
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: headerMainColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _controller.formattedCountdown,
                                        style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                          color: headerAccentColor,
                                          fontFamily: 'Courier',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        l10n.untilNextPrayer(_controller.nextPrayerName),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: headerSubColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const Spacer(),
                                
                                // 5 Prayers Row at the bottom
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildPrayerItem(l10n.fajr, _controller.prayerTimes!.timings.fajr, Icons.wb_twilight, _controller.nextPrayerName == 'Fajr'),
                                      _buildPrayerItem(l10n.dhuhr, _controller.prayerTimes!.timings.dhuhr, Icons.wb_sunny_outlined, _controller.nextPrayerName == 'Dhuhr'),
                                      _buildPrayerItem(l10n.asr, _controller.prayerTimes!.timings.asr, Icons.light_mode_outlined, _controller.nextPrayerName == 'Asr'),
                                      _buildPrayerItem(l10n.maghrib, _controller.prayerTimes!.timings.maghrib, Icons.wb_twilight_outlined, _controller.nextPrayerName == 'Maghrib'),
                                      _buildPrayerItem(l10n.isha, _controller.prayerTimes!.timings.isha, Icons.nights_stay_outlined, _controller.nextPrayerName == 'Isha'),
                                    ],
                                  ),
                                ),
                              ] else if (_controller.isLoading) ...[
                                const Spacer(),
                                const Center(child: CircularProgressIndicator(color: Colors.white)),
                                const Spacer(),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // The rest of the Home Screen Content
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  if (_controller.dailyAyah != null) {
                    return AyahOfTheDayCard(
                      ayah: _controller.dailyAyah!,
                      onListen: () async {
                        final ayah = _controller.dailyAyah!;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => const Center(child: CircularProgressIndicator()),
                        );
                        final surah = await QuranRepository().getSurah(ayah.surahNumber ?? 1, useUthmani: true);
                        if (mounted) Navigator.pop(context); // close loading
                        if (surah != null && mounted) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => RecitationBottomSheet(
                              initialAyah: ayah,
                              surah: surah,
                              locale: Localizations.localeOf(context).languageCode,
                            ),
                          );
                        }
                      },
                      onTafseer: () async {
                        final ayah = _controller.dailyAyah!;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => const Center(child: CircularProgressIndicator()),
                        );
                        final surah = await QuranRepository().getSurah(ayah.surahNumber ?? 1, useUthmani: true);
                        if (mounted) Navigator.pop(context); // close loading
                        if (surah != null && mounted) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => TafsirBottomSheet(
                              ayah: ayah,
                              surah: surah,
                              locale: Localizations.localeOf(context).languageCode,
                            ),
                          );
                        }
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              
              DailyWirdCard(
                onContinue: () {
                  final hour = DateTime.now().hour;
                  final isMorning = hour < 15;
                  final arKey = isMorning ? 'أذكار الصباح' : 'أذكار المساء';
                  final enKeyword = isMorning ? 'Morning' : 'Evening';
                  
                  final provider = context.read<AzkarProvider>();
                  String targetKey = arKey;
                  
                  if (!provider.groupedAzkar.containsKey(arKey)) {
                    try {
                      targetKey = provider.groupedAzkar.keys.firstWhere(
                        (k) => k.toLowerCase().contains(enKeyword.toLowerCase()) || k.contains(arKey)
                      );
                    } catch (_) {
                      if (provider.groupedAzkar.isNotEmpty) {
                         targetKey = provider.groupedAzkar.keys.first;
                      }
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AzkarDetailsScreen(categoryName: targetKey),
                    ),
                  );
                },
              ),
              
              QuickAccessCard(
                onTabChange: widget.onTabChange,
              ),
              
              const SizedBox(height: 16),
              const ContinueReadingCard(),
              const SizedBox(height: 16),
              const SelectedRecitationCard(),
              const SizedBox(height: 32), // padding at the bottom
            ]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrayerItem(String name, String timeStr, IconData icon, bool isNext) {
    // Format the time slightly
    String formattedTime = timeStr.split(' ')[0]; // Remove timezone part if any
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: isNext
          ? BoxDecoration(
              color: AppColors.lightGoldenAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isNext ? AppColors.lightGoldenAccent : Theme.of(context).unselectedWidgetColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            name, 
            style: TextStyle(
              fontSize: 12,
              fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
              color: isNext ? AppColors.lightGoldenAccent : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              color: isNext ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).unselectedWidgetColor,
            ),
          ),
        ],
      ),
    );
  }
}
