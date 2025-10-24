import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crypto_coin.dart';

class CryptoCoinCard extends StatelessWidget {
  final CryptoCoin coin;

  const CryptoCoinCard({
    super.key,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final priceColor = isPositive ? Colors.green : Colors.red;
    final priceIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank and Image
            Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '#${coin.marketCapRank}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    coin.imageUrl,
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.currency_bitcoin,
                          size: 20,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            
            // Coin Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coin.symbol.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            
            // Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${NumberFormat('#,##0.00').format(coin.currentPrice)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      priceIcon,
                      size: 16,
                      color: priceColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: priceColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
