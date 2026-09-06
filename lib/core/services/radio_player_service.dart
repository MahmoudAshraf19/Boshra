import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../features/radio/data/models/radio_model.dart';

class RadioPlayerService {
  // Singleton instance
  static final RadioPlayerService _instance = RadioPlayerService._internal();
  factory RadioPlayerService() => _instance;
  RadioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();
  RadioModel? _currentRadio;

  AudioPlayer get player => _player;
  RadioModel? get currentRadio => _currentRadio;

  /// Starts playing a radio stream and configures the background media notification
  Future<void> playRadio(RadioModel radio) async {
    try {
      if (_currentRadio?.id == radio.id && _player.playing) {
        return; // Already playing this radio
      }
      
      _currentRadio = radio;
      
      // Set the audio source with MediaItem for background playback
      final audioSource = AudioSource.uri(
        Uri.parse(radio.url),
        tag: MediaItem(
          id: radio.id.toString(),
          album: 'Boshra Live Radio',
          title: radio.name,
          artUri: Uri.parse(radio.img),
        ),
      );

      await _player.setAudioSource(audioSource);
      await _player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }
  
  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  void dispose() {
    _player.dispose();
  }
}
