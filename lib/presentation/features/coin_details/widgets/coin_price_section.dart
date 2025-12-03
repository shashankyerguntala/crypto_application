import 'package:flutter/material.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

class CoinPriceSection extends StatelessWidget {
  final CryptoEntity coin;

  const CoinPriceSection({required this.coin, super.key});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\$${coin.currentPrice.toStringAsFixed(2)}",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isPositive
                ? Colors.green.withAlpha(15)
                : Colors.red.withAlpha(15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "${coin.priceChangePercentage24h.toStringAsFixed(2)}%",
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
