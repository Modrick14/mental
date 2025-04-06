import 'package:flutter/material.dart';
import 'mental_exercise_page.dart'; // Import the Exercise Page
import 'package:url_launcher/url_launcher.dart';


class OCDPage extends StatefulWidget {
  @override
  _OCDPageState createState() => _OCDPageState();
}

class _OCDPageState extends State<OCDPage> {
  double _ocdLevel = 5.0; // Default OCD Level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OCD Management"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // OCD Level & AI Interaction
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureBox(
                    "Current OCD Level",
                    "assets/ocd_chart.png"), // Replace with your image
                _buildFeatureBox(
                    "Let's Interact", "assets/ai_interact.jpeg"), // AI Section
              ],
            ),
            const SizedBox(height: 20),

            // OCD Level Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Current OCD Level:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _ocdLevel,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _ocdLevel.toString(),
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      _ocdLevel = value;
                    });
                  },
                ),
                Center(
                  child: Text(
                    "Level: ${_ocdLevel.toInt()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Resources Section
            _buildResourcesSection(),

            const SizedBox(height: 20),

            // Guided Mindful Moment
            _buildMindfulMoment(),

            const SizedBox(height: 20),

            // Take Exercise Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MentalExercisePage()),
                  );
                },
                icon: const Icon(Icons.directions_run, color: Colors.white),
                label: const Text("Take Exercise"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feature Box (OCD Level & AI Interaction)
  Widget _buildFeatureBox(String title, String imagePath) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 5),
        Image.asset(imagePath, height: 100, width: 140, fit: BoxFit.cover),
      ],
    );
  }

  // Resources Section
// Resources Section
  Widget _buildResourcesSection() {
    return Column(
      children: [
        const Text(
          "Resources on OCD",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _resourceItem("OCD Treatment", "assets/ocd_book.png", "https://www.google.co.ug/books/edition/Coping_with_OCD/gA2ul02-64YC?hl=en&gbpv=0"),
            _resourceItem("Videos", "assets/ocd_video.jpeg", "https://www.google.com/imgres?q=ocd%20video&imgurl=https%3A%2F%2Fi.ytimg.com%2Fvi%2FivyLkTcvanQ%2Fmaxresdefault.jpg&imgrefurl=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DivyLkTcvanQ&docid=r89mekZ-_A9yxM&tbnid=aQweBImeU-OsdM&vet=12ahUKEwjuh96boLqMAxWqSfEDHdgMLSsQM3oECGgQAA..i&w=1280&h=720&hcb=2&ved=2ahUKEwjuh96boLqMAxWqSfEDHdgMLSsQM3oECGgQAA"),
            _resourceItem("Connect Live", "assets/therapy.jpeg", "https://www.google.com/imgres?q=ocd%20therapy&imgurl=https%3A%2F%2Fwww.verywellmind.com%2Fthmb%2F5xATjyn_J9gN7BtaEgQSx2J3wmw%3D%2F1500x0%2Ffilters%3Ano_upscale()%3Amax_bytes(150000)%3Astrip_icc()%2F4-things-your-therapist-should-avoid-in-ocd-treatment-5194864_final1-0fcc05d0efe64435bc2cbf8a66256dc4.png&imgrefurl=https%3A%2F%2Fwww.verywellmind.com%2F4-things-your-therapist-should-avoid-in-ocd-treatment-5194864&docid=9-jkdLw3QgbsrM&tbnid=5slZVyCmRiTYHM&vet=12ahUKEwiIiY7WoLqMAxXwSPEDHYtENU8QM3oFCIMBEAA..i&w=1500&h=1000&hcb=2&ved=2ahUKEwiIiY7WoLqMAxXwSPEDHYtENU8QM3oFCIMBEAA"),
          ],
        ),
      ],
    );
  }

  // Clickable Resource Item
  Widget _resourceItem(String title, String imagePath, String url) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          debugPrint("Could not open $url");
        }
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: const Text(
        "I am aware of these thoughts and feelings, and I can let them be without engaging!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
    );
  }
}
