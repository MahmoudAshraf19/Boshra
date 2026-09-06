import 'package:just_audio/just_audio.dart';

class GlobalAudioPlayer {
  static final AudioPlayer player = AudioPlayer();
}

class AudioService {
  final AudioPlayer _audioPlayer = GlobalAudioPlayer.player;

  AudioPlayer get player => _audioPlayer;

  /// Play audio from a URL.
  Future<void> playUrl(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  /// Pause current audio playback.
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// Stop current audio playback and reset.
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  /// Play a playlist of URLs (e.g. all ayahs in a Surah).
  Future<void> playPlaylist(List<String> urls) async {
    try {
      final playlist = ConcatenatingAudioSource(
        children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
      );
      await _audioPlayer.setAudioSource(playlist);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing playlist: $e");
    }
  }

  /// Dispose the player when done.
  void dispose() {
    _audioPlayer.stop();
  }
}
