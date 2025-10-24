import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double marketCap;
  final double volume24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final String imageUrl;
  final int marketCapRank;

  const CryptoCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.marketCap,
    required this.volume24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.imageUrl,
    required this.marketCapRank,
  });

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        currentPrice,
        marketCap,
        volume24h,
        priceChange24h,
        priceChangePercentage24h,
        imageUrl,
        marketCapRank,
      ];

  CryptoCoin copyWith({
    String? id,
    String? symbol,
    String? name,
    double? currentPrice,
    double? marketCap,
    double? volume24h,
    double? priceChange24h,
    double? priceChangePercentage24h,
    String? imageUrl,
    int? marketCapRank,
  }) {
    return CryptoCoin(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      volume24h: volume24h ?? this.volume24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      priceChangePercentage24h: priceChangePercentage24h ?? this.priceChangePercentage24h,
      imageUrl: imageUrl ?? this.imageUrl,
      marketCapRank: marketCapRank ?? this.marketCapRank,
    );
  }
}
