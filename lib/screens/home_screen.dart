import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mood_page.dart';
import 'package:mental_health_app/pages/depression_page.dart';
import 'package:mental_health_app/pages/ocd_page.dart';
import 'package:mental_health_app/pages/stress_page.dart';
import 'package:mental_health_app/pages/stress_assessment_page.dart'; // <-- Import your assessment page

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.green),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back, ${user?.displayName ?? 'User'}!",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user?.email ?? "user@example.com",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.notifications, color: Colors.white),
            const SizedBox(width: 10),
            const Icon(Icons.menu, color: Colors.white),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back_ground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Assessment Card placed at the top
                  _buildAssessmentCard(context),

                  // Mood and Analytics
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoodPage()),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Image.asset("assets/mood.jpg", height: 80),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Current Mood",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset("assets/analytics.jpeg",
                                    height: 80),
                                const SizedBox(height: 5),
                                const Text(
                                  "Analytics",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Serenity AI Card
                  Card(
                    color: Colors.purple[100],
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/ai_bot.jpeg", height: 60),
                          const SizedBox(width: 10),
                          const Text(
                            "Serenity AI",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Stress, Depression, OCD Buttons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _featureBox(context, "Stress Status", Colors.green,
                          const StressPage()),
                      _featureBox(
                          context, "Depression", Colors.blue, DepressionPage()),
                      _featureBox(context, "OCD", Colors.orange, OCDPage()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🧠 Mental Health Assessment Card Widget
  Widget _buildAssessmentCard(BuildContext context) {
    return Card(
      color: Colors.deepPurple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Text and Button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Track Your Mental Health,\nTransform Your Life!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StressAssessmentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Start Assessment"),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Illustration
            Image.asset(
              "assets/assessment.jpg", // <-- Replace with your asset image
              height: 80,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }

  // Feature Shortcut Boxes
  Widget _featureBox(
      BuildContext context, String title, Color color, Widget? page) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
