import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:final_l3/presentation/features/dashboard/widgets/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Di.di<DashboardBloc>()..add(LoadDashboardData()),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.crypto,
          style: AppTextStyles.headlineMedium.copyWith(),
        ),
        elevation: 2,
      ),

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: ColorConstants.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<DashboardBloc>().add(LoadDashboardData()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primary,
                      foregroundColor: ColorConstants.white,
                    ),
                    child: Text(
                      StringConstants.retry,
                      style: AppTextStyles.label.copyWith(
                        color: ColorConstants.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded) {
            final coins = state.coins;

            return RefreshIndicator(
              color: ColorConstants.primary,
              onRefresh: () async {
                context.read<DashboardBloc>().add(RefreshDashboardData());
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: coins.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  return CryptoCard(
                    coin: coin,
                    onTap: () {
                      context.push(RoutesConstants.details, extra: coin);
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
