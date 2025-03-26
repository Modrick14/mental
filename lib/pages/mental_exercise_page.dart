import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MentalExercisePage extends StatefulWidget {
  @override
  _MentalExercisePageState createState() => _MentalExercisePageState();
}

class _MentalExercisePageState extends State<MentalExercisePage> {
  int totalTime = 1500; // 25 minutes in seconds
  int remainingTime = 1500;
  bool isRunning = false;
  Timer? timer;

  // List of Exercises
  final List<Map<String, String>> exercises = [
    {"title": "Breathing Exercise", "duration": "5 min"},
    {"title": "Mindfulness", "duration": "5 min"},
    {"title": "Mood Journaling", "duration": "5 min"},
    {"title": "Self-Compassion Practices", "duration": "5 min"},
    {"title": "Gratitude Practice", "duration": "5 min"},
  ];

  // Start Timer
  void startTimer() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
      }
    });
  }

  // Stop Timer
  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  // Reset Timer
  void resetTimer() {
    stopTimer();
    setState(() {
      remainingTime = totalTime;
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100], // Light green background
      appBar: AppBar(
        title: Text("Mental Exercise"),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Practice these exercises to improve your mental well-being.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // List of Exercises
            Column(
              children: exercises.map((exercise) {
                return ListTile(
                  title: Text(
                    exercise["title"]!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    exercise["duration"]!,
                    style: TextStyle(fontSize: 16, color: Colors.green[700]),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // Circular Timer
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: remainingTime / totalTime,
                center: Text(
                  "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),

            SizedBox(height: 20),

            // Start & Stop Buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isRunning ? null : startTimer,
                    child: Text("Start"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: isRunning ? stopTimer : null,
                    child: Text("Stop"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: resetTimer,
                    child: Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Back Button
            Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
