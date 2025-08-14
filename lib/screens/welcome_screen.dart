import 'package:flutter/material.dart';
import 'package:fyp_project/screens/auth__screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Add SingleChildScrollView to prevent overflow
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Background Circles with size constraints
              SizedBox(
                width: double.infinity,
                height:
                    250, // Set the height for the Stack to avoid layout issues
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      left: -50,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.blue[100],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 100,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.blue[50],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 1.8,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/AppLogo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Title Text
              Center(
                child: Text(
                  'Gets things with Sign Bridge',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Description Text
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20), // Add padding here
                child: Text(
                  "Welcome to SignBridge where communication meets accessibility. Our app empowers seamless interaction by converting sign language into text and transforming text into expressive sign language avatars. Whether you're deaf, hard of hearing, or simply want to connect better, we're here to bridge the gap. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[600],
                  ),
                ),
              ),
              SizedBox(height: 35),

              // Get Started Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => AuthScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button background color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
