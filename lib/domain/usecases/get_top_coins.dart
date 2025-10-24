import '../entities/crypto_coin.dart';
import '../repositories/crypto_repository.dart';

class GetTopCoins {
  final CryptoRepository repository;

  GetTopCoins(this.repository);

  Future<List<CryptoCoin>> call({int limit = 20}) async {
    return await repository.getTopCoins(limit: limit);
  }
}
