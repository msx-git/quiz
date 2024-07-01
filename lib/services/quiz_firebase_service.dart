import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/models/question.dart';

class QuizFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('quiz');

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _quizCollection.snapshots();
  }

  void addQuestion({required Question question}) {
    _quizCollection.add(question.toJson());
  }

  void editQuestion({required Question question}) {
    _quizCollection.doc(question.id).update(question.toJson());
  }

  void deleteQuestion({required String id}) {
    _quizCollection.doc(id).delete();
  }
}
