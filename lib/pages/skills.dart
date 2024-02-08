import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Screens/base_screen.dart';
import '../Theme/theme_provider.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title:  Text('Skills',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),),
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
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen(
                  selectedIndex: 0,
                )),
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
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'Implementation',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  const SizedBox(width: 10,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.8,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Colors.deepOrange,
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'Math',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 120,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.6,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Colors.red,
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'Greedy',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 100,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 3000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.5,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xffdf78ef),
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'constructive',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 44,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 4000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.4,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xffb085f5),
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'sortings',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 89,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 5000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.8,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xff80d6ff),
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'dp',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  const SizedBox(width: 150,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 6000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.2,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xffffffd1),
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text(
                    'Graph',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 115,),
                  LinearPercentIndicator(
                    animation: true,
                    animationDuration: 7000,
                    lineHeight: 15,
                    width: 200,
                    percent: 0.7,
                    progressColor: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xffff867c),
                    backgroundColor: Theme.of(context).brightness != Brightness.dark ?Colors.white:Colors.grey,
                  ),
                  //LinearPercentIndicator()
                ],
              ),
              const SizedBox(height: 30,),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              const SizedBox(height: 40,),
              Text(
                'Practice Everyday or you\'ll fall behind',
                style: TextStyle(color: Colors.green[400]),
              ),
              Row(
                children: [
                  const SizedBox(width: 100,),
                  Text(
                    'Don\'t Know what it is?',
                    style: TextStyle(color: Colors.green[400]),
                  ),
                  TextButton(onPressed: (){}, child: Text('Click Here',style: TextStyle(color: Colors.blue),))
                ],
              )
            ],
          ),
        ),
    );
  }
}