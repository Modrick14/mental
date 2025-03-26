import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  double _moodValue = 5.0;
  final List<String> _moodLabels = ["😞", "😐", "😊", "😃", "🤩"];

  void _logMood() async {
    await FirebaseFirestore.instance.collection("moods").add({
      "mood": _moodValue.toInt(),
      "timestamp": Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mood Logged Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log Your Mood")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("How do you feel today?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Slider(
              value: _moodValue,
              min: 1,
              max: 5,
              divisions: 4,
              label: _moodLabels[_moodValue.toInt() - 1],
              onChanged: (value) {
                setState(() {
                  _moodValue = value;
                });
              },
            ),
            Text(
              _moodLabels[_moodValue.toInt() - 1],
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: _logMood,
              child: const Text("Log My Mood"),
            ),
            const SizedBox(height: 20),
            const Text("Mood Trends (Last 7 Days)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MoodChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(1, 2),
              const FlSpot(2, 3),
              const FlSpot(3, 5),
              const FlSpot(4, 4),
              const FlSpot(5, 3),
              const FlSpot(6, 2),
              const FlSpot(7, 4),
            ],
            isCurved: true,
            gradient:
                LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
