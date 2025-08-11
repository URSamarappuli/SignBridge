import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:fyp_project/screens/app_language.dart';
import 'package:fyp_project/screens/avatar_appearance.dart';
import 'package:fyp_project/screens/profilePage/profile_screen.dart';
import 'package:fyp_project/screens/theme_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go('/home'); // GoRouter-based navigation
          },
        ),
        title: Text(
          'Settings',
          style: appbartitlestyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            settingsButton(
              icon: Icons.palette,
              label: 'Customize avatar appearance',
              onPressed: () {
                // Navigate to SignToTextTranslateScreen01
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarAppearanceScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            settingsButton(
              icon: Icons.language,
              label: 'Language settings',
              onPressed: () {
                // Navigate to SignToTextTranslateScreen01
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            settingsButton(
              icon: Icons.wb_sunny_outlined,
              label: 'Theme',
              onPressed: () {
                // Navigate to SignToTextTranslateScreen01
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            settingsButton(
              icon: Icons.person,
              label: 'Edit Profile',
              onPressed: () {
                // Navigate to SignToTextTranslateScreen01
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: const Color(0xFF007AFF),
                size: 25,
              ),
              const SizedBox(width: 15),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
