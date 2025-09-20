import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_test_task/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  User? _user;
  User? get user => _user;

  AuthProvider() {
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      _errorMessage = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        _errorMessage = 'Invalid email or password';
      }
      notifyListeners();
      return false;
    }
  }
  Future<bool> signUp(String email, String password) async {
    try {
      await _authService.signUp(email, password);
      _errorMessage = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'email-already-in-use') {
        _errorMessage = 'An account already exists with this email';
      }
      notifyListeners();
      return false;
    }
  }
  Future<void> signOut() async {
    await _authService.signOut();
  }
}