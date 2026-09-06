import 'package:dio/dio.dart';

class TafsirApiService {
  final Dio _dio;
  final String _ummahApiKey = 'umh_f54ec310a550c9fa871eca3bf54b1974df3a3906';
  
  TafsirApiService() : _dio = Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetches tafsir for a single Ayah from ummahapi.com or alquran.cloud
  Future<String?> getAyahTafsir(int surahNumber, int ayahNumberInSurah, String editionKey, bool isUmmahApi) async {
    try {
      if (isUmmahApi) {
        // ummahapi.com
        final url = 'https://ummahapi.com/api/tafsir/$editionKey/surah/$surahNumber/ayah/$ayahNumberInSurah';
        print('🌐 [UmmahAPI Request] GET $url');
        final response = await _dio.get(
          url,
          options: Options(
            headers: {'X-API-Key': _ummahApiKey},
          ),
        );
        
        if (response.statusCode == 200) {
          print('🟢 [UmmahAPI Success] Raw Response: ${response.data}');
          final responseData = response.data;
          
          // API might return 'success' or 'نجاح' or 'النجاح' depending on headers/translation
          final isSuccess = responseData['success'] == true || responseData['نجاح'] == true || responseData['النجاح'] == true;
          
          if (isSuccess) {
            final data = responseData['data'] ?? responseData['بيانات'];
            if (data != null) {
              // Try to find the text in various possible keys
              final tafsirObj = data['tafsir'];
              if (tafsirObj != null && tafsirObj['text'] != null) {
                 final text = tafsirObj['text'];
                 print('✅ [UmmahAPI Found Text in tafsir object]: $text');
                 return text;
              }
              
              final ayahs = data['ayahs'] ?? data['الآيات'];
              if (ayahs != null && ayahs.isNotEmpty) {
                 final text = ayahs[0]['text'] ?? ayahs[0]['النص'];
                 print('✅ [UmmahAPI Found Text in ayahs array]: $text');
                 return text;
              } else {
                 final text = data['text'] ?? data['النص'];
                 if (text != null) {
                   print('✅ [UmmahAPI Found Direct Text]: $text');
                   return text;
                 }
              }
            }
            print('⚠️ [UmmahAPI Warning] Success is true but could not extract text from data: $data');
          } else {
            print('⚠️ [UmmahAPI Warning] API returned success=false. Response: $responseData');
          }
        } else {
           print('❌ [UmmahAPI Error] Status code ${response.statusCode}');
        }
      } else {
        // api.alquran.cloud
        final url = 'https://api.alquran.cloud/v1/ayah/$surahNumber:$ayahNumberInSurah/$editionKey';
        print('🌐 [AlQuranCloud Request] GET $url');
        final response = await _dio.get(url);
        
        if (response.statusCode == 200 && response.data['data'] != null) {
          final text = response.data['data']['text'];
          print('🟢 [AlQuranCloud Success] Found Text');
          return text;
        } else {
          print('❌ [AlQuranCloud Error] Status code ${response.statusCode}, Response: ${response.data}');
        }
      }
    } catch (e, stacktrace) {
      print('🔥 [Tafsir Exception] $e');
      print('📉 [Tafsir Stacktrace] $stacktrace');
    }
    return null;
  }

  /// Fetches tafsir for an entire Surah from alquran.cloud
  Future<List<String>?> getSurahTafsir(int surahNumber, String editionKey) async {
    try {
      final url = 'https://api.alquran.cloud/v1/surah/$surahNumber/$editionKey';
      print('🌐 [AlQuranCloud Surah Request] GET $url');
      final response = await _dio.get(url);
      
      if (response.statusCode == 200 && response.data['data'] != null) {
        final ayahs = response.data['data']['ayahs'] as List;
        return ayahs.map((a) => a['text'].toString()).toList();
      } else {
        print('❌ [AlQuranCloud Error] Status code ${response.statusCode}');
      }
    } catch (e) {
      print('🔥 [Surah Tafsir Exception] $e');
    }
    return null;
  }
}
