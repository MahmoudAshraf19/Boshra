import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../features/layout/presentation/screens/main_layout_screen.dart';
import '../../../../features/onboarding/presentation/screens/onboarding_screen.dart';

/// Launch splash: plays `assets/video/boshra_splash.mp4`.
///
/// Plays the intro video from the beginning and smoothly dissolves directly
/// into the main app when the video finishes, without displaying any static image.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _tag = 'Splash';
  static const _maxDuration = Duration(seconds: 8); // safety net

  VideoPlayerController? _video;
  Timer? _safety;
  bool _navigated = false;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _safety = Timer(_maxDuration, _goNext);
    _startVideo();
  }

  Future<void> _startVideo() async {
    try {
      final c = VideoPlayerController.asset(
        AppAssets.splashVideo,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      _video = c;
      await c.initialize();
      await c.setVolume(0);
      await c.setLooping(false);
      c.addListener(_onTick);
      if (!mounted) return;
      setState(() => _ready = true);
      await c.play();
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'video failed – continuing');
      _goNext();
    }
  }

  void _onTick() {
    final v = _video?.value;
    if (v == null || !v.isInitialized) return;
    if (v.hasError) {
      _goNext();
      return;
    }
    if (v.duration > Duration.zero && v.position >= v.duration) {
      _goNext();
    }
  }

  Future<void> _goNext() async {
    if (_navigated || !mounted) return;
    _navigated = true;
    _safety?.cancel();
    bool seen = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      seen = prefs.getBool('has_seen_onboarding') ?? false;
    } catch (_) {}
    if (!mounted) return;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) =>
            seen ? const MainLayoutScreen() : const OnboardingScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _safety?.cancel();
    _video?.removeListener(_onTick);
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final v = _video;
    return Scaffold(
      backgroundColor: const Color(0xFF0D150D),
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Dark matching background before video starts
            const ColoredBox(color: Color(0xFF0D150D)),

            // Video plays seamlessly from frame 0 until completion
            if (_ready && v != null)
              FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: v.value.size.width,
                  height: v.value.size.height,
                  child: VideoPlayer(v),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
