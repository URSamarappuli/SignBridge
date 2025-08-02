// File: app_language.dart
// Description: This file contains the implementation of the LanguageScreen widget,
import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage = 'Sinhala'; // Default value for selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Language', style: appbartitlestyle),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            // Suggested section
            Text(
              'Suggested',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Sinhala'),
              trailing:
                  _selectedLanguage == 'Sinhala' ? Icon(Icons.check) : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Sinhala';
                });
              },
            ),
            ListTile(
              title: Text('English (United State)'),
              trailing: _selectedLanguage == 'English (United state)'
                  ? Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English (United state)';
                });
              },
            ),
            SizedBox(height: 20),

            // All languages section
            Text(
              'All Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Language Option 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Language Option 2'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Language Option 3'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
