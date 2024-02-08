import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Screens/settings_page/ChangePass.dart';
import 'package:realpalooza/Screens/settings_page/PrivacyAndSecurity.dart';
import 'package:realpalooza/Screens/settings_page/Social.dart';

import '../Theme/theme_provider.dart';
import '../pages/notification.dart';
import 'chatPage.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  List<bool> switchValues = [true, true, false];
  String _selectedLanguage = 'English';
  void _onLanguageChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedLanguage = newValue;
      });
    }
  }// Switch values list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
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
                  ? Colors.white.withOpacity(.8)
                  : Colors.grey[800],
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage();
                },
              ),
            );
          },
          icon: (Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.chat_bubble_outlined
                : Icons.chat_bubble_outline,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(.8)
                : Colors.grey[800],
          )),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            // Account Section
            buildSectionHeader("Account"),
            Divider(
              thickness: 0.9,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password", 1),
            buildAccountOptionRow(context, "Theme", 2),
            buildAccountOptionRow(context, "Social", 3),
            buildAccountOptionRow(context, "Language", 4),
            buildAccountOptionRow(context, "Privacy and security", 5),
            SizedBox(
              height: 40,
            ),
            // Notification Section
            buildSectionHeader("Notifications"),
            Divider(
              thickness: 0.9,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New for you", 0),
            const SizedBox(height: 15,),
            buildNotificationOptionRow("Account activity", 1),
            const SizedBox(height: 15,),
            buildNotificationOptionRow("Opportunity", 2),
            const SizedBox(height: 15,),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSectionHeader(String title) {
    return Row(
      children: [
        Icon(
          Icons.person,
          color: Colors.green,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comfortaa',
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, int key) {
    return GestureDetector(
      onTap: () {
        if (title == "Change password") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordPage(),
            ),
          );
        } else if (title == "Theme") {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        } else if (title == "Social") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SocialPage(),
            ),
          );
        } else if (title == "Language") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Language'),
                content: DropdownButton<String>(
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
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {
                      _onLanguageChanged;
                      Navigator.of(context).pop();
                    },
                    child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.black),),
                  ),
                ],
              );
            },
          );
        }
        else if(title=="Privacy and security"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PrivacySafetyPage(),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Comfortaa'),
            ),
            if (title != "Language" && title != "Theme") // Show dropdown only if it's not language option
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ),
            if (title == "Language") // Show dropdown if it's language option
              Icon(
                Icons.arrow_drop_down,
                color: Colors.green,
              ),
            if (title == "Theme")
              Icon(
                Icons.light_mode_outlined,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }


  Row buildNotificationOptionRow(String title, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Comfortaa'),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: switchValues[index],
            onChanged: (value) {
              setState(() {
                switchValues[index] = value;
                if(switchValues[index]){
                  if(index==0) {
                     print('1');
                     NotificationManager.showNotification(
                         title: 'New for you',
                         body: 'you have a new notification',
                         payload: {
                           "navigate":"true",
                         },
                         actionButtons: [
                           NotificationActionButton(
                             key: 'check',
                             label: 'check it out',
                             actionType: ActionType.SilentAction,
                             color: Colors.green,
                           )
                         ]);
                     NotificationManager.setNotificationListeners();
                  }
                  else if(index==1){
                    print('1');
                    NotificationManager.showNotification(
                        title: 'Account activity',
                        body: 'Check your account',
                        payload: {
                          "navigate":"true",
                        },
                        actionButtons: [
                          NotificationActionButton(
                            key: 'check',
                            label: 'check it out',
                            actionType: ActionType.SilentAction,
                            color: Colors.green,
                          )
                        ]);
                    NotificationManager.setNotificationListeners();
                  }
                  else if(index==2){
                    print('1');
                    NotificationManager.showNotification(
                        title: 'Opportunity',
                        body: 'Are you looking for opportunities?',
                        payload: {
                          "navigate":"true",
                        },
                        actionButtons: [
                          NotificationActionButton(
                            key: 'check',
                            label: 'check it out',
                            actionType: ActionType.SilentAction,
                            color: Colors.green,
                          )
                        ]);
                  }
                }
              });
            },
          ),
        )
      ],
    );
  }
}
