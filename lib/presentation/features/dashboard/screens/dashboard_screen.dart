import 'package:final_l3/domain/entity/coin_entity.dart';
import 'package:final_l3/presentation/features/dashboard/widgets/crypto_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //!
    final List<CryptoEntity> coins = [];
    return Scaffold(
      appBar: AppBar(title: const Text("Crypto"), elevation: 2),

      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: coins.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          return CryptoCard(coin: coins[i], onTap: () {});
        },
      ),
    );
  }
}
