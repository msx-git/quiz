import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('leaderboard');

  Stream<QuerySnapshot> getRecords() async* {
    yield* _quizCollection.snapshots();
  }

  Future<void> addRecord({required String email, required num points}) async {
    await _quizCollection.add({
      "email": email,
      "points": points,
    });
  }
}
