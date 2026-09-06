import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/quran_models.dart';
import '../../data/models/reciter_model.dart';
import 'package:boshra/core/services/audio_service.dart';

class RecitationBottomSheet extends StatefulWidget {
  final AyahModel initialAyah;
  final SurahModel surah;
  final String locale;

  const RecitationBottomSheet({
    super.key,
    required this.initialAyah,
    required this.surah,
    required this.locale,
  });

  @override
  State<RecitationBottomSheet> createState() => _RecitationBottomSheetState();
}

class _RecitationBottomSheetState extends State<RecitationBottomSheet> {
  late AudioPlayer _audioPlayer;
  late AyahModel _currentAyah;
  late ReciterModel _selectedReciter;
  
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;
  bool _isLooping = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _currentAyah = widget.initialAyah;
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
    await _loadAudio(autoPlay: false);
  }

  void _setupAudioListeners() {
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
          if (state.processingState == ProcessingState.completed) {
            if (_isLooping) {
              _audioPlayer.seek(Duration.zero);
              _audioPlayer.play();
            } else {
               _audioPlayer.stop();
               _audioPlayer.seek(Duration.zero);
               _isPlaying = false;
            }
          }
        });
      }
    });

    _audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() => _duration = d ?? Duration.zero);
      }
    });

    _audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() => _position = p);
      }
    });
  }

  Future<void> _loadAudio({bool autoPlay = false}) async {
    // Some reciters don't have 128kbps quality, so we use 64kbps for maximum compatibility.
    final url = 'https://cdn.islamic.network/quran/audio/64/${_selectedReciter.id}/${_currentAyah.number}.mp3';
    print('🌐 [Audio Request] Loading MP3: $url');
    try {
      final audioSource = AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: '${widget.surah.number}_${_currentAyah.number}',
          album: widget.surah.name,
          title: widget.locale == 'ar' ? 'الآية ${_currentAyah.numberInSurah}' : 'Ayah ${_currentAyah.numberInSurah}',
          artist: widget.locale == 'ar' ? _selectedReciter.nameAr : _selectedReciter.nameEn,
        ),
      );
      await _audioPlayer.setAudioSource(audioSource);
      print('🟢 [Audio Success] MP3 Loaded successfully!');
      
      // Save last recitation state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_recited_surah', widget.surah.number);
      await prefs.setInt('last_recited_ayah', _currentAyah.numberInSurah);
      await prefs.setString('last_reciter_id', _selectedReciter.id);
      await prefs.setString('last_reciter_name_ar', _selectedReciter.nameAr);
      await prefs.setString('last_reciter_name_en', _selectedReciter.nameEn);

      if (autoPlay) {
        _audioPlayer.play();
      }
    } catch (e, stacktrace) {
      print('❌ [Audio Error] Failed to load MP3 for ${_selectedReciter.id}');
      print('🔥 [Audio Exception] $e');
      print('📉 [Audio Stacktrace] $stacktrace');
      
      if (mounted) {
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
    await _loadAudio(autoPlay: true);
  }

  void _playNextAyah() {
    final currentIndex = widget.surah.ayahs.indexWhere((a) => a.number == _currentAyah.number);
    if (currentIndex < widget.surah.ayahs.length - 1) {
      setState(() {
        _currentAyah = widget.surah.ayahs[currentIndex + 1];
      });
      _loadAudio(autoPlay: true);
    }
  }

  void _playPrevAyah() {
    final currentIndex = widget.surah.ayahs.indexWhere((a) => a.number == _currentAyah.number);
    if (currentIndex > 0) {
      setState(() {
        _currentAyah = widget.surah.ayahs[currentIndex - 1];
      });
      _loadAudio(autoPlay: true);
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isArabic = widget.locale == 'ar';
    
    // Main UI Colors from Theme
    final bgColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surfaceContainerHighest;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),
          
          // Reciter Info Card (Clickable to change)
          GestureDetector(
            onTap: _showReciterSelection,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isArabic ? _selectedReciter.nameAr : _selectedReciter.nameEn,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          isArabic ? _selectedReciter.narrationAr : _selectedReciter.narrationEn,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryColor.withOpacity(0.2),
                    child: Icon(Icons.person, color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Progress Slider
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              activeTrackColor: primaryColor,
              inactiveTrackColor: primaryColor.withOpacity(0.2),
              thumbColor: primaryColor,
              overlayColor: primaryColor.withOpacity(0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: _position.inMilliseconds.toDouble().clamp(0, _duration.inMilliseconds.toDouble()),
              min: 0.0,
              max: _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1.0,
              onChanged: (value) {
                _audioPlayer.seek(Duration(milliseconds: value.toInt()));
              },
            ),
          ),
          
          // Time Texts
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_position),
                  style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5), fontSize: 12),
                ),
                Text(
                  '-${_formatDuration(_duration - _position)}',
                  style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5), fontSize: 12),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Playback Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_next, size: 32),
                color: theme.colorScheme.onSurface,
                onPressed: _playNextAyah,
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: () {
                  if (_isPlaying) {
                    _audioPlayer.pause();
                  } else {
                    _audioPlayer.play();
                  }
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: theme.colorScheme.onPrimary,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: const Icon(Icons.skip_previous, size: 32),
                color: theme.colorScheme.onSurface,
                onPressed: _playPrevAyah,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Bottom Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Speed
              InkWell(
                onTap: () {
                  setState(() {
                    _playbackSpeed = _playbackSpeed == 1.0 ? 1.5 : (_playbackSpeed == 1.5 ? 2.0 : 1.0);
                    _audioPlayer.setSpeed(_playbackSpeed);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_playbackSpeed}x',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              // Volume
              IconButton(
                icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                onPressed: () {
                  setState(() {
                    _isMuted = !_isMuted;
                    _audioPlayer.setVolume(_isMuted ? 0.0 : 1.0);
                  });
                },
              ),
              // Repeat
              InkWell(
                onTap: () {
                  setState(() {
                    _isLooping = !_isLooping;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        isArabic ? 'تكرار' : 'Repeat',
                        style: TextStyle(
                          color: _isLooping ? primaryColor : theme.colorScheme.onSurface.withOpacity(0.8),
                          fontWeight: _isLooping ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.repeat,
                        size: 20,
                        color: _isLooping ? primaryColor : theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              ),
              // Lock Screen Info
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isArabic
                            ? 'تم تفعيل التلاوة في الخلفية، يمكنك قفل الشاشة الآن'
                            : 'Background play enabled. You can lock the screen now.',
                      ),
                      backgroundColor: primaryColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(
                  Icons.screen_lock_portrait_rounded,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Footer Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mosque, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic ? 'الآية الحالية' : 'Current Ayah',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${isArabic ? widget.surah.name : widget.surah.englishName} - ${isArabic ? 'آية' : 'Ayah'} ${_currentAyah.numberInSurah}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isPlaying)
                  const Icon(Icons.graphic_eq, color: Colors.white)
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showReciterSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final isArabic = widget.locale == 'ar';
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  isArabic ? 'اختر القارئ' : 'Select Reciter',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableReciters.length,
                  itemBuilder: (context, index) {
                    final reciter = availableReciters[index];
                    final isSelected = reciter.id == _selectedReciter.id;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                      ),
                      title: Text(isArabic ? reciter.nameAr : reciter.nameEn),
                      subtitle: Text(isArabic ? reciter.narrationAr : reciter.narrationEn),
                      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                      onTap: () {
                        Navigator.pop(context);
                        _changeReciter(reciter);
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
}
