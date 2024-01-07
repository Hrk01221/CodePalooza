import 'package:flutter/material.dart';
import 'package:realpalooza/pages/login_page.dart';
import 'package:realpalooza/pages/register_page.dart';

class LoginOrRegistered extends StatefulWidget {
  const LoginOrRegistered({super.key});

  @override
  State<LoginOrRegistered> createState() => _LoginOrRegisteredState();
}

class _LoginOrRegisteredState extends State<LoginOrRegistered> {
  //initially show the login page
  bool showLoginPage = true;

  //toggle between login and register pages

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        ontap: togglePages,
      );
    }
    else{
      return RegisterPage(
        ontap: togglePages,
      );
    }
  }
}
