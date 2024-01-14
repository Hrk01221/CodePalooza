
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Services/chat/chat_service.dart';
import 'package:realpalooza/components/chat_bubble.dart';
import 'package:realpalooza/components/text_field_two.dart';

import '../Theme/theme_provider.dart';

class ChattingPage extends StatelessWidget {
  final String recievername;
  final String recieverID;
  final String recieverdp;
   ChattingPage({
    super.key,
    required this.recievername,
     required this.recieverID,
     required this.recieverdp,

  });

  final TextEditingController _messageController = TextEditingController();

  final  ChatService _chatService = ChatService();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void sendMessage() async {

    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(recieverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: ClipOval(
                child: Image.network(
                    recieverdp
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Text(recievername,style: TextStyle(color:Theme.of(context).colorScheme.secondary,fontFamily: 'Comfortaa',fontSize: 16),),
          ],
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderID = currentUser.email!;
    return StreamBuilder(
        stream: _chatService.getMessages(recieverID, senderID),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          return ListView(
            children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;

    bool isCurrentUser = data['senderID'] == currentUser.email!;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


    return Container(
      alignment: alignment,
        child: Column(
          crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
                message: data["message"],
                isCurrentUser: isCurrentUser,
            )
          ],
        )
    );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
              child: Mytextfield2(
                controller: _messageController,
                hintText: "Type A Message",
                obscuretext: false,
              )
          ),
              Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send),
              ))
        ],
      ),
    );
  }

}
