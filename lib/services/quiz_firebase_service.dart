import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('quiz');

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _quizCollection.snapshots();
  }



}
