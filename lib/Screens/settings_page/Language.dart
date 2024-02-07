import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Theme/theme_provider.dart';
import '../base_screen.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguagePage> {
  String _selectedLanguage = 'English'; // Default language

  void _onLanguageChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedLanguage = newValue;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title:  Center(
            child: Text('Social',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.dark_mode_outlined,
                color: Theme.of(context).brightness == Brightness.dark
                    ?Colors.white.withOpacity(.8)
                    :Colors.grey[800],
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen(
                  selectedIndex: 3,
                )),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select Your Preferred Language:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: _onLanguageChanged,
                items: <String>['English', 'Spanish', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Selected Language: $_selectedLanguage',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
