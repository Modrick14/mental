import 'package:flutter/material.dart';

class StressAssessmentPage extends StatefulWidget {
  const StressAssessmentPage({super.key});

  @override
  State<StressAssessmentPage> createState() => _StressAssessmentPageState();
}

class _StressAssessmentPageState extends State<StressAssessmentPage> {
  final List<String> options = [
    'Never',
    'Almost Never',
    'Sometimes',
    'Fairly Often',
    'Very Often',
  ];

  // Questions
  final List<String> questions = [
    'How often have you been upset because of something that happened unexpectedly?',
    'How often have you felt that you were unable to control the important things in your life?',
    'How often have you felt nervous or "stressed"?',
    'How often have you felt confident about your ability to handle personal problems?',
    'How often have you felt that things were going your way?',
  ];

  // Each index matches a question
  List<int?> answers = List.filled(5, null);

  // Submit and calculate
  void _calculateScore() {
    if (answers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please answer all questions.")),
      );
      return;
    }

    int totalScore = 0;
    for (int i = 0; i < answers.length; i++) {
      int score = answers[i]!;

      // Reverse scoring for positively worded questions (4 and 5)
      if (i == 3 || i == 4) {
        score = 4 - score;
      }

      totalScore += score;
    }

    String level;
    if (totalScore <= 6) {
      level = "Low Stress";
    } else if (totalScore <= 13) {
      level = "Moderate Stress";
    } else {
      level = "High Stress";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Assessment Result"),
        content: Text(
          "Your stress level is: $level\n\nTotal Score: $totalScore",
        ),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stress Self-Assessment"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == questions.length) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _calculateScore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Submit Assessment"),
              ),
            );
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${index + 1}: ${questions[index]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (int optIndex = 0; optIndex < options.length; optIndex++)
                    RadioListTile<int>(
                      title: Text(options[optIndex]),
                      value: optIndex,
                      groupValue: answers[index],
                      onChanged: (value) {
                        setState(() {
                          answers[index] = value;
                        });
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

