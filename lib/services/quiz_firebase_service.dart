import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/models/question.dart';

class QuizFirebaseService {
  final _quizCollection = FirebaseFirestore.instance.collection('quiz');

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _quizCollection.snapshots();
  }

  Future<void> addQuestion({required Question question}) async {
    await _quizCollection.add(question.toJson());
  }

  Future<void> editQuestion({required Question question}) async {
    await _quizCollection.doc(question.id).update(question.toJson());
  }

  Future<void> deleteQuestion({required String id}) async {
    await _quizCollection.doc(id).delete();
  }
}
