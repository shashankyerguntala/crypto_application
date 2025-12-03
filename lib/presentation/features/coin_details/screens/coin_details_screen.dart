import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/core/themes/custom_elevated_button.dart';
import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/presentation/features/coin_details/bloc/coin_details_bloc.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_chart.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_details_header.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_market_stats.dart';
import 'package:final_l3/presentation/features/coin_details/widgets/coin_price_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetailsScreen extends StatelessWidget {
  final CryptoModel coin;

  const CoinDetailsScreen({required this.coin, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Di.di<CoinDetailsBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(coin.name), centerTitle: true),

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
              StringConstants.marketStats,
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 12),

            CoinMarketStats(coin: coin),
            const SizedBox(height: 30),

            BlocConsumer<CoinDetailsBloc, CoinDetailsState>(
              listener: (context, state) {
                if (state is FavouriteAddSuccess) {
                  HelperFunctions.showSnackBar(
                    StringConstants.favouritesAddSuccess,
                    context,
                    isError: false,
                  );
                  
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  isLoading: state is FavouriteAddLoading,
                  label: StringConstants.favourites,
                  onPressed: () => context.read<CoinDetailsBloc>().add(
                    AddToFavouritesEvent(coin),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
