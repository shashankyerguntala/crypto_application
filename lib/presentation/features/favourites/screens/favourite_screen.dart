import 'package:flutter/material.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:final_l3/presentation/features/dashboard/widgets/crypto_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<CryptoEntity> favouriteCoins = [
    CryptoEntity(
      id: "bitcoin",
      symbol: "btc",
      name: "Bitcoin",
      image:
          "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png",
      currentPrice: 90000,
      marketCap: 1000,
      marketCapRank: 1,
      high24h: 0,
      low24h: 0,
      priceChange24h: 0,
      priceChangePercentage24h: 2.5,
      priceChange1h: 0,
    ),
    CryptoEntity(
      id: "ethereum",
      symbol: "eth",
      name: "Ethereum",
      image:
          "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png",
      currentPrice: 3000,
      marketCap: 900,
      marketCapRank: 2,
      high24h: 0,
      low24h: 0,
      priceChange24h: 0,
      priceChangePercentage24h: -1.2,
      priceChange1h: 0,
    ),
  ];

  void removeCoin(int index) {
    setState(() {
      favouriteCoins.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourites")),
      body: favouriteCoins.isEmpty
          ? const Center(
              child: Text(
                "No Favourites Yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favouriteCoins.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final coin = favouriteCoins[index];

                return Stack(
                  children: [
                    CryptoCard(coin: coin, onTap: () {}),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => removeCoin(index),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
