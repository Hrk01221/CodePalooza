import 'package:flutter/material.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/Screens/profile.dart';
import 'package:realpalooza/pages/auth_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xffe4f3ec),
      splash:
      Center(
        child: Container(
            child: Column(
              children: [
                const SizedBox(height: 200,),
                Image.asset(
                  'lib/images/CPlogo.png',
                  width: 250,
                  height: 200,
                ),
                const SizedBox(height: 5,),
                Text(
                  'An',
                  style: TextStyle(
                    color: Color(0xff26b051),
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                Text(
                  'Competitive Programming',
                  style: TextStyle(
                    color: Color(0xff26b051),
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                Text(
                  'Companion',
                  style: TextStyle(
                    color: Color(0xff26b051),
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                const SizedBox(height: 100,),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ],

            )

        ),
      ),
      nextScreen:  Authpage(),
      splashIconSize: double.infinity,
      duration: 700,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
