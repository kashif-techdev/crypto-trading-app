import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_coin_model.dart';

class CryptoApiService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';
  
  Future<List<CryptoCoinModel>> getTopCoins({int limit = 20}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$limit&page=1&sparkline=false'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => CryptoCoinModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load crypto data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load crypto data: $e');
    }
  }

  Future<CryptoCoinModel> getCoinDetails(String coinId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/coins/$coinId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return CryptoCoinModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load coin details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load coin details: $e');
    }
  }
}
