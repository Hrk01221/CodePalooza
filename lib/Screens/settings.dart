import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/theme_provider.dart';
import '../pages/notification.dart';
import 'chatPage.dart';


class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
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
                    ?Colors.white.withOpacity(.8)
                    :Colors.grey[800],
              ),
            ),
          ],
          leading: IconButton(
            onPressed: (){

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage();
                  },
                ),
              );
            },
            icon: (
                Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.chat_bubble_outlined
                      : Icons.chat_bubble_outline,
                  color: Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                )
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationManager.showNotification(
                    title: 'Hello world',
                    body: 'this is my notification',
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
              },
              child: Text('Send Notifications',style: TextStyle(color: Color(0xff26b051)),
              ),
            ),
            // Add more settings widgets here as needed
          ],
        ),
      ),
    );
  }
}
