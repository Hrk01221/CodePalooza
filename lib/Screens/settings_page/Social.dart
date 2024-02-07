import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/chat/chat_service.dart';
import '../../Theme/theme_provider.dart';
import '../../components/UserTile2.dart';
import '../Chatting_with.dart';
import '../base_screen.dart';

class SocialPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<SocialPage> {
  TextEditingController _searchController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  String name = "";
  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Center(
          child: Text('Social',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),),
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
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
    //initState();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value){
          setState(() {
            name = value;
          });
        },
        decoration: InputDecoration(
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            labelText: 'Search Users',
            labelStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.8) :  Color(0xff26b051),fontFamily: 'Comfortaa'),
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: (){_searchController.clear();setState(() {
                name='';
              });},
              icon: Icon(IconData(0xe16a, fontFamily: 'MaterialIcons')),
            )
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


  Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context) {
    if (userData["Email"] != currentUser.email && (name.isEmpty ||
        userData['username'].toString().toLowerCase().startsWith(
            name.toLowerCase()))) {
      print(name);
      return UserTile2(
        text: userData['username'],
        onTap: () {

        },
        imagePath: userData['dp'] == ''
            ? 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg'
            : userData['dp'],
        onAddFriendPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Friend Request Sent",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  } }