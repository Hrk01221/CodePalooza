import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Screens/edit_profile.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/constant/icons.dart';
import 'package:realpalooza/pages/daily_streak.dart';
import '../pages/graph_code.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  void signUserOut() async {
    print('he');
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    // Introduce a small delay before entering the try block
    Future.delayed(const Duration(milliseconds: 1000), () async {
      try {
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        if (context.mounted) Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        if (context.mounted) Navigator.of(context).pop();
        print(e.code);
      }
    });
    print(currentUser.email);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            actions: [
              IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                },
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.dark_mode
                      : Icons.dark_mode_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                ),
              ),
            ],
            leading: IconButton(
              onPressed: (){},
              icon: (
                 Icon(
                   Theme.of(context).brightness == Brightness.dark
                       ? Icons.chat_bubble_outlined
                       : Icons.chat_bubble_outline,
                  color: Theme.of(context).brightness == Brightness.dark
                      ?Colors.white.withOpacity(.8)
                      :Colors.grey[800],
                )
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            )
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> userData = <String, dynamic>{};
                if (snapshot.data!.data() != null) {
                  userData = snapshot.data!.data() as Map<String, dynamic>;
                } else {
                  userData['username'] = 'Set Your Name';
                  userData['dp'] = 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg';
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                          child: Image.network(
                            userData['dp']==''?'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg':userData['dp'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          userData['username']==''?'Set Your Name':userData['username'],
                          style:  TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: 'Comfortaa',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height:10),
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditProfille();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 120),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.8) :  Color(0xff26b051),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Edit profile',
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Image.asset(
                            graph,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                           Text(
                            'Performance Graph',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontFamily: 'Comfortaa'),
                          ),

                          const SizedBox(width: 30,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Graph(),
                                  )
                              );
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
                              ),
                              child: const Icon(
                                LineAwesomeIcons.angle_right,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            calender,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 25,
                          ),

                          Text(
                            'Daily Streak',
                             style: TextStyle(
                             color: Theme.of(context).colorScheme.secondary,
                                 fontSize: 20,
                                 fontFamily: 'Comfortaa'),
                            ),
                          const SizedBox(width: 112,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DailyStreakScreen(),
                                  )
                              );
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
                              ),
                              child: const Icon(
                                LineAwesomeIcons.angle_right,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            think,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 25,
                          ),

                           Text(
                            'Skills',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontFamily: 'Comfortaa'),
                          ),
                          const SizedBox(width: 180,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DailyStreakScreen(),
                                  )
                              );
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
                              ),
                              child: const Icon(
                                LineAwesomeIcons.angle_right,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50,),
                      Row(
                        children: [
                          const SizedBox(
                            width: 34,
                          ),
                          Image.asset(
                            logout,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 25,
                          ),

                           Text(
                            'Log Out',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontFamily: 'Comfortaa'),
                          ),
                          const SizedBox(width: 147,),
                          GestureDetector(
                            onTap: (){
                              signUserOut();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
                              ),
                              child: const Icon(
                                Icons.logout,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                //debug
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
