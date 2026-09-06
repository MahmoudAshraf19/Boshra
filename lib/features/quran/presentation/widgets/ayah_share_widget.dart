import 'package:flutter/material.dart';
import '../../data/models/quran_models.dart';

class AyahShareWidget extends StatelessWidget {
  final AyahModel ayah;
  final SurahModel surah;
  
  const AyahShareWidget({
    super.key,
    required this.ayah,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    // We use a fixed standard size (e.g. 4:5 aspect ratio) for sharing
    // 1080 x 1350 is the optimal size for Instagram/Facebook posts
    return Container(
      width: 1080,
      height: 1350,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/share.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Content Overlay
          Padding(
            padding: const EdgeInsets.only(
              left: 100.0, 
              right: 100.0, 
              top: 300.0, 
              bottom: 250.0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        width: 880, // 1080 - 200 padding
                        child: Text(
                          ayah.text,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'AmiriQuran',
                            fontSize: 54, // Slightly smaller base font
                            height: 2.0,
                            color: Color(0xFFE2D6B5), 
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Separator diamond/star icon if desired, or just dot
                const Icon(
                  Icons.diamond,
                  color: Color(0xFFB58F58),
                  size: 24,
                ),
                
                const SizedBox(height: 30),
                
                // Footer text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      surah.name,
                      style: const TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 32,
                        color: Color(0xFF908A7E), // Subtle dark gold/grey matching bottom text
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '•',
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF908A7E),
                        ),
                      ),
                    ),
                    Text(
                      'الآية ${ayah.numberInSurah}',
                      style: const TextStyle(
                        fontFamily: 'AmiriQuran',
                        fontSize: 32,
                        color: Color(0xFF908A7E),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
          
          // App Logo and Name Footer
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Use a crescent moon icon
                const Icon(
                  Icons.nightlight_round,
                  color: Color(0xFFC0A062),
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'بشرى | Boshra',
                  style: const TextStyle(
                    fontFamily: 'IBMPlexSansArabic',
                    fontSize: 26,
                    color: Color(0xFF908A7E),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
