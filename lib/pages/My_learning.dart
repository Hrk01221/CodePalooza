import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/base_screen.dart';
import '../Theme/theme_provider.dart';
import '../components/my_text_field.dart';
import 'comment.dart';

class TopicButton extends StatelessWidget {
  final String topicName;
  final List<String> urls;

  TopicButton({required this.topicName, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          topicName,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 17,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TopicDetailPage(topicName: topicName, urls: urls);
                },
              ),
            );
          },
          child: Text(
            'Explore',
            style: TextStyle(color: Color(0xff26b051)),
          ),
        ),
      ),
    );
  }
}

class TopicDetailPage extends StatelessWidget {
  final String topicName;
  final List<String> urls;

  final currentUser=FirebaseAuth.instance.currentUser!;
  final textController=TextEditingController();

  TopicDetailPage({required this.topicName, required this.urls});

  //post message

  void postMessage(){
    //only post if there is something in the textfield
    if(textController.text.isNotEmpty){
      //store in firebase
      FirebaseFirestore.instance.collection("User posts").add({
        'UserEmail':currentUser.email,
        'Message':textController.text,
        'TimeStamp':Timestamp.now(),
      });
    }

  }

  //add a comment
  void addComment(String commentText){
    //write the comment to firestore under the comments collection for this page
    var widget;
    var currentUser;
    FirebaseFirestore.instance.
    collection("User Posts").
    doc(widget.postId).
    collection("Comment").
    add({
      "CommentText":commentText,
      "CommentedBy":currentUser.email,
      "CommentTime":Timestamp.now()
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: Text(
              topicName,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
              icon: (
                  Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.arrow_back_ios_rounded
                        : Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).brightness == Brightness.dark
                        ?Colors.white.withOpacity(.8)
                        :Colors.grey[800],
                  )
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const BaseScreen()),
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
        body: Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: urls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        urls[index],
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        launchURL(urls[index]);
                      },
                    );
                  },
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("User Posts")
                      .orderBy(
                    "TimeStamp",
                    descending: false,
                  ).snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          //get the message
                          final post=snapshot.data!.docs[index];
                          return Comment(
                            message: post['Message'],
                            user: post['UserEmail'],
                          );
                        },
                      );
                    }else if(snapshot.hasError){
                      return Center(
                        child: Text('Error:${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),

              Padding(padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Mytextfield(
                        controller: textController,
                        hintText: 'Write your comment..',
                        obscuretext: false ,
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        //margin: const EdgeInsets.only(right: 25),
                        child: IconButton(onPressed: postMessage, icon: Icon(Icons.send),
                        ))
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  void launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}