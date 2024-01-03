import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/Screens/profile.dart';
import 'package:realpalooza/constant/icons.dart';
import 'package:realpalooza/constant/size.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final user = FirebaseAuth.instance.currentUser!;
  //sign user out
  void signUserOut(){
    try{
      GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
    }on FirebaseAuthException catch(e){
      print(e.code);
    }
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetoptions = <Widget>[
    Profile(),
    Profile(),
    Profile(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe4f3ec),
        actions: [IconButton(
            onPressed: signUserOut, icon: Icon(Icons.logout))],),
      body: Center(
        child: _widgetoptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: const Color(0xffe4f3ec),
        ),
            child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: const Color(0xff26b051),
            selectedLabelStyle: const TextStyle(color: Colors.black,fontFamily: 'Comfortaa'),
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
            }),
      ),
    );
  }
}
