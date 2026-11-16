import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_logger.dart';

/// Gold / silver prices in the user's currency.
///
/// Spot prices (USD per troy ounce) come from free, key-less public endpoints, with a second
/// provider as fallback; exchange rates likewise. Everything is cached, and the user can always
/// type his own local price per gram (local jeweller prices differ from spot × exchange rate —
/// especially where the official rate differs from the market rate), which then takes priority.
class MetalPrices {
  final double goldUsdOz;
  final double silverUsdOz;
  final Map<String, double> rates; // USD → currency
  final DateTime fetchedAt;
  const MetalPrices(this.goldUsdOz, this.silverUsdOz, this.rates, this.fetchedAt);

  static const _ozGrams = 31.1034768;

  double? gram24(String currency) {
    final fx = currency == 'USD' ? 1.0 : rates[currency];
    return fx == null ? null : goldUsdOz / _ozGrams * fx;
  }

  double? silverGram(String currency) {
    final fx = currency == 'USD' ? 1.0 : rates[currency];
    return fx == null ? null : silverUsdOz / _ozGrams * fx;
  }

  Map<String, dynamic> toJson() => {
        'g': goldUsdOz,
        's': silverUsdOz,
        'r': rates,
        't': fetchedAt.millisecondsSinceEpoch,
      };

  factory MetalPrices.fromJson(Map<String, dynamic> j) => MetalPrices(
        (j['g'] as num).toDouble(),
        (j['s'] as num).toDouble(),
        (j['r'] as Map).map((k, v) => MapEntry('$k', (v as num).toDouble())),
        DateTime.fromMillisecondsSinceEpoch(j['t'] as int),
      );
}

class MetalPricesService {
  static const _cacheKey = 'zakat_prices_v1';

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
    headers: {'User-Agent': 'Mozilla/5.0 (Boshra app)', 'Accept': 'application/json'},
  ));

  Future<MetalPrices?> cached() async {
    try {
      final p = await SharedPreferences.getInstance();
      final raw = p.getString(_cacheKey);
      if (raw == null) return null;
      return MetalPrices.fromJson((jsonDecode(raw) as Map).cast<String, dynamic>());
    } catch (_) {
      return null;
    }
  }

  /// Fresh prices, or the cache (flagged by an old [MetalPrices.fetchedAt]) when offline.
  Future<MetalPrices?> fetch() async {
    double? gold, silver;
    // 1) gold-api.com
    try {
      final g = await _dio.get('https://api.gold-api.com/price/XAU');
      final s = await _dio.get('https://api.gold-api.com/price/XAG');
      gold = (g.data['price'] as num?)?.toDouble();
      silver = (s.data['price'] as num?)?.toDouble();
    } catch (e) {
      appLog('gold-api failed: $e');
    }
    // 2) goldprice.org
    if (gold == null || silver == null) {
      try {
        final r = await _dio.get('https://data-asg.goldprice.org/dbXRates/USD');
        final item = (r.data['items'] as List).first as Map;
        gold ??= (item['xauPrice'] as num?)?.toDouble();
        silver ??= (item['xagPrice'] as num?)?.toDouble();
      } catch (e) {
        appLog('goldprice.org failed: $e');
      }
    }
    // exchange rates
    Map<String, double>? rates;
    for (final url in const ['https://open.er-api.com/v6/latest/USD', 'https://api.exchangerate-api.com/v4/latest/USD']) {
      try {
        final r = await _dio.get(url);
        final m = (r.data['rates'] as Map?)?.map((k, v) => MapEntry('$k', (v as num).toDouble()));
        if (m != null && m.isNotEmpty) {
          rates = m;
          break;
        }
      } catch (e) {
        appLog('fx failed ($url): $e');
      }
    }
    if (gold == null || silver == null || rates == null) return cached();
    final fresh = MetalPrices(gold, silver, rates, DateTime.now());
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_cacheKey, jsonEncode(fresh.toJson()));
    } catch (_) {}
    return fresh;
  }
}
