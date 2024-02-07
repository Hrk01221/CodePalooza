import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/theme_provider.dart';
import '../../components/my_button2.dart';
import '../../components/my_text_field.dart';
import '../base_screen.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text('Change Password',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),),
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
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BaseScreen(
                selectedIndex: 3,
              )),
            );
          },
        ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('lib/images/CPlogo.png'),
                ),
              ),
              SizedBox(height: 70.0),
              Mytextfield(
                controller: currPassword,
                hintText: 'Enter Your Current Password',
                obscuretext: false,
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 20.0),
              Mytextfield(
                controller: newPassword,
                hintText: 'Enter Your New Password',
                obscuretext: false,
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 8.0),
              Mytextfield(
                controller: confirmPassword,
                hintText: 'Confirm Your New Password',
                obscuretext: false,
              ),
              SizedBox(height: 20.0),
              MyButton2(
                text: 'Submit',
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

