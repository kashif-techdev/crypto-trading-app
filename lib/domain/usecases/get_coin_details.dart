import '../entities/crypto_coin.dart';
import '../repositories/crypto_repository.dart';

class GetCoinDetails {
  final CryptoRepository repository;

  GetCoinDetails(this.repository);

  Future<CryptoCoin> call(String coinId) async {
    return await repository.getCoinDetails(coinId);
  }
}
