import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Theme/theme_provider.dart';
import 'chatPage.dart';

class LearnProgrammingPage extends StatelessWidget {
  LearnProgrammingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: Text(
              'Learn Competitive Programming',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 18,
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
              onPressed: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatPage();
                    },
                  ),
                );
              },
              icon: (
                  Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.chat_bubble_outlined
                        : Icons.chat_bubble_outline,
                    color: Theme.of(context).brightness == Brightness.dark
                        ?Colors.white.withOpacity(.8)
                        :Colors.grey[800],
                  )
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            )
        ),
      body: Column(
        children: [
          TopicButton(
            topicName: 'What is Competitive Programming?',
            urls: [
              "https://en.wikipedia.org/wiki/Competitive_programming",
              "https://www.geeksforgeeks.org/how-to-prepare-for-competitive-programming/",
              "https://emeritus.org/blog/coding-competitive-programming/"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Linear Search Algorithm',
            urls: [
              "https://www.geeksforgeeks.org/linear-search/",
              "https://www.tutorialspoint.com/data_structures_algorithms/linear_search_algorithm.htm",
              "https://www.javatpoint.com/linear-search",
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Binary Search',
            urls: [
              "https://www.geeksforgeeks.org/binary-search/",
              "https://www.programiz.com/dsa/binary-search",
              "https://www.youtube.com/watch?app=desktop&v=ARtYEZjOTbU&ab_channel=DBSTalks"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Unbounded Binary Search',
            urls: [
              "https://www.geeksforgeeks.org/find-the-point-where-a-function-becomes-negative/",
              "https://www.techiedelight.com/unbounded-binary-search/",
              "https://stackoverflow.com/questions/66609233/unbounded-binary-search-finding-the-point-where-a-monotonically-increasing-func"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Merge Sort',
            urls: [
              "https://www.geeksforgeeks.org/merge-sort/",
              "https://www.programiz.com/dsa/merge-sort",
              "https://www.javatpoint.com/merge-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'QuickSort',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),

          // Add more TopicButtons as needed
        ],
      ),
    );
  }
}

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
            Navigator.push(
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

  TopicDetailPage({required this.topicName, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(topicName,style: TextStyle(
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

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          )
      ),
      body: ListView.builder(
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