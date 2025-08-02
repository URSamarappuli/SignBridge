import 'package:flutter/material.dart';
import 'package:fyp_project/screens/login_screen.dart';
import 'package:fyp_project/screens/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  //initializing show login page
  bool showLoginScreen = true;

  //function to toggle between login and register page
  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onPressed: toggleScreens);
    } else {
      return RegisterScreen(onPressed: toggleScreens);
    }
  }
}
