import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe4f3ec),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  const SizedBox(width: 30,),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(profileImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Hridoy Nandi',
                          style: TextStyle(
                            color: Color(0xff26b051),
                            fontFamily: 'Comfortaa',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xff26b051),fontSize: 20,fontFamily: 'Comfortaa',),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff26b051),
                            borderRadius: BorderRadius.circular(12),
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
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 30,),
                  Image.asset(
                    graph,
                    height : 50,
                  ),
                  const SizedBox(width: 30,),
                  const Text(
                    'Performance Graph',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontFamily: 'Comfortaa'
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 90,),
                  SizedBox(
                    height: 250,
                    width: 280,
                    child: PerformanceChart(),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 30,),
                  Image.asset(
                    calender,
                    height : 40,
                  ),
                  const SizedBox(width: 30,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DailyStreakScreen(),
                          )
                      );
                    },
                    child: const Text(
                      'Daily Streak',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontFamily: 'Comfortaa'
                      ),
                    ),
                  ),
                ],
              ),
            ],),
        ),
    );
  }
}
