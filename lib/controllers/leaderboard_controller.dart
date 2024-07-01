import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/leaderboard_firebase_service.dart';

class LeaderboardController extends ChangeNotifier {
  final _leaderBoardFirebaseService = LeaderboardFirebaseService();

  Stream<QuerySnapshot> get list {
    return _leaderBoardFirebaseService.getRecords();
  }

  Future<void> addRecord({required String email, required num points}) async {
    await _leaderBoardFirebaseService.addRecord(email: email, points: points);
    notifyListeners();
  }
}
