import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Current Password',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your current password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'New Password',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your new password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Confirm New Password',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm your new password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit button press
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

