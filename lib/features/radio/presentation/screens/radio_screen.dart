import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../providers/radio_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RadioProvider>().loadRadios();
    });
  }

  void _showRadioList(BuildContext context, RadioProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.localeName == 'ar' ? 'القنوات الإذاعية' : 'Radio Channels',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.radios.length,
                  itemBuilder: (context, index) {
                    final radio = provider.radios[index];
                    final isSelected = provider.selectedRadio?.id == radio.id;
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          radio.img,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.radio),
                        ),
                      ),
                      title: Text(
                        radio.name,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppColors.lightGoldenAccent : null,
                        ),
                      ),
                      trailing: isSelected && provider.isPlaying
                          ? const Icon(Icons.equalizer, color: AppColors.lightGoldenAccent)
                          : null,
                      onTap: () {
                        provider.playSpecificRadio(radio);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RadioProvider>();
    final isAr = AppLocalizations.of(context)!.localeName == 'ar';

    return Scaffold(
      backgroundColor: Colors.black, // fallback
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_RadioScreen.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: const Color(0xFF1B2316)), // Fallback dark olive
            ),
          ),
          // Gradient Overlay to ensure text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top padding instead of AppBar
                const SizedBox(height: 16),
                
                if (provider.isLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.lightGoldenAccent)))
                else if (provider.error != null)
                  Expanded(child: Center(child: Text(provider.error!, style: const TextStyle(color: Colors.white))))
                else if (provider.selectedRadio != null) ...[
                  // Spacer to push content down
                  const Spacer(flex: 3),
                  
                  // Radio Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      provider.selectedRadio!.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Amiri', // Or default font
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    isAr ? 'القرآن الكريم - بث مباشر' : 'Holy Quran - Live Stream',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Progress Bar & Live Status
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isAr ? 'مباشر' : 'LIVE',
                          style: const TextStyle(
                            color: AppColors.lightGoldenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                            activeTrackColor: AppColors.lightGoldenAccent,
                            inactiveTrackColor: Colors.white.withOpacity(0.2),
                            thumbColor: AppColors.lightGoldenAccent,
                          ),
                          child: Slider(
                            value: 1.0, // Fixed to max for live stream
                            onChanged: (_) {}, // Disabled slider
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Main Audio Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Previous
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                        onPressed: () => provider.previousRadio(),
                      ),
                      const SizedBox(width: 24),
                      // Play/Pause Big Button
                      GestureDetector(
                        onTap: () {
                          if (provider.isPlaying) {
                            provider.togglePlayPause();
                          } else {
                            provider.playSelectedRadio();
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3E5AB), // Vanilla/Beige color from mockup
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            provider.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            size: 48,
                            color: const Color(0xFF283618), // Dark olive color
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Next
                      IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                        onPressed: () => provider.nextRadio(),
                      ),
                    ],
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Bottom Row: Volume & Playlist
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                    child: Row(
                      children: [
                        // Lock / Background Play button
                        IconButton(
                          icon: const Icon(Icons.lock_clock, color: Colors.white70, size: 24),
                          tooltip: isAr ? 'تشغيل في الخلفية' : 'Play in Background',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isAr ? 'الإذاعة تعمل في الخلفية الآن' : 'Radio is now playing in background'),
                                backgroundColor: AppColors.lightGoldenAccent,
                              ),
                            );
                            SystemNavigator.pop();
                          },
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.volume_up_rounded, color: Colors.white, size: 24),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 2,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white30,
                              thumbColor: Colors.white,
                            ),
                            child: Slider(
                              value: provider.volume,
                              onChanged: (val) => provider.setVolume(val),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.queue_music_rounded, color: Colors.white, size: 28),
                          onPressed: () => _showRadioList(context, provider),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
