import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
  void signUserOut() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe4f3ec),
        appBar: AppBar(
          backgroundColor: const Color(0xffbbefd8),
          centerTitle: true,
          title: const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 25,
                  color: Color(0xff085d34),
                ),
              ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: (
                      const Icon(
                        Icons.dark_mode_outlined,
                      )
                  )
              ),
            ],
            leading: IconButton(
              onPressed: (){},
              icon: (
                const Icon(
                  Icons.chat_bubble_outline,
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
                  userData['username'] = 'Set ur Name';
                }
                userData['dp'] = emptyProfile;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(userData['dp']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          userData['username'],
                          style: const TextStyle(
                            color: Color(0xff26b051),
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
                        style: const TextStyle(
                          color: Color(0xff26b051),
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 120),
                          decoration: BoxDecoration(
                            color: const Color(0xff26b051),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Edit profile',
                              style: TextStyle(
                                color: Colors.white,
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
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xff26b051),
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
                          const Text(
                            'Performance Graph',
                            style: TextStyle(
                                color: Colors.green,
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
                                color: const Color(0xff26b051).withOpacity(.8),
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

                          const Text(
                            'Daily Streak',
                             style: TextStyle(
                             color: Colors.green,
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
                                color: const Color(0xff26b051).withOpacity(.8),
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

                          const Text(
                            'Skills',
                            style: TextStyle(
                                color: Colors.green,
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
                                color: const Color(0xff26b051).withOpacity(.8),
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

                          const Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.green,
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
                                color: const Color(0xff26b051).withOpacity(.8),
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
