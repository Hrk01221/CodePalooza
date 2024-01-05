import 'package:flutter/material.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DailyStreakScreen extends StatefulWidget {
  @override
  _DailyStreakScreenState createState() => _DailyStreakScreenState();
}

class _DailyStreakScreenState extends State<DailyStreakScreen> {
  SharedPreferences? _prefs;
  final List<bool> _solvedProblems = List.filled(7, false);
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSolvedProblems();
    _loadStreak();
  }

  _loadSolvedProblems() {
    setState(() {
      for (int i = 0; i < 7; i++) {
        _solvedProblems[i] = _prefs?.getBool('solved_problem_$i') ?? false;
      }
    });
  }

  _loadStreak() {
    setState(() {
      _currentStreak = _prefs?.getInt('current_streak') ?? 0;
    });
  }

  _solveProblem(int dayIndex) {
    DateTime now = DateTime.now();
    String lastDateKey = 'last_date';

    String? lastDateStr = _prefs?.getString(lastDateKey);
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
        _prefs?.setInt('current_streak', _currentStreak);
      }
    }

    _currentStreak++;
    _prefs?.setInt('current_streak', _currentStreak);

    setState(() {
      _solvedProblems[dayIndex] = !_solvedProblems[dayIndex];
      _prefs?.setBool('solved_problem_$dayIndex', _solvedProblems[dayIndex]);
    });

    _prefs?.setString(lastDateKey, DateFormat('yyyy-MM-dd').format(now));
    _loadSolvedProblems();
    _loadStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xffe4f3ec),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_currentStreak Day Streak!',
                    style: const TextStyle(
                        color: Color(0xff26b051),
                        fontFamily: 'Comfortaa',
                        fontSize: 24),
                  ),
                  const Text(
                    'Solve problems daily to maintain your streak.',
                    style: TextStyle(
                        color: Color(0xff26b051),
                        fontFamily: 'Comfortaa',
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (index) {
                      return InkWell(
                        onTap: () => _solveProblem(index),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff59c88b),
                              width: 2.0,
                            ),
                            color: _solvedProblems[index]
                                ? const Color(0xff59c88b)
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(DateTime.now().subtract(
                                    Duration(days: 6 - index))),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff26b051),
                                    fontFamily: 'Comfortaa'
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const BaseScreen();
                        },
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Color(0xff26b051),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
