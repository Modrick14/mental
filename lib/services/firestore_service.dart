import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logMood(int moodValue) async {
    try {
      await _db.collection('moods').add({
        'moodValue': moodValue,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print("Error logging mood: $e");
    }
  }
}
