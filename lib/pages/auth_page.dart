import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/pages/daily_streak.dart';
import 'package:realpalooza/pages/login_or_registered.dart';
import 'homepage.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            //user logged in
            if(snapshot.hasData){
              //Navigator.pop(context);
              return DailyStreakScreen();
            }
            //user not logged in
            else{
              return LoginOrRegistered();
            }
          },
        )
    );
  }
}
