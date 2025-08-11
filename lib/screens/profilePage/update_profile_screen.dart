import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // This fetches the user's current data
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _currentUser = FirebaseAuth.instance.currentUser;
      if (_currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser!.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          // Populating controllers with fetched data
          _fullNameController.text = userData['fullName'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _phoneController.text = userData['phoneNumber'] ?? '';
        } else {
          // If user document does not exist, set fields to empty and stop loading
          _fullNameController.text = '';
          _emailController.text =
              _currentUser!.email ?? ''; // Pre-fill email from auth
          _phoneController.text = '';
          print('User document does not exist for UID: ${_currentUser!.uid}');
        }
      } else {
        // If no user is currently logged in, stop loading
        _fullNameController.text = '';
        _emailController.text = '';
        _phoneController.text = '';
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Optionally show an error message to the user
    } finally {
      // Ensure loading is always set to false in the end
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserData() async {
    if (_currentUser == null) {
      print("No user logged in to update.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Cannot update profile: No user logged in.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .update({
        'fullName': _fullNameController.text, // Data from editable field
        // 'email': _emailController.text, // Email is typically not updated this way
        'phoneNumber': _phoneController.text, // Data from editable field
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context); // Go back to the profile screen after update
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                            // Handle profile picture edit
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildInputField(
                    controller: _fullNameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    hintText: 'Enter your full name',
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    hintText: 'Enter your new email',
                    keyboardType: TextInputType.emailAddress,
                    isReadOnly: true, // Email is read-only here
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _updateUserData, // This saves the changes
                      icon: const Icon(Icons.save),
                      label: const Text('Save Changes'),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isReadOnly = false,
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
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            readOnly: isReadOnly, // Controls editability
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blue.shade700),
              hintText: hintText,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
            style: TextStyle(
                fontSize: 16,
                color: isReadOnly ? Colors.grey.shade700 : Colors.black),
          ),
        ),
      ],
    );
  }
}
