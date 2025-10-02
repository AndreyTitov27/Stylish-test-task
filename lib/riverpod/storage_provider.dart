import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_test_task/services/storage_service.dart';

final storageNotifierProvider = AsyncNotifierProvider<StorageNotifier, String?>(StorageNotifier.new);

class StorageNotifier extends AsyncNotifier<String?> {
  final _storageService = StorageService();
  final String? _initialUserText;

  StorageNotifier({String? userText}) : _initialUserText = userText;

  @override
  FutureOr<String?> build() {
    state = AsyncValue.data(_initialUserText);
    return _initialUserText;
  }

  Future<void> saveText(String userId, String text) async {
    state = AsyncValue.loading();
    await _storageService.saveText(userId, text);
    state = AsyncValue.data(text);
  }
  Future<String?> loadText(String userId) async {
    state = AsyncValue.loading();
    state = AsyncValue.data(await _storageService.loadText(userId));
    return state.value;
  }
}