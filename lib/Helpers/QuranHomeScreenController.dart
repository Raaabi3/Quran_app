import 'package:flutter/material.dart';

class QuranHomeScreenController with ChangeNotifier {
  bool _isRetrying = false;
  String? _errorMessage;
  bool get isRetrying => _isRetrying;
  String? get errorMessage => _errorMessage;
  bool _isSeacrching = false;

  bool get isSearching => _isSeacrching;
  void searchingState(state){
    _isSeacrching = state;
    notifyListeners();
  }


  Future<void> fetchWithRetry(Future<void> Function() fetchFunction) async {
    const int maxRetries = 5;
    const Duration retryDelay = Duration(seconds: 2);

    _isRetrying = true;
    _errorMessage = null;
    notifyListeners();

    for (var attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        await fetchFunction();
        _isRetrying = false;
        notifyListeners();
        return;
      } catch (e) {
        debugPrint('Retry attempt $attempt failed: $e');

        if (attempt == maxRetries) {
          _isRetrying = false;
          _errorMessage = 'Failed after $maxRetries attempts';
          notifyListeners();
        } else {
          await Future.delayed(retryDelay);
        }
      }
    }
  }
}