import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/components/my_button2.dart';
import 'package:realpalooza/constant/icons.dart';
import 'package:realpalooza/pages/graph_code.dart';
import 'package:realpalooza/pages/notification.dart';
import 'package:realpalooza/pages/schedule.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realpalooza/Screens/base_screen.dart';

class Competitive extends StatefulWidget {
  const Competitive({super.key});

  @override
  State<Competitive> createState() => _CompetitiveState();
}

class _CompetitiveState extends State<Competitive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      title: Text(
          'Competitive',
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
            Navigator.push(context,
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

        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 25,
                ),
                  Image.asset(
                      schedule2,
                      height: 100,
                      width: 100,
                      ),
                MyButton2(onTap: (){}, text: 'Schedule'),
                Divider(
                  thickness: 0.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                const SizedBox(width: 30,),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Image.asset(
                  icpcarchive,
                  height: 100,
                  width: 100,
                ),
                MyButton2(onTap: (){}, text: 'ICPC Archive'),
                Divider(
                  thickness: 0.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                const SizedBox(width: 30,),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Image.asset(
                  icpcrank,
                  height: 100,
                  width: 100,
                ),
                MyButton2(onTap: (){}, text: 'ICPC Rankings'),
                Divider(
                  thickness: 0.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                const SizedBox(width: 30,),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
