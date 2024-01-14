import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnProgrammingPage extends StatelessWidget {
  LearnProgrammingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Competitive Programming'),
      ),
      body: Column(
        children: [
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          TopicButton(topicName: 'Algorithms', url: "https://www.youtube.com/watch?v=iKxrt4ASR5Y&ab_channel=CodeX"),
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          TopicButton(topicName: 'Data Structures', url: "https://www.geeksforgeeks.org/data-structures/"),
          // Add more topics as needed
        ],
      ),
    );
  }
}

class TopicButton extends StatelessWidget {
  final String topicName;
  final String url;

  TopicButton({required this.topicName, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(topicName),
        trailing: ElevatedButton(
          onPressed: () {
            launchURL(url);
          },
          child: Text('Explore'),
        ),
      ),
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