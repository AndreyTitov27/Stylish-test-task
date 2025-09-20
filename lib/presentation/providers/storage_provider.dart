import 'package:flutter/material.dart';
import 'package:stylish_test_task/services/storage_service.dart';

class StorageProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  String? _userText;
  String? get userText => _userText;

  StorageProvider();

  void setUserText(String text) => _userText = text;

  Future<void> saveText(String userId, String text) async {
    await _storageService.saveText(userId, text);
    _userText = text;
    notifyListeners();
  }
  Future<String?> loadText(String userId) async {
    _userText = await _storageService.loadText(userId);
    notifyListeners();
    return _userText;
  }
}