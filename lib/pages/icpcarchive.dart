import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/pages/competitive.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/icons.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CustomCard({Key? key, required this.title, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Icpcarchive extends StatefulWidget {
  const Icpcarchive({super.key});

  @override
  State<Icpcarchive> createState() => _IcpcarchiveState();
}

class _IcpcarchiveState extends State<Icpcarchive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            'ICPC Archive',
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
                color:
                Theme.of(context).brightness == Brightness.dark
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
                  color:
                  Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                )
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Competitive()),
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

                title: 'ICPC World Finals',
                subtitle: 'Problem-Set',
                cards:[

                  ContestItem(
                    hostName: 'Hosted by Egypt (Upcoming)',
                    Name: 'ICPC World Finals 2023',
                    uri: Uri.parse('https://worldfinals.icpc.global/#/'),
                  ),

                  ContestItem(
                    hostName: 'Hosted by Bangladesh',
                    Name: 'ICPC World Finals 2022',
                    uri: Uri.parse('https://icpc.global/worldfinals/problems/2021-ICPC-World-Finals/icpc2021.pdf'),
                  ),

                  ContestItem(
                    hostName: 'Hosted by Russia',
                    Name: 'ICPC World Finals 2021',
                    uri: Uri.parse('https://icpc.global/worldfinals/problems/2021-ICPC-World-Finals/icpc2021.pdf'),
                  ),

                  ContestItem(
                    hostName: 'Hosted by Moscow',
                    Name: 'ICPC World Finals 2020',
                    uri: Uri.parse('https://icpc.global/worldfinals/problems/2020-ICPC-World-Finals/icpc2020.pdf'),
                  ),

                  ContestItem(
                    hostName: 'Hosted by Portugal',
                    Name: 'ICPC World Finals 2019',
                    uri: Uri.parse('https://icpc.global/worldfinals/problems/2019-ICPC-World-Finals/icpc2019.pdf'),
                  ),

                  ContestItem(
                    hostName: 'Hosted by Beijing(China',
                    Name: 'ICPC World Finals 2018',
                    uri: Uri.parse('https://icpc.global/worldfinals/problems/2018-ICPC-World-Finals/icpc2018.pdf'),
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
  final String subtitle;
  final List<ContestItem> cards;

  const ContestSection({required this.title, required this.subtitle, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
          TextStyle(
              fontSize: 19,
              //fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Color(0xff075e34),
              fontFamily: 'Comfortaa'
          ),
        ),
        Text(
          subtitle,
          style:
          TextStyle(
              fontSize: 30,
              //fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Comfortaa'
          ),
        ),
        const SizedBox(height: 10),
        for (var contest in cards) ContestTile(item: contest),
      ],
    );
  }
}

class ContestItem {
  final String Name;
  final String hostName;
  final Uri uri;

  ContestItem({
    required this.Name,
    required this.hostName,
    required this.uri,
  });
}
class ContestTile extends StatefulWidget {
  final ContestItem item;

  const ContestTile({required this.item});

  @override
  _ContestTileState createState() => _ContestTileState();
}


class _ContestTileState extends State<ContestTile> {
  @override


  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: ListTile(
        leading:
        Image.asset(
          icpclogo,
          height: 40,
          width: 40,
        ),
        title:
        GestureDetector(
          onTap: () {
            _launchURL(widget.item.uri);
          },
          child:
          Text(
            widget.item.Name,
            style: TextStyle(
              fontSize: 19,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Comfortaa',
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        subtitle:
        Text(
          widget.item.hostName,
          style:
          TextStyle(
            fontSize: 15,
            color:
             Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color(0xff075e34),
            fontFamily: 'Comfortaa',
          ),
        ),
        trailing: Text(""),
      ),
    );
  }



  // Function to launch URI
  Future<void> _launchURL(Uri uri) async {
    final String url = uri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}