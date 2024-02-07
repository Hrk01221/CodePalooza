import 'package:flutter/material.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyStreakScreen extends StatefulWidget {
  @override
  _DailyStreakScreenState createState() => _DailyStreakScreenState();
}

class _DailyStreakScreenState extends State<DailyStreakScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  late SharedPreferences _prefs;
  late List<bool> _solvedProblems;
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _initFirebase();
  }

  _initFirebase() async {
    User? user = _auth.currentUser;

    if (user == null) {
      // Handle not signed in
      // Redirect to sign-in screen or handle accordingly
    } else {
      setState(() {
        _user = user;
      });
      _initSharedPreferences();
    }
  }

  _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSolvedProblems();
    _loadStreak();
  }

  _loadSolvedProblems() {
    setState(() {
      _solvedProblems = List.generate(
        7,
            (index) => _prefs.getBool('${_user.uid}_solved_problem_$index') ?? false,
      );
    });
  }

  _loadStreak() {
    setState(() {
      _currentStreak = _prefs.getInt('${_user.uid}_current_streak') ?? 0;
    });
  }

  _solveProblem(int dayIndex) {
    DateTime now = DateTime.now();
    String lastDateKey = '${_user.uid}_last_date';

    String? lastDateStr = _prefs.getString(lastDateKey);
    if (lastDateStr != null) {
      DateTime lastDate = DateTime.parse(lastDateStr);
      if (lastDate.day == now.day &&
          lastDate.month == now.month &&
          lastDate.year == now.year) {
        // Already logged in today
        return;
      } else if (lastDate.isBefore(now.subtract(const Duration(days: 1)))) {
        // Missed a day, reset streak
        _currentStreak = 0;
        _prefs.setInt('${_user.uid}_current_streak', _currentStreak);
      }
    }

    _currentStreak++;
    _prefs.setInt('${_user.uid}_current_streak', _currentStreak);

    setState(() {
      _solvedProblems[dayIndex] = !_solvedProblems[dayIndex];
      _prefs.setBool('${_user.uid}_solved_problem_$dayIndex', _solvedProblems[dayIndex]);
    });

    _prefs.setString(lastDateKey, DateFormat('yyyy-MM-dd').format(now));
    _loadSolvedProblems();
    _loadStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe4f3ec),
        title: Text('Daily Streak'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BaseScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreakTracker(
              currentStreak: _currentStreak,
              solvedProblems: _solvedProblems,
              solveProblem: _solveProblem,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                return DayContainer(
                  onTap: () => _solveProblem(index),
                  solved: _solvedProblems[index],
                  dayText: DateFormat('E').format(
                    DateTime.now().subtract(Duration(days: 6 - index)),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class StreakTracker extends StatelessWidget {
  final int currentStreak;
  final List<bool> solvedProblems;
  final void Function(int) solveProblem;

  const StreakTracker({
    required this.currentStreak,
    required this.solvedProblems,
    required this.solveProblem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$currentStreak Day Streak!',
          style: const TextStyle(
            color: Color(0xff26b051),
            fontFamily: 'Comfortaa',
            fontSize: 24,
          ),
        ),
        const Text(
          'Solve problems daily to maintain your streak.',
          style: TextStyle(
            color: Color(0xff26b051),
            fontFamily: 'Comfortaa',
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class DayContainer extends StatelessWidget {
  final bool solved;
  final String dayText;
  final VoidCallback onTap;

  const DayContainer({
    required this.solved,
    required this.dayText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff59c88b),
            width: 2.0,
          ),
          color: solved ? const Color(0xff59c88b) : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayText,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff26b051),
                fontFamily: 'Comfortaa',
              ),
            ),
          ],
        ),
      ),
    );
  }
}