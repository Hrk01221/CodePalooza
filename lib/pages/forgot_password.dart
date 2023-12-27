import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/pages/auth_page.dart';

import '../components/my_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailcontroller = TextEditingController();

  void dispose(){
    _emailcontroller.dispose();
    super.dispose();
  }
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xffe4f3ec),
              title: BounceInDown(
                child: Text(
                    'Reset Password',
                     style: TextStyle(color: Color(0xff26b051),fontSize: 16,fontFamily: 'Comfortaa'),
                ),
              ),
              content: BounceInLeft(
                child: Text(
                    'A Link Has been sent to your mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff26b051),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                
                ),
                ),
              ),
              actions: <TextButton>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Authpage();
                        },
                      ),
                    );
                  },
                  child: BounceInUp(
                    child: Text(
                      'Go Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff26b051),
                        fontSize: 16,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                  ),
                ),
              ],
            );},);
    }on FirebaseAuthException catch (e) {
      ErrorShowMessage(context, e.code);
    }

  }


  void ErrorShowMessage(BuildContext context, String text) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: Dialog(
              backgroundColor: Color(0xffe4f3ec),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff26b051),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4f3ec),
      body: SafeArea(
      child: Center(
      child: SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: BounceInDown(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('lib/images/CPlogo.png'),
                ),
            ),
        ),
        const SizedBox(height: 10,),
        BounceInRight(
          child: Text(
              'Don\'t Worry We\'ll get you going soon',
              style: TextStyle(
                  color: Color(0xff26b051),
                  fontSize: 16,
                  fontFamily: 'Comfortaa'
              ),
          ),
        ),
        const SizedBox(height: 50,),

        BounceInLeft(
          child: Mytextfield(
            controller: _emailcontroller,
            hintText: 'Username/Email',
            obscuretext: false,
          ),
        ),

        const SizedBox(height: 40,),
        ZoomIn(
          child: GestureDetector(
            onTap: passwordReset,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 80), // Adjusted margin for a larger button
                decoration: BoxDecoration(
                  color: Color(0xff26b051),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff26b051),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(-4, -4),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Reset Password',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 25,),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context){
              return Authpage();
            })
            );
          },
          child: Text(
            'Go Back',
            style: TextStyle(
                color: Colors.grey[700],
                fontFamily: 'Comfortaa'
            ),
          ),
        ),
        const SizedBox(height: 175,),
      ],
    ),
    ),
    ),
    ),

    );
  }
}
