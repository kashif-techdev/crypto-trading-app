import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/crypto_coin.dart';

part 'crypto_coin_model.g.dart';

@JsonSerializable()
class CryptoCoinModel extends CryptoCoin {
  const CryptoCoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    @JsonKey(name: 'current_price') required super.currentPrice,
    @JsonKey(name: 'market_cap') required super.marketCap,
    @JsonKey(name: 'total_volume') required super.volume24h,
    @JsonKey(name: 'price_change_24h') required super.priceChange24h,
    @JsonKey(name: 'price_change_percentage_24h') required super.priceChangePercentage24h,
    @JsonKey(name: 'image') required super.imageUrl,
    @JsonKey(name: 'market_cap_rank') required super.marketCapRank,
  });

  factory CryptoCoinModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinModelToJson(this);
}
