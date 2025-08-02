import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  double _fontSize = 18.0; // Default font size
  String _selectedFont = 'Poppins'; // Default font
  String _selectedTheme = 'Light'; // Default theme

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Appearance',
          style: appbartitlestyle, // Custom Navy Blue color
        ),
        backgroundColor: Colors.white, // White background for app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            // Theme Selection
            Text(
              'Theme',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080)), // Custom Navy Blue color
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTheme = 'Light';
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue[50],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 70,
                        child: Text(
                          'Light',
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Color(0xFF000080)), // Custom Navy Blue color
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTheme = 'Dark';
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue[900],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 70,
                        child: Text(
                          'Dark',
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Color(0xFF000080)), // Custom Navy Blue color
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Text Settings
            Text(
              'Text',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080)), // Custom Navy Blue color
            ),
            SizedBox(height: 15),
            Text(
              'Font Size: ${_fontSize.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080)), // Custom Navy Blue color
            ),
            Slider(
              value: _fontSize,
              min: 10.0,
              max: 30.0,
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Font Selection
            Text(
              'Select Font',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080)), // Custom Navy Blue color
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF000080),
                    width: 1), // Custom Navy Blue color
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: _selectedFont,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFont = newValue!;
                  });
                },
                items: <String>['Poppins', 'Roboto', 'Arial', 'Times New Roman']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color:
                                Color(0xFF000080))), // Custom Navy Blue color
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),

            // Bottom Navigation Bar with buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for User Guide
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Use backgroundColor instead of primary
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize:
                        Size(150, 60), // Set width and height to be the same
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for Save
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Use backgroundColor instead of primary
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize:
                        Size(150, 60), // Set width and height to be the same
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
