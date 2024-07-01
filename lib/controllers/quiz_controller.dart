import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/quiz_firebase_service.dart';

import '../models/question.dart';

class QuizController extends ChangeNotifier {
  final _quizService = QuizFirebaseService();

  Stream<QuerySnapshot> get list {
    return _quizService.getQuestions();
  }

  Future<void> addQuestion({required Question question}) async {
    await _quizService.addQuestion(question: question);
  }

  Future<void> editQuestion({required Question question}) async {
    await _quizService.editQuestion(question: question);
  }

  Future<void> deleteQuestion({required String id}) async {
    await _quizService.deleteQuestion(id: id);
  }
}
