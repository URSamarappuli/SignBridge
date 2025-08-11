import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:fyp_project/screens/profilePage/profile_screen.dart';
import 'package:fyp_project/screens/sign_to_text_screen_01.dart';
import 'package:fyp_project/screens/text_to_sign_translate.dart';

class HomeScreen extends StatelessWidget {
  // Modified buildButton method to accept a navigation function
  Widget buildButton({
    required IconData leftIcon,
    required IconData rightIcon,
    required String text,
    required VoidCallback onPressed, // Added onPressed callback
  }) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: boxfilcolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: boxborder, width: 2),
      ),
      child: InkWell(
        // Wrapping with InkWell to make it clickable
        onTap: onPressed, // Trigger the passed onPressed function
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(leftIcon, color: Colors.blue, size: 50),
                SizedBox(width: 40),
                Icon(Icons.arrow_forward, color: Colors.blue, size: 60),
                SizedBox(width: 40),
                Icon(rightIcon, color: Colors.blue, size: 50),
              ],
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: texticonColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for floating nav bar over content
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Welcome + profile
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50, // Adjust height as needed
                    width: 50, // Adjust width as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/AppLogo.jpeg'),
                        fit: BoxFit.cover, // Adjust fit as needed
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                  // AppBar title
                  Text(
                    "Welcome!",
                    style: appbartitlestyle,
                  ),
                  Spacer(), // Pushes the profile icon to the right
                  // Profile icon button
                  IconButton(
                    onPressed: () {
                      // Navigate to ProfileScreen (assuming you have this screen)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(), // Replace with your screen
                        ),
                      );
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Centering the buttons in the middle of the screen
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centering buttons vertically
                  children: [
                    buildButton(
                      leftIcon: Icons.pan_tool,
                      rightIcon: Icons.text_fields,
                      text: 'Sign to text',
                      onPressed: () {
                        // Navigate to SignToTextTranslateScreen01
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignToTextTranslateScreen01(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    buildButton(
                      leftIcon: Icons.text_fields,
                      rightIcon: Icons.pan_tool,
                      text: 'Text to sign',
                      onPressed: () {
                        // Navigate to TextToSignScreen (assuming you have this screen)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TextToSignTranslate(), // Replace with your screen
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
