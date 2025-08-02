import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/sevices/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onPressed;
  const LoginScreen({super.key, required this.onPressed});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Show reusable error dialog
  void showErrorDialog(String title, String message) {
    Future.delayed(Duration(milliseconds: 200), () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              )
            ],
          );
        },
      );
    });
  }

  // Login method
  void logUserIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pop(context); // remove loading spinner
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // remove loading spinner

      if (e.code == 'user-not-found') {
        showErrorDialog('Incorrect Email', 'No user found with this email.');
      } else if (e.code == 'wrong-password') {
        showErrorDialog('Incorrect Password', 'The password is incorrect.');
      } else {
        showErrorDialog('Login Failed', e.message ?? 'Unknown error occurred.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      left: -50,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.blue[100],
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 125,
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/AppLogo.jpeg'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Welcome Back to Sign Bridge',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Let\'s help to meet up your tasks.',
                        style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Add forgot password flow
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blue[600]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: logUserIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(child: Divider()),
                        Text("OR Login with"),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()),
                          );
                          try {
                            await AuthService().signInWithGoogle();
                            Navigator.pop(context); // remove loading spinner
                          } catch (e) {
                            Navigator.pop(context); // remove loading spinner
                            showErrorDialog(
                                'Google Sign-In Failed', e.toString());
                          }
                        },
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 27.0,
                          width: 27.0,
                        ),
                        label: Text(
                          'Sign in with Google',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextButton(
                          onPressed: widget.onPressed,
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blue[600]),
                          ),
                        ),
                      ],
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
