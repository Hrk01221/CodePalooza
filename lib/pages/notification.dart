
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/pages/notification_controller.dart';

import '../Screens/settings.dart';
class NotificationManager {
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/app_icop',
         [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
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
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

  static void showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String,String>?payload,
    final ActionType actionType=ActionType.Default,
    final NotificationLayout= NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled=false,
    final int? interval,
}) async{
    assert(!scheduled||(scheduled&&interval!=null));

   await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: title,
        body: body,
        actionType: actionType,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
     actionButtons: actionButtons,
     schedule: scheduled
       ? NotificationInterval(
         interval: interval,
         timeZone:
         await AwesomeNotifications().getLocalTimeZoneIdentifier(),
       preciseAlarm: true,
     )
         :null,
    );
   setNotificationListeners();
  }
}


class MyNotificationPage extends StatelessWidget {
  final ReceivedAction receivedAction;

  MyNotificationPage({required this.receivedAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notification Page Content',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Received Action: ${receivedAction.buttonKeyPressed}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
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
