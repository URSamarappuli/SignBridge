import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color guideTextColor = const Color(0xFF003466);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004E98)),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: Text(
          'User Guide',
          style: appbartitlestyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              '📌 Welcome to Sign Bridge!',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your personal assistant for real-time Sign Language translation. This guide will help you understand how to use the app efficiently.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '📜 Getting Started',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Launch the App – Open the app and select your preferred mode:\n\n'
              '• Sign to Text (Convert sign language gestures to text)\n'
              '• Text to Sign (Convert text into sign language animations)\n'
              '• User Guide (View this guide anytime)',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 10),
            Text(
              'Grant Permissions – Allow Camera & Storage access for sign detection.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '🖐 Sign to Text (Gesture Recognition)',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '📸 Steps to Translate Sign Language to Text:\n\n'
              '• Tap “Start Translation” to activate the camera.\n'
              '• Position your hands clearly in front of the camera.\n'
              '• The app recognizes your gestures and displays text in real-time.\n'
              '• Tap “Stop” when finished.\n'
              '• Copy or share the translated text if needed.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 10),
            Text(
              '📌 Tips:\n'
              '✅ Ensure good lighting for better gesture recognition.\n'
              '✅ Keep hands within the camera frame.\n'
              '✅ Use clear and defined gestures.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '🔡 Text to Sign (Text-to-Gesture Animation)',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '💬 Convert typed text into sign language animations:\n\n'
              '• Enter text in the input box.\n'
              '• Tap “Translate” to convert text into sign animations.\n'
              '• The app will display a sign language avatar demonstrating the translation.\n'
              '• Tap “Replay” to view the animation again.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 10),
            Text(
              '📌 Tips:\n'
              '✅ Use simple and clear sentences for better translations.\n'
              '✅ Check internet connectivity (if cloud-based animations are used).',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '⚙ Settings & Customization',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Language Selection – Choose your preferred language for translations.\n'
              '• Gesture Sensitivity – Adjust how the app detects and interprets signs.\n'
              '• Dark Mode – Toggle between light and dark themes for comfort.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '❓ Need Help?',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: guideTextColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Tap the Help button anytime for quick FAQs.\n'
              '• Visit our Support Page for troubleshooting.\n'
              '• Contact 22UG1-0465@gmail.com for further assistance.',
              style: GoogleFonts.poppins(fontSize: 16, color: guideTextColor),
            ),
            SizedBox(height: 20),
            Text(
              '✅ Enjoy seamless communication with Sign Bridge!',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0099A3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
