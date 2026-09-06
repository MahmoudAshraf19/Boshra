import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/quran_models.dart';
import '../../data/models/reciter_model.dart';
import 'package:boshra/core/services/audio_service.dart';
import '../../../../l10n/app_localizations.dart';

class SurahRecitationBottomSheet extends StatefulWidget {
  final SurahModel surah;
  final String locale;

  const SurahRecitationBottomSheet({
    super.key,
    required this.surah,
    required this.locale,
  });

  @override
  State<SurahRecitationBottomSheet> createState() => _SurahRecitationBottomSheetState();
}

class _SurahRecitationBottomSheetState extends State<SurahRecitationBottomSheet> {
  late AudioPlayer _audioPlayer;
  late ReciterModel _selectedReciter;
  
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;
  bool _isLooping = false;
  bool _isMuted = false;
  
  int _currentIndex = 0;
  bool _isLoading = true;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _currentIndexSubscription;

  @override
  void initState() {
    super.initState();
    _selectedReciter = availableReciters[0];
    _audioPlayer = GlobalAudioPlayer.player;
    
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    final savedReciterId = prefs.getString('selected_reciter_id');
    if (savedReciterId != null) {
      _selectedReciter = availableReciters.firstWhere(
        (r) => r.id == savedReciterId,
        orElse: () => availableReciters[0]
      );
    }
    
    _setupAudioListeners();
    await _loadSurahPlaylist(autoPlay: false);
  }

  void _setupAudioListeners() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
          if (state.processingState == ProcessingState.completed) {
             _audioPlayer.stop();
             _audioPlayer.seek(Duration.zero, index: 0);
             _isPlaying = false;
          }
        });
      }
    });

    _durationSubscription = _audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() => _duration = d ?? Duration.zero);
      }
    });

    _positionSubscription = _audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() => _position = p);
      }
    });
    
    _currentIndexSubscription = _audioPlayer.currentIndexStream.listen((index) {
      if (mounted && index != null) {
        setState(() {
          _currentIndex = index;
        });
      }
    });
  }

  Future<void> _loadSurahPlaylist({bool autoPlay = false}) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final audioSources = widget.surah.ayahs.map((ayah) {
        final url = 'https://cdn.islamic.network/quran/audio/64/${_selectedReciter.id}/${ayah.number}.mp3';
        return AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: '${widget.surah.number}_${ayah.number}',
            album: widget.surah.name,
            title: widget.locale == 'ar' ? 'الآية ${ayah.numberInSurah}' : 'Ayah ${ayah.numberInSurah}',
            artist: widget.locale == 'ar' ? _selectedReciter.nameAr : _selectedReciter.nameEn,
          ),
        );
      }).toList();
      
      final playlist = ConcatenatingAudioSource(children: audioSources);
      
      await _audioPlayer.stop();
      await _audioPlayer.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
      if (_isLooping) {
        _audioPlayer.setLoopMode(LoopMode.all);
      }
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      
      if (autoPlay) {
        _audioPlayer.play();
      }
    } catch (e) {
      print('❌ [Surah Audio Error] Failed to load playlist: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.locale == 'ar' ? 'عذراً، فشل تحميل الصوت لهذا القارئ.' : 'Sorry, failed to load audio for this reciter.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _changeReciter(ReciterModel reciter) async {
    setState(() => _selectedReciter = reciter);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_reciter_id', reciter.id);
    await _loadSurahPlaylist(autoPlay: true);
  }

  void _playNextAyah() {
    if (_audioPlayer.hasNext) {
      _audioPlayer.seekToNext();
    }
  }

  void _playPrevAyah() {
    if (_audioPlayer.hasPrevious) {
      _audioPlayer.seekToPrevious();
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  double _getOverallProgress() {
    final total = widget.surah.ayahs.length.toDouble();
    if (total == 0) return 0.0;
    
    double currentAyahProgress = 0.0;
    if (_duration.inMilliseconds > 0) {
      currentAyahProgress = _position.inMilliseconds / _duration.inMilliseconds;
    }
    
    return (_currentIndex + currentAyahProgress).clamp(0.0, total);
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _currentIndexSubscription?.cancel();
    _audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final currentAyah = widget.surah.ayahs[_currentIndex];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header: Surah Name, Ayah Count & Reciter Selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n.recitationOption} - ${widget.surah.name}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  fontFamily: 'AmiriQuran',
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.locale == 'ar'
                    ? 'الآية ${currentAyah.numberInSurah} من ${widget.surah.ayahs.length}'
                    : 'Ayah ${currentAyah.numberInSurah} of ${widget.surah.ayahs.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              // Reciter Selector
              PopupMenuButton<ReciterModel>(
                initialValue: _selectedReciter,
                onSelected: _changeReciter,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: colorScheme.surface,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, size: 18, color: colorScheme.onPrimary),
                      const SizedBox(width: 8),
                      Text(
                        widget.locale == 'ar' ? _selectedReciter.nameAr : _selectedReciter.nameEn,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.arrow_drop_down, size: 20, color: colorScheme.onPrimary),
                    ],
                  ),
                ),
                itemBuilder: (context) => availableReciters.map((r) {
                  return PopupMenuItem<ReciterModel>(
                    value: r,
                    child: Text(
                      widget.locale == 'ar' ? r.nameAr : r.nameEn,
                      style: TextStyle(
                        fontWeight: r.id == _selectedReciter.id ? FontWeight.bold : FontWeight.normal,
                        color: r.id == _selectedReciter.id ? colorScheme.primary : colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Ayah Text Preview
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Text(
              '${currentAyah.text} ﴿${currentAyah.numberInSurah}﴾',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'AmiriQuran',
                fontSize: 24,
                height: 1.8,
                color: colorScheme.onSurface,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Progress Bar
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CircularProgressIndicator(),
            )
          else
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    activeTrackColor: colorScheme.primary,
                    inactiveTrackColor: colorScheme.primaryContainer,
                    thumbColor: colorScheme.primary,
                    overlayColor: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                  child: Slider(
                    value: _getOverallProgress(),
                    min: 0.0,
                    max: widget.surah.ayahs.length.toDouble(),
                    onChanged: (value) {
                      final targetIndex = value.floor().clamp(0, widget.surah.ayahs.length - 1);
                      _audioPlayer.seek(Duration.zero, index: targetIndex);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.locale == 'ar' 
                            ? 'الآية ${currentAyah.numberInSurah}'
                            : 'Ayah ${currentAyah.numberInSurah}',
                        style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        widget.locale == 'ar' 
                            ? '${widget.surah.ayahs.length} آية'
                            : '${widget.surah.ayahs.length} Ayahs',
                        style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          const SizedBox(height: 24),

          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Speed Control
              IconButton(
                onPressed: () {
                  final newSpeed = _playbackSpeed == 1.0 ? 1.25 : _playbackSpeed == 1.25 ? 1.5 : _playbackSpeed == 1.5 ? 0.75 : 1.0;
                  setState(() => _playbackSpeed = newSpeed);
                  _audioPlayer.setSpeed(newSpeed);
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${_playbackSpeed}x',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),

              // Previous Ayah
              IconButton(
                onPressed: _currentIndex > 0 ? _playPrevAyah : null,
                iconSize: 32,
                color: colorScheme.onSurface,
                icon: const Icon(Icons.skip_previous_rounded),
              ),

              // Play / Pause
              GestureDetector(
                onTap: () {
                  if (_isPlaying) {
                    _audioPlayer.pause();
                  } else {
                    _audioPlayer.play();
                  }
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: colorScheme.onPrimary,
                    size: 36,
                  ),
                ),
              ),

              // Next Ayah
              IconButton(
                onPressed: _currentIndex < widget.surah.ayahs.length - 1 ? _playNextAyah : null,
                iconSize: 32,
                color: colorScheme.onSurface,
                icon: const Icon(Icons.skip_next_rounded),
              ),

              // Loop Toggle
              IconButton(
                onPressed: () {
                  setState(() {
                    _isLooping = !_isLooping;
                    _audioPlayer.setLoopMode(_isLooping ? LoopMode.all : LoopMode.off);
                  });
                },
                icon: Icon(
                  _isLooping ? Icons.repeat_one_rounded : Icons.repeat_rounded,
                  color: _isLooping ? colorScheme.primary : colorScheme.onSurfaceVariant,
                ),
              ),
              
              // Lock / Background Play
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.locale == 'ar' 
                            ? 'تم تفعيل التلاوة في الخلفية، يمكنك قفل الشاشة الآن'
                            : 'Background play enabled. You can lock the screen now.',
                      ),
                      backgroundColor: colorScheme.primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(
                  Icons.screen_lock_portrait_rounded,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
