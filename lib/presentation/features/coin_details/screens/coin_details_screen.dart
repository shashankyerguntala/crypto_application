import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/themes/custom_elevated_button.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_chart.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_details_header.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_market_stats.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_price_section.dart';
import 'package:flutter/material.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';

class CoinDetailsScreen extends StatelessWidget {
  final CryptoEntity cryptoEntity;

  const CoinDetailsScreen({required this.cryptoEntity, super.key});

  @override
  Widget build(BuildContext context) {
    final coin = cryptoEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.star_border)),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          CoinDetailsHeader(coin: coin),
          const SizedBox(height: 24),

          CoinPriceSection(coin: coin),
          const SizedBox(height: 28),

          const CoinChartPlaceholder(),
          const SizedBox(height: 30),

          Text(
            "Market Statistics",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          CoinMarketStats(coin: coin),
          const SizedBox(height: 30),

          CustomElevatedButton(
            label: StringConstants.favourites,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
