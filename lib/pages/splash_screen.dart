import 'package:flutter/material.dart';
import 'package:realpalooza/Services/auth_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xffe4f3ec),
      splash:
      Center(
        child: Column(
          children: [
            const SizedBox(height: 200,),
            Image.asset(
              'lib/images/CPlogo.png',
              width: 250,
              height: 200,
            ),
            const SizedBox(height: 5,),
            const Text(
              'An',
              style: TextStyle(
                color: Color(0xff26b051),
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),
            const Text(
              'Competitive Programming',
              style: TextStyle(
                color: Color(0xff26b051),
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),
            const Text(
              'Companion',
              style: TextStyle(
                color: Color(0xff26b051),
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),
            const SizedBox(height: 100,),
            const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),
          ],

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
