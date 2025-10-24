// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinModel _$CryptoCoinModelFromJson(Map<String, dynamic> json) =>
    CryptoCoinModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      volume24h: (json['volume24h'] as num).toDouble(),
      priceChange24h: (json['priceChange24h'] as num).toDouble(),
      priceChangePercentage24h: (json['priceChangePercentage24h'] as num)
          .toDouble(),
      imageUrl: json['imageUrl'] as String,
      marketCapRank: (json['marketCapRank'] as num).toInt(),
    );

Map<String, dynamic> _$CryptoCoinModelToJson(CryptoCoinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'currentPrice': instance.currentPrice,
      'marketCap': instance.marketCap,
      'volume24h': instance.volume24h,
      'priceChange24h': instance.priceChange24h,
      'priceChangePercentage24h': instance.priceChangePercentage24h,
      'imageUrl': instance.imageUrl,
      'marketCapRank': instance.marketCapRank,
    };
