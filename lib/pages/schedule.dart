import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/pages/competitive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'notification.dart';

class Contest {
  final String name;
  final DateTime startTime;

  Contest({required this.name, required this.startTime});

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      name: json['name'],
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTimeSeconds'] * 1000),
    );
  }
}

class Schedule extends StatefulWidget {
  const Schedule({super.key});
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late List<bool> isReminderEnabledList;
  late List<Contest> _contests = [];

  @override
  void initState() {
    super.initState();
    _fetchContests();
  }

  Future<void> _fetchContests() async {
    try {
      final response = await http.get(Uri.parse('https://codeforces.com/api/contest.list'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Contest> contests = [];
        List<bool> reminderList = [];
        for (var contest in data['result']) {
          contests.add(Contest.fromJson(contest));
          reminderList.add(false); // Initialize all reminders as false initially
        }
        setState(() {
          _contests = contests;
          isReminderEnabledList = reminderList;
        });
      } else {
        throw Exception('Failed to load contests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching contests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            'Schedule',
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
                    ?Colors.white.withOpacity(.8)
                    :Colors.grey[800],
              ),
            ),
          ],
          leading: IconButton(
            icon: (
                Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.arrow_back_ios_rounded
                      : Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                )
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen(selectedIndex: 2)),
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
      body: _contests != null && _contests.isNotEmpty
          ? ListView.builder(
        itemCount: _contests.length,
        itemBuilder: (context, index) {
          final startTimeFormatted = DateFormat('dd-MM-yyyy HH:mm:ss').format(_contests[index].startTime);
          final startTimeFormattedForNotification = DateFormat('E HH:mm a').format(_contests[index].startTime);

            return Column(
                children: [
                  ListTile(
                    title: GestureDetector(
                      onTap: () async {
                        final Uri uri = Uri.parse('https://codeforces.com/contests/${_contests[index].name}');
                        if (await canLaunch(uri.toString())) {
                          await launch(uri.toString());
                        } else {
                          throw 'Could not launch $uri';
                        }
                      },
                      child: Text('${_contests[index].name}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                    ),
                    subtitle: Text('$startTimeFormatted',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                    trailing: Switch(
                      value: isReminderEnabledList[index],
                      onChanged: (value) {
                        setState(() {
                          isReminderEnabledList[index] = value;
                          if (isReminderEnabledList[index]) {
                            NotificationManager.showNotification(
                                title: 'Contest Reminder',
                                //change
                                body: '${_contests[index].name} will start at $startTimeFormattedForNotification',
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
                            _showPopupMessage(context);
                            // Add logic to set a reminder for this contest
                          } else {
                            // Add logic to cancel the reminder for this contest
                          }
                        });
                      },
                      activeColor: //const Color(0xff099141),
                      Theme.of(context).brightness == Brightness.dark
                          ?Color(0xff26b051)
                          :Color(0xff26b051),
                      inactiveTrackColor: //const Color(0xffe8f5e9),
                      Theme.of(context).brightness == Brightness.dark
                          ?Colors.grey[600]
                          :Color(0xffe8f5e9),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ), // Add a Divider after each ListTile
                ],
            );
        },
      )

          : Center(child: CircularProgressIndicator()),
    );
  }
  void _showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder Set',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              color: Theme.of(context).brightness == Brightness.dark
                  ?Colors.white.withOpacity(.8)
                  :Color(0xff075e34),
            ),
          ),
          content: Text('You will get a reminder before the contest.',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              color: Theme.of(context).brightness == Brightness.dark
                  ?Colors.white.withOpacity(.8)
                  :Color(0xff075e34),
            ),
          ),
          actions: [
            Container(
              width: 50.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: TextButton(
                onPressed: () {
                  // Close the dialog when the button is pressed
                  Navigator.of(context).pop();
                },
                child: Text('OK',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Theme.of(context).brightness == Brightness.dark
                        ?Colors.black.withOpacity(.8)
                        :Color(0xff099141),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}