import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';
import 'package:realpalooza/components/my_text_field.dart';
import 'package:realpalooza/components/square_tile.dart';
import 'package:realpalooza/pages/forgot_password.dart';

class LoginPage extends StatefulWidget {
  final Function()? ontap;

  const LoginPage({super.key, required this.ontap});//here there was changed called Key? key

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();
  void signInWithGoogle() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        // User canceled the sign-in
        if (context.mounted) Navigator.of(context).pop();
        return;
      }

      // Obtain details
      final String googleEmail = gUser.email; // Get the Google email

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseFirestore.instance.collection("Users").doc(googleEmail).set({
        'dp': 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg',
        'username': googleEmail.split('@')[0],
        'codeForces': 'Empty',
        'codeChef': 'Empty',
        'atCoder': 'Empty',
        'Email': googleEmail,
      });

      if (context.mounted) Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }


  void signInwithGithub() async{
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try{
      await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      if (context.mounted) Navigator.of(context).pop();
    }on FirebaseAuthException catch (e){
      if (context.mounted) Navigator.of(context).pop();
      errorShowMessage(context, e.code);
    }
  }

  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      if (context.mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      errorShowMessage(context, e.code);
    }
  }

  void errorShowMessage(BuildContext context, String text) {
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
              backgroundColor: const Color(0xffe4f3ec),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff26b051),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4f3ec),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: BounceInDown(
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('lib/images/CPlogo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                BounceInLeft(
                  child: const Text(
                    'Welcome Back you\'ve been missed!',
                    style: TextStyle(
                        color: Color(0xff26b051),
                        fontSize: 16,
                        fontFamily: 'Comfortaa'
                    ),
                  ),
                ),
                const SizedBox(height: 45,),
                BounceInLeft(
                  child: Mytextfield(
                    controller: emailcontroller,
                    hintText: 'Username/Email',
                    obscuretext: false,
                  ),
                ),
                const SizedBox(height: 15,),
                BounceInLeft(
                  child: Mytextfield(
                    controller: passwordcontroller,
                    hintText: 'Password',
                    obscuretext: true,
                  ),
                ),
                const SizedBox(height: 5,),
                FadeInRight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                )
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'Comfortaa'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                ZoomIn(
                  child: MyButton(
                    text: 'Sign in',
                    onTap: signUserIn,
                  ),
                ),
                const SizedBox(height: 25,),
                SlideInUp(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xffe4f3ec),
                        ),
                      ),
                      Text(
                        'Or Continue with ',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: 'Comfortaa'
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xffe4f3ec),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                SlideInUp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                          onTap: signInWithGoogle,
                          imagePath: 'lib/images/google.png'
                      ),
                      const SizedBox(width: 25),
                      SquareTile(
                          onTap: signInwithGithub,
                          imagePath: 'lib/images/github3.png'
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                SlideInUp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}