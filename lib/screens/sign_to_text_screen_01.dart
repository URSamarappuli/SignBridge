import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:fyp_project/screens/home_screen.dart';
import 'package:fyp_project/screens/sign_to_text_screen_02.dart';

class SignToTextTranslateScreen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign To Text Translate', style: appbartitlestyle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004E98)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            // Action for back button
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Live Translation Button
            SizedBox(
              height: 150,
              width: 300,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignToTextScreen02(),
                    ),
                  ); // Action for Live Translation button
                },
                icon: Icon(
                  Icons.video_call,
                  color: iconcolour,
                  size: 40,
                ), // Video icon
                label: Text('Live Translation',
                    style: TextStyle(
                      fontSize: 20,
                      color: texticonColor,
                      fontWeight: FontWeight.bold,
                    )),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: boxfilcolor, // Icon and text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: boxborder,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
