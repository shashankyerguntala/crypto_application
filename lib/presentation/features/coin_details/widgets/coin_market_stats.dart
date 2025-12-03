import 'package:flutter/material.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

class CoinMarketStats extends StatelessWidget {
  final CryptoEntity coin;

  const CoinMarketStats({required this.coin, super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Market Cap", "\$${_fmt(coin.marketCap)}"),
      ("Rank", "#${coin.marketCapRank}"),
      ("High (24h)", "\$${coin.high24h.toStringAsFixed(2)}"),
      ("Low (24h)", "\$${coin.low24h.toStringAsFixed(2)}"),
      ("1h Change", "${coin.priceChange1h.toStringAsFixed(2)}%"),
      ("24h Change", "${coin.priceChangePercentage24h.toStringAsFixed(2)}%"),
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 80,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemBuilder: (_, i) {
        final (title, value) = items[i];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }

  String _fmt(double v) {
    if (v >= 1e12) {
      return "${(v / 1e12).toStringAsFixed(2)} T";
    }
    if (v >= 1e9) {
      return "${(v / 1e9).toStringAsFixed(2)} B";
    }
    if (v >= 1e6) {
      return "${(v / 1e6).toStringAsFixed(2)} M";
    }
    return v.toStringAsFixed(2);
  }
}
