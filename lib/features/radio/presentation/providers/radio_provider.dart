import 'package:flutter/material.dart';
import '../../../../core/services/radio_player_service.dart';
import '../../data/models/radio_model.dart';
import '../../data/repositories/radio_repository.dart';

class RadioProvider extends ChangeNotifier {
  final RadioRepository _repository = RadioRepository();
  final RadioPlayerService _playerService = RadioPlayerService();

  List<RadioModel> _radios = [];
  bool _isLoading = false;
  String? _error;
  RadioModel? _selectedRadio;

  List<RadioModel> get radios => _radios;
  bool get isLoading => _isLoading;
  String? get error => _error;
  RadioModel? get selectedRadio => _selectedRadio;
  
  // Expose player state
  bool get isPlaying => _playerService.player.playing;
  Stream<bool> get playingStream => _playerService.player.playingStream;
  
  double _volume = 1.0;
  double get volume => _volume;

  RadioProvider() {
    _playerService.player.playingStream.listen((_) {
      notifyListeners();
    });
  }

  Future<void> loadRadios() async {
    if (_radios.isNotEmpty) return;
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _radios = await _repository.getRadios();
      // If we want a default selected radio
      if (_radios.isNotEmpty && _selectedRadio == null) {
        _selectedRadio = _radios.first;
      }
    } catch (e) {
      _error = 'حدث خطأ أثناء جلب الإذاعات';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectRadio(RadioModel radio) {
    _selectedRadio = radio;
    notifyListeners();
  }

  Future<void> playSelectedRadio() async {
    if (_selectedRadio != null) {
      await _playerService.playRadio(_selectedRadio!);
    }
  }

  Future<void> playSpecificRadio(RadioModel radio) async {
    _selectedRadio = radio;
    notifyListeners();
    await _playerService.playRadio(radio);
  }

  Future<void> togglePlayPause() async {
    await _playerService.togglePlayPause();
  }

  Future<void> nextRadio() async {
    if (_radios.isEmpty || _selectedRadio == null) return;
    int currentIndex = _radios.indexOf(_selectedRadio!);
    int nextIndex = (currentIndex + 1) % _radios.length;
    await playSpecificRadio(_radios[nextIndex]);
  }

  Future<void> previousRadio() async {
    if (_radios.isEmpty || _selectedRadio == null) return;
    int currentIndex = _radios.indexOf(_selectedRadio!);
    int prevIndex = (currentIndex - 1 < 0) ? _radios.length - 1 : currentIndex - 1;
    await playSpecificRadio(_radios[prevIndex]);
  }

  void setVolume(double value) {
    _volume = value;
    _playerService.player.setVolume(value);
    notifyListeners();
  }
}
