import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

class CoinDetailsHeader extends StatelessWidget {
  final CryptoEntity coin;

  const CoinDetailsHeader({required this.coin, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: coin.image,
            height: 60,
            width: 60,
          ),
        ),
        const SizedBox(width: 16),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coin.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              coin.symbol.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
