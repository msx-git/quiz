import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/quiz_firebase_service.dart';

class QuizController extends ChangeNotifier {
  final _quizService = QuizFirebaseService();

  Stream<QuerySnapshot> get list {
    return _quizService.getQuestions();
  }

  void addQuestion({
    required String questionText,
    required String answer1,
    required String answer2,
    required String answer3,
    required String correctVariant,
  }) {
    _quizService.addQuestion(
        questionText: questionText,
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
        correctVariant: correctVariant);
  }
}
