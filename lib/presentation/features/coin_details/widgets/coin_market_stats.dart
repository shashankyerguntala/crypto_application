import 'package:final_l3/presentation/features/coin_details/widgets/grid_view_card.dart';
import 'package:flutter/material.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

class CoinMarketStats extends StatelessWidget {
  final CryptoEntity coin;

  const CoinMarketStats({required this.coin, super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Market Cap", "\$${coin.marketCap.toStringAsFixed(2)}"),
      ("Rank", "#${coin.marketCapRank}"),
      ("High (24h)", "\$${coin.high24h.toStringAsFixed(2)}"),
      ("Low (24h)", "\$${coin.low24h}"),
      ("1h Change", "${coin.priceChange1h.toStringAsFixed(2)}%"),
      ("24h Change", "${coin.priceChangePercentage24h}%"),
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

        return GridViewCard(title: title, value: value);
      },
    );
  }
}
