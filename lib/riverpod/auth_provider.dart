import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_test_task/services/auth_service.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<User?> {
  final _authService = AuthService();
  final User? _initialUser;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  AuthNotifier({User? user}) : _initialUser = user;

  @override
  FutureOr<User?> build() {
    _authService.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    });
    state = AsyncValue.data(_initialUser);
    return state.value;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signIn(email, password);
      _errorMessage = null;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        _errorMessage = 'Invalid email or password';
      } else if (e.code == 'too-many-requests') {
        _errorMessage = 'Too many requests, try again later';
      } else {
        _errorMessage = 'Something went wrong';
      }
      state = AsyncValue.error(e, e.stackTrace ?? StackTrace.current);
      return false;
    }
  }
  Future<bool> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signUp(email, password);
      _errorMessage = null;
      return true;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'email-already-in-use') {
        _errorMessage = 'An account already exists with this email';
      } else if (e.code == 'too-many-requests') {
        _errorMessage = 'Too many requests, try again later';
      } else {
        _errorMessage = 'Something went wrong';
      }
      state = AsyncValue.error(e, e.stackTrace ?? StackTrace.current);
      return false;
    }
  }
  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncValue.data(null);
  }
}