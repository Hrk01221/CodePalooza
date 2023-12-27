import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffe4f3ec),
        appBar: AppBar(
          backgroundColor: Color(0xffe4f3ec),
          title: Text('Overall Performance Chart',
          style: TextStyle(
            color: Color(0xff26b051),
              fontSize: 25,
              fontFamily: 'Comfortaa'
          ),),
        ),
        body: Center(
          child:SizedBox(
            height: 300,
            width: 350,
            child: PerformanceChart(),
          ),
        ),
      ),
    );
  }
}

class PerformanceChart extends StatelessWidget {
  // Sample data for demonstration
  final List<String> judges = ["AtCoder", "CodeChef", "Codeforces"];
  final List<double> plusPoints = [35, 30, 70]; // Total plus points for each judge
  final List<Color> barColors = [Colors.blueGrey.shade300, Colors.brown, Colors.red]; // Colors for each judge

  // Function to calculate the percentage for AtCoder
  double calculateAtCoderPercentage(double atCoderPoints, double codeChefPoints, double codeforcesPoints) {
    double totalPoints = atCoderPoints + codeChefPoints + codeforcesPoints;
    return (atCoderPoints / totalPoints) * 100;
  }

  // Function to calculate the percentage for CodeChef
  double calculateCodeChefPercentage(double atCoderPoints, double codeChefPoints, double codeforcesPoints) {
    double totalPoints = atCoderPoints + codeChefPoints + codeforcesPoints;
    return (codeChefPoints / totalPoints) * 100;
  }

  // Function to calculate the percentage for Codeforces
  double calculateCodeforcesPercentage(double atCoderPoints, double codeChefPoints, double codeforcesPoints) {
    double totalPoints = atCoderPoints + codeChefPoints + codeforcesPoints;
    return (codeforcesPoints / totalPoints) * 100;
  }

  @override
  Widget build(BuildContext context) {
    double atCoderPercentage = calculateAtCoderPercentage(plusPoints[0], plusPoints[1], plusPoints[2]);
    double codeChefPercentage = calculateCodeChefPercentage(plusPoints[0], plusPoints[1], plusPoints[2]);
    double codeforcesPercentage = calculateCodeforcesPercentage(plusPoints[0], plusPoints[1], plusPoints[2]);

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: false),
        //backgroundColor: Colors.black87,
        titlesData: FlTitlesData(
          topTitles: SideTitles(
            showTitles: false,
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              if (value >= 0 && value < judges.length) {
                return judges[value.toInt()];
              }
              return '';
            },
          ),
          /*leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return value.toString();
            },
          ),*/
        ),
        borderData: FlBorderData(show: true),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  y: atCoderPercentage,
                  colors: [barColors[0]],
                  width: 25,
                  borderRadius: BorderRadius.circular(4)
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                y: codeChefPercentage,
                colors: [barColors[1]],
                width: 25,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                  y: codeforcesPercentage,
                  colors: [barColors[2]],
                  width: 25,
                  borderRadius: BorderRadius.circular(4)
              ),
            ],
          ),
        ],
      ),
    );
  }
}