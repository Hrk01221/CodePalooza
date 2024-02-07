import 'package:flutter/material.dart';

class Comment extends StatelessWidget{
  final String message;
  final String user;
  //final String time;
  const Comment({
    super.key,
    required this.message,
    required this.user,
    //required this.time
  });

  @override
  Widget build(BuildContext context){
    return Row(
            children: [
              Text(user),
              Text(message),
            ],
    );
  }
}