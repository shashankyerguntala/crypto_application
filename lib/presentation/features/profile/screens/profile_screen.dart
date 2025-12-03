import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/themes/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = "user@example.com";

    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.profile), centerTitle: true),

      body: ListView(
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
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 28),
          const Divider(),

          const SizedBox(height: 20),

          ValueListenableBuilder<bool>(
            valueListenable: ThemeController.isDarkMode,
            builder: (context, isDark, _) {
              return ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: Text(StringConstants.darkTheme),
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    ThemeController.isDarkMode.value = value;
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          ListTile(
            leading: Icon(Icons.logout, color: ColorConstants.error),
            title: Text(
              StringConstants.logout,
              style: TextStyle(color: ColorConstants.error),
            ),
            onTap: () => context.go(RoutesConstants.loginRoute),
          ),
        ],
      ),
    );
  }
}
