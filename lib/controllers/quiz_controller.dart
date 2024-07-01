import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/quiz_firebase_service.dart';

import '../models/question.dart';

class QuizController extends ChangeNotifier {
  final _quizService = QuizFirebaseService();

  Stream<QuerySnapshot> get list {
    return _quizService.getQuestions();
  }

  void addQuestion({required Question question}) {
    _quizService.addQuestion(question: question);
    notifyListeners();
  }

  void editQuestion({required Question question}) {
    _quizService.editQuestion(question: question);
    notifyListeners();
  }

  void deleteQuestion({required String id}) {
    _quizService.deleteQuestion(id: id);
    notifyListeners();
  }
}
