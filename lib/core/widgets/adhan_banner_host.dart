import 'package:flutter/material.dart';
import '../notifications/adhan_banner_controller.dart';
import 'adhan_banner.dart';

/// Wrap the app with this (MaterialApp.builder) so the Adhan banner can slide in
/// over ANY screen while the app is open.
class AdhanBannerHost extends StatefulWidget {
  final Widget child;
  const AdhanBannerHost({super.key, required this.child});

  @override
  State<AdhanBannerHost> createState() => _AdhanBannerHostState();
}

class _AdhanBannerHostState extends State<AdhanBannerHost> {
  final _c = AdhanBannerController.instance;

  @override
  void initState() {
    super.initState();
    _c.attach();
  }

  @override
  void dispose() {
    _c.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<AdhanBannerData?>(
            valueListenable: _c,
            builder: (context, data, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 380),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, anim) => SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: data == null
                    ? const SizedBox.shrink(key: ValueKey('adhan_banner_none'))
                    : SafeArea(
                        key: ValueKey('adhan_banner_${data.notificationId}'),
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Material(
                            type: MaterialType.transparency,
                            child: AdhanBannerView(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              title: data.title,
                              subtitle: data.subtitle,
                              verse: data.verse,
                              stopLabel: data.stopLabel,
                              onStop: _c.stop,
                              onClose: _c.dismiss,
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
