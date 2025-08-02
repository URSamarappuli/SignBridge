import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/screens/mainscreen.dart';
import 'package:fyp_project/screens/login_or_register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //if user is Login
        if (snapshot.hasData) {
          return Mainscreen();
        } else {
          // Return a placeholder widget or loading indicator
          return LoginOrRegisterScreen();
        }
      },
    ));
  }
}
