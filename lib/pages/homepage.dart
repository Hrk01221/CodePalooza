import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';
import 'package:realpalooza/pages/daily_streak.dart';

import 'graph_code.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
