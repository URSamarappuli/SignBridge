import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';

class AvatarAppearanceScreen extends StatefulWidget {
  @override
  _AvatarAppearanceScreenState createState() => _AvatarAppearanceScreenState();
}

class _AvatarAppearanceScreenState extends State<AvatarAppearanceScreen> {
  String _selectedGender = 'Male'; // Default gender
  Color _selectedColor = Colors.lightBlue; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Appearance', style: appbartitlestyle),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar icon (replace with your own image or avatar widget)
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/avatar.png'), // Replace with your image
              ),
            ),
            SizedBox(height: 40),

            // Gender Section
            Text('Gender',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenderOption('Male', Colors.blue),
                SizedBox(width: 40),
                _buildGenderOption('Female', Colors.pink),
              ],
            ),
            SizedBox(height: 50),

            // Colour Section
            Text('Colour',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColorOption(Colors.lightBlue),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.blue),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.black),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.indigo),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.green),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.red),
                  SizedBox(width: 10),
                  _buildColorOption(Colors.orange),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Buttons (Discard and Save)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Discard'),
                  SizedBox(width: 20),
                  _buildButton('Save'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Gender Option
  Widget _buildGenderOption(String gender, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              gender == 'Male' ? Icons.male : Icons.female,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(gender, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Widget for Color Option
  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color; // Update selected color when tapped
        });
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
      ),
    );
  }

  // Button Widget
  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Action for button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Use backgroundColor instead of primary
        minimumSize: Size(140, 60), // Set both width and height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // Bottom Navigation Item Widget
  Widget navItem(
      {required IconData icon, required String label, bool selected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: selected ? Colors.white : Colors.white,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
