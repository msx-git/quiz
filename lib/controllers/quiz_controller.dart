import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/quiz_firebase_service.dart';

class QuizController extends ChangeNotifier {
  final _quizService = QuizFirebaseService();

  Stream<QuerySnapshot> get list {
    return _quizService.getQuestions();
  }
}
