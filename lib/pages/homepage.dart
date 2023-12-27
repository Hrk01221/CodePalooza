import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


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
      appBar: AppBar(actions: [IconButton(
          onPressed: signUserOut, icon: Icon(Icons.logout))],),
      body: Center(child: Text('Logged in As + :'+user.email!),),
    );
  }
}
