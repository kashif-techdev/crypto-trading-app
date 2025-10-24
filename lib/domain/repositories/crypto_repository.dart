import '../entities/crypto_coin.dart';

abstract class CryptoRepository {
  Future<List<CryptoCoin>> getTopCoins({int limit = 20});
  Future<CryptoCoin> getCoinDetails(String coinId);
}
