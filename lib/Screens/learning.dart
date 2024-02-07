
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/components/my_text_field.dart';
import 'package:realpalooza/pages/comment.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Theme/theme_provider.dart';
import '../pages/My_learning.dart';
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

                Navigator.pushReplacement(
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
      body: SingleChildScrollView(
      child:Column(
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
          TopicButton(
            topicName: 'Sum of Digits',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Prefix sum',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Reverse an array',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: '2D Prefix Sum',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Java',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Kadane Algorithm',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Prime Number',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Sieve of Eratosthenes',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Segmented Sieve',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Linear Diophantine Equations',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Modular Operations',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Modular Inverse',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Matrix Exponentiation',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Find all divisors of a natural number',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Bitset CPP',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Euler’s Totient Function',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Euler’s Totient function for all numbers smaller than or equal to n',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Inclusion Exclusion Principle ',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Pigeon Hole Principle',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Power(x, y) in O( logN )',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'nCr % mod for multiple queries',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Gaussian Elimination',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Catalan numbers: Applications',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'nCr % mod for multiple queries',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
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
          TopicButton(
            topicName: 'Sum of Digits',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Prefix sum',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Reverse an array',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Find all divisors of a natural number',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Bitset CPP',
            urls: [
              "https://geeksforgeeks.org/quick-sort/",
              "https://www.programiz.com/dsa/quick-sort",
              "https://www.javatpoint.com/quick-sort"
              // Add more URLs for the topic as needed
            ],
          ),
          TopicButton(
            topicName: 'Euler’s Totient Function',
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
      ),
    );
  }
}

