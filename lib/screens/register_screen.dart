import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/sevices/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onPressed;
  const RegisterScreen({super.key, required this.onPressed});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // Text Controllers for the TextFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  // Register method
  void signUserUp() async {
    //Dialog box
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    //try creating the user
    try {
      //check if password and confirm password match
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        //add user details
        addUserDetails(
            _fullNameController.text.trim(),
            int.parse(_phoneNumberController.text.trim()),
            _emailController.text.trim(),
            _passwordController.text.trim());
      } else {
        //if password and confirm password do not match
        showErrorDialog('Error', 'Passwords do not match.');
      }

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

  Future addUserDetails(
      String fullName, int phoneNumber, String email, String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      "Password": password
    });
  }

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

              // Title Text
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Welcome to Onboard!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Subtitle Text
                    Center(
                      child: Text(
                        'Let\'s help to meet up your tasks.',
                        style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Full Name TextField
                    TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Email TextField
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

                    // Phone Number TextField
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password TextField
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
                    SizedBox(height: 20),

                    // Confirm Password TextField
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signUserUp,
                        // Action for Register
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue, // Button background color
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text("OR Register with"),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Google Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => AuthService().signInWithGoogle(),
                        // Add Google sign-in logic
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 27.0,
                          width: 27.0,
                        ),
                        label: Text(
                          'Sign Up with Google',
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

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'If you have an account?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            TextButton(
                              onPressed: widget.onPressed,
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue[600]),
                              ),
                            ),
                          ],
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
