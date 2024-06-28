import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('quiz');

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _quizCollection.snapshots();
  }

  void addQuestion({
    required String questionText,
    required String answer1,
    required String answer2,
    required String answer3,
    required String correctVariant,
  }) {
    _quizCollection.add(
      {
        "questionText": questionText,
        'answers': [
          {'A': answer1},
          {'B': answer2},
          {'C': answer3},
        ],
        'correctVariant': correctVariant,
      },
    );
  }
}
