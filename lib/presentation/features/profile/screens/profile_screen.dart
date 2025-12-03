import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/helper_functions.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/core/themes/theme_controller.dart';
import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Di.di<ProfileBloc>()..add(LoadProfile()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.profile,
          style: AppTextStyles.headlineMedium.copyWith(
            color: ColorConstants.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
      ),

      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoggedOut) {
            HelperFunctions.showSnackBar(state.msg, context, isError: false);
          }

          if (state is ProfileError) {
            return Center(
              child: Text(
                state.msg,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: ColorConstants.error,
                ),
              ),
            );
          }

          final email = (state as ProfileLoaded).email;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),

              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: ColorConstants.primary.withAlpha(15),
                  child: Icon(
                    Icons.person,
                    size: 52,
                    color: ColorConstants.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 28),
              Divider(color: ColorConstants.grey.withAlpha(40)),
              const SizedBox(height: 20),

              ValueListenableBuilder<bool>(
                valueListenable: ThemeController.isDarkMode,
                builder: (_, isDark, _) {
                  return ListTile(
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: ColorConstants.primary,
                    ),
                    title: Text(
                      StringConstants.darkTheme,
                      style: AppTextStyles.bodyLarge,
                    ),
                    trailing: Switch(
                      value: isDark,

                      onChanged: (value) =>
                          ThemeController.isDarkMode.value = value,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              ListTile(
                leading: Icon(Icons.logout, color: ColorConstants.error),
                title: Text(
                  StringConstants.logout,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: ColorConstants.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => context.go(RoutesConstants.loginRoute),
              ),
            ],
          );
        },
      ),
    );
  }
}
