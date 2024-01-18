import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/main.dart';
import 'package:realpalooza/pages/notification.dart';

import '../Screens/settings.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    /*await AwesomeNotifications().createNotification(content: NotificationContent(
      id: 1,
      channelKey: "basic_channel",
      title: "Hello world!",
      body: "Yay! I have local notifications working now!",
    ),);*/
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload= receivedAction.payload??{};
    if(payload["navigate"]=="true"){
      NotificationManager.navigatorKey.currentState?.push(
        MaterialPageRoute(
            builder: (_)=> SecondScreen(),
        ),
      );
    }
    /*NotificationManager.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);*/

  }
}

class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Colors.grey[200]!,
            ],
          )
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              AppBar(title:Text("Second Screen")),
              Spacer(),
              Center(
                child: Text("Navigation from notification"),
              )
            ],
          ),
        ),
      ),
    );
  }
}