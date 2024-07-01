import 'package:flutter/foundation.dart';

import '../services/firebase_auth_service.dart';

class AuthController with ChangeNotifier {
  final _firebaseAuthService = FirebaseAuthService();

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _firebaseAuthService.register(email: email, password: password);
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuthService.login(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    _firebaseAuthService.signOut();
    notifyListeners();
  }
}
