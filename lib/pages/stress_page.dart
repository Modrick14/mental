import 'package:flutter/material.dart';
import 'mental_exercise_page.dart'; // Import the Exercise Page
import 'package:url_launcher/url_launcher.dart';


class StressPage extends StatelessWidget {
  const StressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Stress Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigate back to home
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Current Stress Level
              _buildSectionHeader("Current Stress Level"),
              _imageBox("assets/stress_meter.jpg"), // Update with actual asset

              // AI Interaction
              _buildSectionHeader("Let's Interact"),
              _imageBox("assets/ai_interact.jpeg"), // Update with actual asset

              // Resources on Stress
              _buildSectionHeader("Resources on Stress"),
              _buildResourceRow(context),

              // Guided Mindful Moment
              _buildSectionHeader("Guided Mindful Moment"),
              _buildMindfulMoment(),

              // Take Exercise Button
              _buildExerciseButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.green,
        ),
      ),
    );
  }

  // Image Box
  Widget _imageBox(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(imagePath, height: 100),
    );
  }

  // Resources Row
  Widget _buildResourceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _resourceItem(context, "Books", "assets/stress_book.jpeg", "https://drchatterjee.com/books/the-stress-solution/"),
        _resourceItem(context, "Videos", "assets/stress_video.jpeg", "https://www.youtube.com/watch?v=sTpo1FuYQ9I"),
        _resourceItem(context, "Connect Live", "assets/therapy.jpeg", "https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwi6nLqhnMOMAxWCimgJHWtUBl8YABAAGgJ3Zg&co=1&gclid=CjwKCAjwzMi_BhACEiwAX4YZUO6slaBjiSK3efXWj1gPn6SkaxZxbqcjayhwmFoTTXneICa5vItn7BoCtEIQAvD_BwE&ohost=www.google.com&cid=CAESVuD2-bVUgJTDFavWqh0ycQMw1dlXd5Zzf2Wx3c8Sa9bhAG8h0z1JZPBKZOL07aaGk9NAEbz-kyMA7tl7yHx5LoeXD2l6c346F0WizXYJTuBN6lvxPFlI&sig=AOD64_3wc5oVLIk2yrY0fEMzu37GKH_bdA&q&adurl&ved=2ahUKEwiAyLGhnMOMAxXZRvEDHVPtIZYQ0Qx6BAgWEAE"),
      ],
    );
  }

  // Resource Item (Clickable)
  Widget _resourceItem(BuildContext context, String title, String imagePath, String url) {
    return GestureDetector(
      onTap: () {
        _launchURL(context, url);
      },
      child: Column(
        children: [
          Image.asset(imagePath, height: 60, width: 60),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Guided Mindful Moment
  Widget _buildMindfulMoment() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "You cannot always control what goes on outside, but you can always control what goes on inside.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
    );
  }

  // Exercise Button
  Widget _buildExerciseButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentalExercisePage()),
          
        );
      },
      icon: const Icon(Icons.fitness_center),
      label: const Text("Take Exercise"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
  );
}

  // URL Launcher (Requires url_launcher package)
  void _launchURL(BuildContext context, String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open link")),
      );
    }
  }
}
