import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../l10n/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../quran/data/repositories/quran_repository.dart';
import '../../../quran/presentation/widgets/recitation_bottom_sheet.dart';
import '../../../quran/data/models/quran_models.dart';

class SelectedRecitationCard extends StatefulWidget {
  const SelectedRecitationCard({super.key});

  @override
  State<SelectedRecitationCard> createState() => _SelectedRecitationCardState();
}

class _SelectedRecitationCardState extends State<SelectedRecitationCard> {
  String? _reciterNameAr;
  String? _reciterNameEn;
  int _lastSurah = 1;
  int _lastAyah = 1;
  String _surahName = 'الفاتحة';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedRecitation();
  }

  Future<void> _loadSavedRecitation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _reciterNameAr = prefs.getString('last_reciter_name_ar');
      _reciterNameEn = prefs.getString('last_reciter_name_en');
      _lastSurah = prefs.getInt('last_recited_surah') ?? 1;
      _lastAyah = prefs.getInt('last_recited_ayah') ?? 1;

      final repo = QuranRepository();
      final meta = await repo.getQuranMetadata();
      if (meta != null && _lastSurah > 0 && _lastSurah <= meta.surahs.length) {
        _surahName = meta.surahs[_lastSurah - 1].name;
      }
    } catch (e) {
      print('Error loading recitation: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title on the right (in RTL)
              Row(
                children: [
                  Text(
                    l10n.selectedRecitationTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.headphones_rounded,
                    color: const Color(0xFF9E8A63), // Brownish color from design
                    size: 20,
                  ),
                ],
              ),
              // More on the left (in RTL)
              Row(
                children: [
                  Text(
                    l10n.navMore,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isRTL ? Icons.arrow_back : Icons.arrow_forward,
                    color: colorScheme.onSurfaceVariant,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Dynamic Content
          GestureDetector(
            onTap: () async {
              if (_isLoading) return;
              final repo = QuranRepository();
              final surahModel = await repo.getSurah(_lastSurah, useUthmani: true);
              if (surahModel != null && mounted) {
                AyahModel targetAyah = surahModel.ayahs.first;
                try {
                  targetAyah = surahModel.ayahs.firstWhere((a) => a.numberInSurah == _lastAyah);
                } catch (_) {}

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => RecitationBottomSheet(
                    initialAyah: targetAyah,
                    surah: surahModel,
                    locale: Localizations.localeOf(context).languageCode,
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: isDark 
                    ? colorScheme.primary.withValues(alpha: 0.1) 
                    : colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : _buildReciterItem(
                    context, 
                    {
                      'name': Localizations.localeOf(context).languageCode == 'ar' 
                          ? (_reciterNameAr ?? 'مشاري العفاسي')
                          : (_reciterNameEn ?? 'Mishary Alafasy'),
                      'surah': '${l10n.surahName(_surahName)} - ${l10n.ayahNumber(_lastAyah.toString())}',
                    }, 
                    isDark, 
                    colorScheme, 
                    l10n
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReciterItem(BuildContext context, Map<String, String> reciter, bool isDark, ColorScheme colorScheme, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side: Live Badge + Play Button (In RTL, this appears on the left)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Live Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5), // Light red
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.live,
                  style: const TextStyle(
                    color: Color(0xFFFF4D4D), // Red text
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Play Button
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF9E8A63), // Brownish color
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          // Right Side: Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reciter['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  reciter['surah']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
