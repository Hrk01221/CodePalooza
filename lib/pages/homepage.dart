import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';

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
      appBar: AppBar(
        backgroundColor: Color(0xffe4f3ec),
        actions: [IconButton(
          onPressed: signUserOut, icon: Icon(Icons.logout))],),
      backgroundColor: Color(0xffe4f3ec),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomIn(child: Text('Logged in As : '+user.email!,
              style: TextStyle(
                  color: Color(0xff26b051),
                  fontSize: 15,
                  fontFamily: 'Comfortaa'
              ),),),
                const SizedBox(height: 50,),
                ZoomIn(child: MyButton(
                  text: 'Daily Streak',
                  onTap: (){},
                )),
                const SizedBox(height: 40,),
                ZoomIn(child: MyButton(
                  text: 'Show Graph',
                  onTap: (){
                    //Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Graph();
                        },
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      )

    );
  }
}
