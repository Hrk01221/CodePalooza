import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/Services/chat/chat_service.dart';
import 'package:realpalooza/Theme/theme_provider.dart';

import '../components/UserTile.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final currentUser = FirebaseAuth.instance.currentUser!;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          centerTitle: true,
          title: Text(
            'Chat',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              color: Theme
                  .of(context)
                  .colorScheme
                  .secondary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(
                Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Icons.dark_mode
                    : Icons.dark_mode_outlined,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.white.withOpacity(.8)
                    : Colors.grey[800],
              ),
            ),
          ],
          leading: BackButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BaseScreen(),
                    )
                );
              }
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: _buildUserList(),
            ),
          ],
        ),
      ),

    );
  }
  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          // Handle search logic here, e.g., update a filtered user list
        },
        decoration: InputDecoration(
          labelText: 'Search Users',
          labelStyle: TextStyle(color: Colors.grey[800]),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          print("Error");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context){
    if(userData["email"] != currentUser.email){
      print(userData["email"]);
      return UserTile(
        text: userData['username'],
        ontap: (){},
        imagePath: userData['dp']==''?'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg':userData['dp'],
      );
    }else{
      return Container();
    }
  }
}
