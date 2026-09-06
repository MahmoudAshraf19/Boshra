import 'package:flutter/material.dart';
import '../../../../core/services/quran_api_service.dart';
import '../../data/models/quran_models.dart';
import '../../../../l10n/app_localizations.dart';

class SurahInfoBottomSheet extends StatefulWidget {
  final SurahMetaModel surahMeta;
  final String locale;

  const SurahInfoBottomSheet({
    super.key,
    required this.surahMeta,
    required this.locale,
  });

  @override
  State<SurahInfoBottomSheet> createState() => _SurahInfoBottomSheetState();
}

class _SurahInfoBottomSheetState extends State<SurahInfoBottomSheet> {
  final QuranApiService _quranApiService = QuranApiService();
  
  bool _isLoading = true;
  String? _surahInfo;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadSurahInfo();
  }

  Future<void> _loadSurahInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    try {
      final info = await _quranApiService.getSurahInfo(
        widget.surahMeta.name,
        widget.surahMeta.englishName,
        widget.locale,
      );
      
      if (mounted) {
        if (info != null && info.isNotEmpty) {
          setState(() {
            _surahInfo = info;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = widget.locale == 'ar' 
                ? 'عذراً، لم نتمكن من جلب معلومات هذه السورة.' 
                : 'Sorry, could not fetch information for this Surah.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = widget.locale == 'ar' 
              ? 'حدث خطأ أثناء الاتصال بالخادم.' 
              : 'An error occurred while connecting to the server.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final isArabic = widget.locale == 'ar';

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      '${l10n.infoOption} - ${isArabic ? widget.surahMeta.name : widget.surahMeta.englishName}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontFamily: isArabic ? 'AmiriQuran' : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Metadata Badges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge(
                          icon: Icons.format_list_numbered,
                          text: isArabic 
                              ? '${widget.surahMeta.numberOfAyahs} آية' 
                              : '${widget.surahMeta.numberOfAyahs} Verses',
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(width: 8),
                        _buildBadge(
                          icon: Icons.location_on,
                          text: isArabic
                              ? (widget.surahMeta.revelationType == 'Meccan' ? 'مكية' : 'مدنية')
                              : widget.surahMeta.revelationType,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Body
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage, style: TextStyle(color: colorScheme.error)))
                        : SingleChildScrollView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Info Text
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: colorScheme.primary.withValues(alpha: 0.1)),
                                  ),
                                  child: Text(
                                    _surahInfo!,
                                    textAlign: TextAlign.justify,
                                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                                    style: TextStyle(
                                      fontFamily: isArabic ? 'IBMPlexSansArabic' : null,
                                      fontSize: 18,
                                      height: 1.8,
                                      color: colorScheme.onSurface.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge({required IconData icon, required String text, required ColorScheme colorScheme}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
