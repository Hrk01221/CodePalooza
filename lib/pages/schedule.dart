import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realpalooza/Screens/base_screen.dart';

class Schedule extends StatefulWidget {
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child:  AppBar(
          backgroundColor: Color(0xffe4f3ec),
          actions: [IconButton(
              onPressed: (){ Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BaseScreen();
                  },
                ),
              );},
              icon: Icon(Icons.arrow_circle_left_outlined))
          ],
        ),
      ),
      backgroundColor: const Color(0xffe4f3ec),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContestSection(
                title: 'Recent Contest',
                contests:[
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now(),
                    contestName: 'Contest 2024',
                  ),
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now().subtract(const Duration(days: 5)),
                    contestName: 'Code Challenge',
                  ),
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now().subtract(const Duration(days: 10)),
                    contestName: 'Up Comp',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ContestSection(
                title: 'Upcoming Contest',
                contests: [
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now().add(const Duration(days: 15)),
                    contestName: 'Code Jam',
                  ),
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now().add(const Duration(days: 20)),
                    contestName: 'March Coding',
                  ),
                  ContestItem(
                    logo: Icons.code_rounded,
                    date: DateTime.now().add(const Duration(days: 30)),
                    contestName: 'Hackathon',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContestSection extends StatelessWidget {
  final String title;
  final List<ContestItem> contests;

  const ContestSection({required this.title, required this.contests});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 23,
              //fontWeight: FontWeight.bold,
              color: Color(0xff075e34),
              fontFamily: 'Comfortaa'
          ),
        ),
        const SizedBox(height: 10),
        for (var contest in contests) ContestTile(item: contest),
      ],
    );
  }
}

class ContestItem {
  final IconData logo;
  final DateTime date;
  final String contestName;

  ContestItem({
    required this.logo,
    required this.date,
    required this.contestName,
  });
}

class ContestTile extends StatefulWidget {
  final ContestItem item;

  const ContestTile({required this.item});

  @override
  _ContestTileState createState() => _ContestTileState();
}

class _ContestTileState extends State<ContestTile> {
  bool isReminderEnabled = false;
  final MaterialStateProperty<Icon?> checkIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.notifications_on,
          color: Color(0xffe8f5e9),
        );
      }
      //return const Icon(Icons.notifications);
    },
  );

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy (E) HH:mm').format(widget.item.date);

    return ListTile(
      leading: Icon(
        Icons.code_rounded,
        color: Color(0xff099141),
        size: 30.0,
      ),
      title: Text(
        widget.item.contestName,
        style: const TextStyle(
          fontSize: 19,
          color: Color(0xff099141),
          fontFamily: 'Comfortaa',
        ),
      ),
      subtitle: InkWell(
        onTap: () {
          _launchURL(widget.item);
        },
        child: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
      ),
      trailing:
      Transform.scale(
        scale: 0.88,
        child: Switch.adaptive(
          thumbIcon: checkIcon,

          applyCupertinoTheme: false,
          value: isReminderEnabled,
          onChanged: (value) {
            setState(() {
              isReminderEnabled = value;
              // Handle reminder logic here
              if (isReminderEnabled) {
                // Add logic to set a reminder
              } else {
                // Add logic to cancel the reminder
              }
            });
          },
          activeColor: Color(0xff099141),
          inactiveTrackColor: Color(0xffe8f5e9),
        ),
      ),
    );
  }

  void _launchURL(ContestItem item) async {
    String formattedDateTime = DateFormat('yyyyMMddTHHmm').format(item.date);
    String url = 'https://www.timeanddate.com/worldclock/fixedtime.html?iso=$formattedDateTime&p1=248';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}