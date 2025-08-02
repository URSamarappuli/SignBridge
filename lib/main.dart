import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_project/screens/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Language Translator',,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      home: SplashScreen(),
      // home: GetStartedScreen(), // Removed as MaterialApp.router does not support 'home'
    );
  }
}
