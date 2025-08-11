import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/screens/profilePage/update_profile_screen.dart'; // Make sure this path is correct

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  bool _isLoading = true;

  // Use a listener for real-time updates for a single document
  Stream<DocumentSnapshot>? _userDocStream;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Fetching user data by document ID (UID)
        _userDocStream = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid) // Directly access document by UID
            .snapshots();

        _userDocStream!.listen((userDoc) {
          if (userDoc.exists) {
            Map<String, dynamic> userData =
                userDoc.data() as Map<String, dynamic>;
            setState(() {
              _fullName = userData['fullName'] ?? 'N/A';
              _email = userData['email'] ?? 'N/A';
              _phoneNumber = userData['phoneNumber'] ?? 'N/A';
              _isLoading = false;
            });
          } else {
            setState(() {
              _fullName = 'N/A';
              _email = currentUser.email ??
                  'N/A'; // Still show the email if available
              _phoneNumber = 'N/A';
              _isLoading = false;
            });
            print('User document for UID ${currentUser.uid} does not exist.');
          }
        });
      } else {
        setState(() {
          _isLoading = false; // Set loading to false if no user is available
          _fullName = 'Not logged in';
          _email = 'Not logged in';
          _phoneNumber = 'Not logged in';
        });
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
        _fullName = 'Error';
        _email = 'Error';
        _phoneNumber = 'Error';
      });
    }
  }

  Future<void> _confirmLogout() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // Dismiss and return false
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // Dismiss and return true
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _logout();
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to your login/authentication screen after logout
      // Replace '/login' with your actual login route
      Navigator.of(context).pushReplacementNamed('/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully!')),
      );
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              onPressed: _confirmLogout,
              icon: const Icon(Icons.logout, color: Colors.white),
              label:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            // This icon doesn't do anything on this read-only page
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildDisplayField(
                    label: 'Full Name',
                    value: _fullName,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  _buildDisplayField(
                    label: 'Email',
                    value: _email,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 15),
                  _buildDisplayField(
                    label: 'Phone Number',
                    value: _phoneNumber,
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Update Profile',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDisplayField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue.shade700),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
