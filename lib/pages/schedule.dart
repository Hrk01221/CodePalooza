import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/pages/notification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realpalooza/Screens/base_screen.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BaseScreen()),
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

  const ContestSection({super.key, required this.title, required this.contests});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 25,
          fontFamily: 'Comfortaa'),
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

  const ContestTile({super.key, required this.item});

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
//Color(0xff099141)
    return ListTile(
      leading: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.code_rounded
            : Icons.code_rounded,
        color: Theme.of(context).brightness == Brightness.dark
            ?Colors.white.withOpacity(.8)
            :Color(0xff099141),
        size: 30.0,
      ),
      title: Text(
        widget.item.contestName,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 19,
          color: Theme.of(context).colorScheme.secondary,
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
                _showPopupMessage(context);
                // Add logic to set a reminder
              } else {
                // Add logic to cancel the reminder
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
    );
  }

  void _launchURL(ContestItem item) async {
    String formattedDateTime = DateFormat('yyyyMMddTHHmm').format(item.date);
    String url = 'https://www.timeanddate.com/worldclock/fixedtime.html?iso=$formattedDateTime&p1=248';

    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) { // Change canLaunch to canLaunchUrl
      await launch(uri.toString());// Assuming you have a launch import statement in your code
    } else {
      throw 'Could not launch $url';
    }
  }
  // Function to show the popup message
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
          content: Text('An email will be sent to you 1 hour before the contest.',
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