import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:realpalooza/components/my_button.dart';
import 'package:realpalooza/components/my_text_field.dart';
import 'package:realpalooza/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? ontap;

  RegisterPage({Key? key, required this.ontap}) : super(key: key);

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
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
    }on FirebaseAuthException catch(e){

    } finally {
      Navigator.of(context).pop();
    }

    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
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
    }on FirebaseAuthException catch (e){
    } finally {
      Navigator.of(context).pop();
    }
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
  }


  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    try {
      if (passwordcontroller.text == confirmpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
      } else {
        Navigator.pop(context);
        ErrorShowMessage(context, 'Password Don\'t Match');
        return;
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
                  padding: const EdgeInsets.all(32.0),
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
                const SizedBox(height: 10),
                Center(
                  child: BounceInDown(
                    child: Container(
                      width: 150,
                      height: 100,
                      child: Image.asset('lib/images/CPlogo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
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
                    Expanded(
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
                    Expanded(
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
                      child: Text(
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
