import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  final String? id;
  final String questionText;
  final List answers;
  final String correctVariant;

  Question({
    this.id,
    required this.questionText,
    required this.answers,
    required this.correctVariant,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'answers': answers,
      'correctVariant': correctVariant,
    };
  }

  factory Question.fromJson(QueryDocumentSnapshot query) {
    return Question(
      id: query.id,
      questionText: query['questionText'] as String,
      answers: query['answers'],
      correctVariant: query['correctVariant'] as String,
    );
  }
}
//
// final questions = [
//   Question(
//     id: UniqueKey().toString(),
//     questionText: "Capital of Uzbekistan?",
//     answers: [
//       {'A': "Namangan"},
//       {'B': "Andijan"},
//       {'C': "Tashkent"},
//     ],
//     correctVariant: 'C',
//   ),
//   Question(
//     id: UniqueKey().toString(),
//     questionText: "Capital of England?",
//     answers: [
//       {'A': "Wales"},
//       {'B': "London"},
//       {'C': "Paris"},
//     ],
//     correctVariant: 'B',
//   ),
//   Question(
//     id: UniqueKey().toString(),
//     questionText: "Water boils at ...\u2103?",
//     answers: [
//       {'A': "100\u2103"},
//       {'B': "80\u2103"},
//       {'C': "91\u2103"},
//     ],
//     correctVariant: 'A',
//   ),
//   Question(
//     id: UniqueKey().toString(),
//     questionText: "Water freezes at ...\u2103?",
//     answers: [
//       {'A': "5\u2103"},
//       {'B': "0\u2103"},
//       {'C': "1\u2103"},
//     ],
//     correctVariant: 'B',
//   ),
// ];
