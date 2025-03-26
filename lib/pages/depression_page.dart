import 'package:flutter/material.dart';
import 'mental_exercise_page.dart'; // Import the Exercise Page

class DepressionPage extends StatefulWidget {
  @override
  _DepressionPageState createState() => _DepressionPageState();
}

class _DepressionPageState extends State<DepressionPage> {
  double _depressionLevel = 5.0; // Default slider value

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Three tabs (Books, Videos, Exercise)
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Depression Management"),
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Books"),
              Tab(text: "Videos"),
              Tab(text: "Take Exercise"),
            ],
          ),
        ),
        body: Column(
          children: [
            // Depression Level Slider
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Depression Level:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: _depressionLevel,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _depressionLevel.toString(),
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        _depressionLevel = value;
                      });
                    },
                  ),
                  Center(
                    child: Text(
                      "Level: ${_depressionLevel.toInt()}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Resource Tabs (Books, Videos, Exercise)
            Expanded(
              child: TabBarView(
                children: [
                  _buildBooksTab(),
                  _buildVideosTab(),
                  _buildExerciseTab(context), // Exercise Page
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Books Tab Content
  Widget _buildBooksTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _resourceItem("The Depression Cure", "Dr. Stephen Ilardi"),
        _resourceItem("Feeling Good", "Dr. David Burns"),
        _resourceItem("The Mindful Way Through Depression", "Mark Williams"),
      ],
    );
  }

  // Videos Tab Content
  Widget _buildVideosTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _videoItem("Understanding Depression", "https://youtu.be/dPzJqN3OkmE"),
        _videoItem(
            "Cognitive Therapy for Depression", "https://youtu.be/OljcP_PzR_k"),
      ],
    );
  }

  // Exercise Tab Content
  Widget _buildExerciseTab(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MentalExercisePage()),
          );
        },
        child: const Text("Go to Exercise Page"),
      ),
    );
  }

  // Helper Widget for Books
  Widget _resourceItem(String title, String author) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(author),
        leading: const Icon(Icons.book, color: Colors.blue),
      ),
    );
  }

  // Helper Widget for Videos
  Widget _videoItem(String title, String url) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(url),
        leading: const Icon(Icons.video_library, color: Colors.red),
        onTap: () {
          // Open video link (replace with proper video player if needed)
          print("Open video: $url");
        },
      ),
    );
  }
}
