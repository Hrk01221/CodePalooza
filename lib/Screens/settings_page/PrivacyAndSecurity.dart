import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Theme/theme_provider.dart';
import '../base_screen.dart';

class PrivacySafetyPage extends StatefulWidget {
  @override
  _PrivacySafetyPageState createState() => _PrivacySafetyPageState();
}

class _PrivacySafetyPageState extends State<PrivacySafetyPage> {
  bool _enableTwoFactorAuth = false;
  bool _enableBiometricAuth = false;
  bool _showOnlineStatus = true;
  bool _showLastSeen = true;
  bool _showReadReceipts = true;
  bool _enableScreenLock = false;
  bool _allowLocationSharing = true;
  bool _showProfileInfo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title:  Text('Privacy And Safety',
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text('Two-Factor Authentication', style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Enable two-factor authentication for added security', style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _enableTwoFactorAuth,
              onChanged: (value) {

                setState(() {
                  _enableTwoFactorAuth = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Biometric Authentication', style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Enable biometric authentication for quicker access', style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _enableBiometricAuth,
              onChanged: (value) {
                setState(() {
                  _enableBiometricAuth = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Show Online Status',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Allow others to see when you are online',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _showOnlineStatus,
              onChanged: (value) {
                setState(() {
                  _showOnlineStatus = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Show Last Seen',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Allow others to see when you were last active',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _showLastSeen,
              onChanged: (value) {
                setState(() {
                  _showLastSeen = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Show Read Receipts',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Show when you have read a message',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _showReadReceipts,
              onChanged: (value) {
                setState(() {
                  _showReadReceipts = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Enable Screen Lock',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Require screen lock for accessing the app',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _enableScreenLock,
              onChanged: (value) {
                setState(() {
                  _enableScreenLock = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Allow Location Sharing',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Share your location with others',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _allowLocationSharing,
              onChanged: (value) {
                setState(() {
                  _allowLocationSharing = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: Text('Show Profile Information',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontFamily: 'Comfortaa',fontWeight: FontWeight.bold),),
            subtitle: Text('Allow others to see your profile information',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontFamily: 'Comfortaa'),),
            trailing: CupertinoSwitch(
              value: _showProfileInfo,
              onChanged: (value) {
                setState(() {
                  _showProfileInfo = value;
                });
              },
            ),
          ),

        ],
      ),
    );
  }
}
