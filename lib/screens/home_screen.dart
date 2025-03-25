import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.green[50], // Light green background
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Mood & Analytics
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset("assets/mood.jpg",
                              height: 80), // Replace with actual image
                          const SizedBox(height: 5),
                          const Text(
                            "Current Mood",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
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
                              height: 80), // Replace with actual image
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
            // Serenity AI
            Card(
              color: Colors.purple[100],
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.asset("assets/ai_bot.jpeg",
                        height: 80), // Replace with actual image
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
            // Stress, Depression, OCD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _featureBox("Stress Status", Colors.green),
                _featureBox("Depression", Colors.blue),
                _featureBox("OCD", Colors.orange),
              ],
            ),
            const SizedBox(height: 10),
            // Daily Meditation
            Card(
              color: Colors.grey[200],
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Daily Meditation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "“True happiness is to enjoy the present, without anxious dependence upon the future.”",
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.touch_app, color: Colors.green),
                        onPressed: () {
                          // Meditation page navigation (implement later)
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create feature boxes
  Widget _featureBox(String title, Color color) {
    return Expanded(
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
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
