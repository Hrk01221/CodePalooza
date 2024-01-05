import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';
import 'package:realpalooza/components/my_text_field.dart';
import 'package:realpalooza/components/square_tile.dart';
class RegisterPage extends StatefulWidget {
  final Function()? ontap;

  const RegisterPage({Key? key, required this.ontap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void signInWithGoogle() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051),),
        );
      },
    );
    //begin sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain details

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credential

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth .idToken,
    );

    //sign in
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (context.mounted) Navigator.of(context).pop();
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
      errorShowMessage(context,e.code);
    }
  }


  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051),),
        );
      },
    );
    try {
        if (passwordcontroller.text == confirmpasswordcontroller.text) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
        'username' : emailcontroller.text.split('@')[0]
        });
        if (context.mounted) Navigator.of(context).pop();
      } else {
          if (context.mounted) Navigator.of(context).pop();
          errorShowMessage(context, 'Password Don\'t Match');
      }
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
                const SizedBox(height: 10),
                Center(
                  child: BounceInDown(
                    child: SizedBox(
                      width: 150,
                      height: 100,
                      child: Image.asset('lib/images/CPlogo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Let\'s Create an account for ya!',
                  style: TextStyle(
                      color: Color(0xff26b051),
                      fontSize: 16,
                      fontFamily: 'Comfortaa'
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
                const SizedBox(height: 10,),
                BounceInLeft(
                  child: Mytextfield(
                    controller: passwordcontroller,
                    hintText: 'Password',
                    obscuretext: true,
                  ),
                ),
                const SizedBox(height: 10,),

                BounceInLeft(
                  child: Mytextfield(
                    controller: confirmpasswordcontroller,
                    hintText: 'Confirm Password',
                    obscuretext: true,
                  ),
                ),
                const SizedBox(height: 25,),
                ZoomIn(
                  child: MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,
                  ),
                ),
                const SizedBox(height: 25,),
                Row(
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
                const SizedBox(height: 22,),
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
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
