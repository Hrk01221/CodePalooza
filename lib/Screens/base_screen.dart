import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/Screens/profile.dart';
import 'package:realpalooza/constant/icons.dart';
import 'package:realpalooza/constant/size.dart';
import 'package:realpalooza/pages/competitive.dart';
import 'package:realpalooza/pages/schedule.dart';

import 'learning.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final user = FirebaseAuth.instance.currentUser!;
  //sign user out

  int _selectedIndex = 0;

  static final List<Widget> _widgetoptions = <Widget>[
    const Profile(),
    LearnProgrammingPage(),
    const Competitive(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetoptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).colorScheme.primary,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            selectedLabelStyle: const TextStyle(
                color: Colors.black, fontFamily: 'Comfortaa'),
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  icFeaturedOutlined,
                  height: kBottomNavigationBarItemSize,
                ),
                icon: Image.asset(
                  icFeatured,
                  height: kBottomNavigationBarItemSize,
                ),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  icideaOutlinded,
                  height: kBottomNavigationBarItemSize,
                ),
                icon: Image.asset(
                  icidea,
                  height: kBottomNavigationBarItemSize,
                ),
                label: "My Learning",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  iccpOutlined,
                  height: kBottomNavigationBarItemSize,
                ),
                icon: Image.asset(
                  iccp,
                  height: kBottomNavigationBarItemSize,
                ),
                label: "Competitive",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(
                  icSettingOutlined,
                  height: kBottomNavigationBarItemSize,
                ),
                icon: Image.asset(
                  icSetting,
                  height: kBottomNavigationBarItemSize,
                ),
                label: "Settings",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
