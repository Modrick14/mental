import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MentalExercisePage extends StatefulWidget {
  const MentalExercisePage({super.key});

  @override
  _MentalExercisePageState createState() => _MentalExercisePageState();
}

class _MentalExercisePageState extends State<MentalExercisePage> {
  int totalTime = 1500; // 25 minutes in seconds
  int remainingTime = 1500;
  bool isRunning = false;
  Timer? timer;

  final List<Map<String, String>> exercises = [
    {"title": "Breathing Exercise", "duration": "5 min"},
    {"title": "Mindfulness", "duration": "5 min"},
    {"title": "Mood Journaling", "duration": "5 min"},
    {"title": "Self-Compassion Practices", "duration": "5 min"},
    {"title": "Gratitude Practice", "duration": "5 min"},
  ];

  void startTimer() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      remainingTime = totalTime;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Mental Exercise"),
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Practice these exercises to improve your mental well-being.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Clickable Exercises
              Column(
                children: exercises.map((exercise) {
                  return ListTile(
                    title: Text(
                      exercise["title"]!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      exercise["duration"]!,
                      style: TextStyle(fontSize: 16, color: Colors.green[700]),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Starting ${exercise["title"]}...')),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Circular Timer
              Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: remainingTime / totalTime,
                  center: Text(
                    "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey[300]!,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isRunning ? null : startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Start"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: isRunning ? stopTimer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Stop"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Reset"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Back Button
              Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
