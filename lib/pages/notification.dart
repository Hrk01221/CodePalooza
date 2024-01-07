import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/pages/notification_controller.dart';
class NotificationManager {
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ], channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ]);
    bool isAllowedToSendNotification =
    await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static void setNotificationListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
      NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
      NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
      NotificationController.onDismissActionReceivedMethod,
    );
  }

  static void showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: "Hello world!",
        body: "Yay! I have local notifications working now!",
      ),
    );
  }
}

/*void main() async {
  await NotificationManager.initializeNotifications();
  NotificationManager.setNotificationListeners();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NotificationManager.showNotification();
          },
          child: Icon(
            Icons.notification_add,
          ),
        ),
      ),
    );
  }
}*/
