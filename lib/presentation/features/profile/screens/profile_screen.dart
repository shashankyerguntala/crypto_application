import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
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
              radius: 45,
              backgroundColor: ColorConstants.primary.withAlpha(15),
              child: Icon(
                Icons.person,
                size: 55,
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

          const SizedBox(height: 30),
          const Divider(),

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("Dark Theme"),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
