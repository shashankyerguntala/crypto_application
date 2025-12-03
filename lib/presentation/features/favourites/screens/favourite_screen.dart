import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/presentation/features/dashboard/widgets/custom_dialogue_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/presentation/features/favourites/bloc/favourites_bloc.dart';
import 'package:final_l3/presentation/features/dashboard/widgets/crypto_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Di.di<FavouritesBloc>()..add(LoadFavouritesEvent()),
      child: const FavouriteView(),
    );
  }
}

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.favourites,
          style: AppTextStyles.headlineMedium.copyWith(
            color: ColorConstants.white,
          ),
        ),
        backgroundColor: ColorConstants.primary,
        elevation: 2,
      ),

      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavouritesError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: ColorConstants.error,
                ),
              ),
            );
          }

          if (state is FavouritesLoaded) {
            final coins = state.coins;

            if (coins.isEmpty) {
              return Center(
                child: Text(
                  StringConstants.noFavYet,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: ColorConstants.primary,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: coins.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final coin = coins[index];

                return CryptoCard(
                  coin: coin,
                  favoriteScreen: true,
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => CustomDialogBox(
                        title: StringConstants.removeFavourite,
                        message: StringConstants.areuSureWantToRemove,
                      ),
                    );

                    if (confirm == true) {
                      context.read<FavouritesBloc>().add(
                        RemoveFavouriteEvent(coin.id),
                      );
                    }
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
