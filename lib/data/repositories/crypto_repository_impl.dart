import '../../domain/entities/crypto_coin.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_api_service.dart';
import '../models/crypto_coin_model.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoApiService _apiService;

  CryptoRepositoryImpl(this._apiService);

  @override
  Future<List<CryptoCoin>> getTopCoins({int limit = 20}) async {
    try {
      final List<CryptoCoinModel> coins = await _apiService.getTopCoins(limit: limit);
      return coins;
    } catch (e) {
      throw Exception('Failed to get top coins: $e');
    }
  }

  @override
  Future<CryptoCoin> getCoinDetails(String coinId) async {
    try {
      final CryptoCoinModel coin = await _apiService.getCoinDetails(coinId);
      return coin;
    } catch (e) {
      throw Exception('Failed to get coin details: $e');
    }
  }
}
