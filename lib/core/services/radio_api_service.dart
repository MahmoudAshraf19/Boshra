import 'dart:convert';
import 'package:flutter/services.dart';
import '../network/dio_factory.dart';
import '../utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../../features/radio/data/models/radio_model.dart';

class RadioApiService {
  final Dio _dio;

  RadioApiService() : _dio = DioFactory.create() {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetches the list of all available radios.
  /// 1) Calls the mp3quran API.
  /// 2) Ensures Minshawi is always #1.
  /// 3) Eliminates any duplicate reciters.
  /// 4) Falls back to local bundled asset and backup APIs if network fails.
  Future<List<RadioModel>> getRadios({String language = 'ar'}) async {
    List<RadioModel> fetched = [];

    // 1. Try mp3quran API first
    try {
      final response = await _dio.get('https://mp3quran.net/api/v3/radios?language=$language');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        List radiosJson = [];
        if (data is Map && data.containsKey('radios')) {
          radiosJson = data['radios'] as List? ?? [];
        } else if (data is List) {
          radiosJson = data;
        }

        if (radiosJson.isNotEmpty) {
          fetched = radiosJson.map((r) => RadioModel.fromJson(r)).toList();
        }
      }
    } catch (e) {
      appLog('Error fetching radios from mp3quran: $e');
    }

    // 2. If mp3quran failed or empty, try data-rosy API as secondary fallback
    if (fetched.isEmpty) {
      try {
        final response = await _dio.get('https://data-rosy.vercel.app/radio.json');
        if (response.statusCode == 200 && response.data != null) {
          final data = response.data;
          List radiosJson = [];
          if (data is Map && data.containsKey('radios')) {
            radiosJson = data['radios'] as List? ?? [];
          } else if (data is List) {
            radiosJson = data;
          }
          if (radiosJson.isNotEmpty) {
            fetched = radiosJson.map((r) => RadioModel.fromJson(r)).toList();
          }
        }
      } catch (e) {
        appLog('Error fetching radios from backup API: $e');
      }
    }

    // 3. If remote fails completely, load the bundled offline list
    if (fetched.isEmpty) {
      fetched = await _loadBundledRadios();
    }

    // 4. Clean, deduplicate and ensure Minshawi is #1
    return _processAndDeduplicateRadios(fetched);
  }

  Future<List<RadioModel>> _loadBundledRadios() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/radios.json');
      final data = jsonDecode(jsonString);
      if (data is Map && data.containsKey('radios')) {
        final list = data['radios'] as List;
        return list.map((r) => RadioModel.fromJson(r)).toList();
      }
    } catch (e) {
      appLog('Error loading bundled radios: $e');
    }
    return [];
  }

  List<RadioModel> _processAndDeduplicateRadios(List<RadioModel> raw) {
    if (raw.isEmpty) return [];

    // Minshawi radio definition - always #1
    const minshawiUrl = 'https://backup.qurango.net/radio/mohammed_siddiq_alminshawi';
    const defaultImg = 'https://i1.sndcdn.com/artworks-000557434524-n96f92-t200x200.jpg';

    // Find minshawi img if present in raw list
    String minshawiImg = 'https://i1.sndcdn.com/artworks-000284633237-7gdg9t-t200x200.jpg';
    for (final r in raw) {
      if (r.name.contains('المنشاوي') && r.img.isNotEmpty) {
        minshawiImg = r.img;
        break;
      }
    }

    final minshawi = RadioModel(
      id: 1,
      name: 'محمد صديق المنشاوي',
      url: minshawiUrl,
      img: minshawiImg,
    );

    final List<RadioModel> result = [minshawi];
    final Set<String> seenUrls = {minshawi.url.trim()};
    final Set<String> seenNames = {_cleanName(minshawi.name)};

    for (final r in raw) {
      final url = r.url.trim();
      final name = r.name.trim();
      final clean = _cleanName(name);

      if (url.isEmpty || seenUrls.contains(url)) continue;
      if (seenNames.contains(clean)) continue;

      seenUrls.add(url);
      seenNames.add(clean);

      result.add(RadioModel(
        id: result.length + 1,
        name: name,
        url: url,
        img: r.img.isNotEmpty ? r.img : defaultImg,
      ));
    }

    return result;
  }

  String _cleanName(String n) {
    return n
        .replaceAll(RegExp(r'^إذاعة\s+'), '')
        .replaceAll(RegExp(r'^شيخ\s+'), '')
        .replaceAll(RegExp(r'^القارئ\s+'), '')
        .replaceAll(RegExp(r'[-–—]'), '')
        .trim();
  }
}
