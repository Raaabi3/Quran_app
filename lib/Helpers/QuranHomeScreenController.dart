import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranHomeScreenController with ChangeNotifier {
  bool _isRetrying = false; // Track if the retry function is still running
  String? _errorMessage; // Store error messages
  bool _isSearching = false; // Track search state

  bool get isRetrying => _isRetrying; // Expose retry state
  String? get errorMessage => _errorMessage; // Expose error message
  bool get isSearching => _isSearching; // Expose search state

  // Update search state
  void searchingState(bool state) {
    _isSearching = state;
    notifyListeners();
  }

  void setisretrying(value){
    _isRetrying = !_isRetrying;
    notifyListeners();
  }

  // Retry function with loading state management
  Future<void> fetchWithRetry(Future<void> Function() fetchFunction) async {
    const int maxRetries = 5; // Maximum number of retries
    const Duration retryDelay = Duration(seconds: 2); // Delay between retries

    _isRetrying = true; // Set retry state to true
    _errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners of state change

    for (var attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        await fetchFunction(); // Execute the provided function
        _isRetrying = false; // Set retry state to false on success
        notifyListeners(); // Notify listeners of state change
        return; // Exit the function on success
      } catch (e) {
        debugPrint('Retry attempt $attempt failed: $e');

        if (attempt == maxRetries) {
          // If all retries are exhausted
          _isRetrying = false; // Set retry state to false
          _errorMessage = 'Failed after $maxRetries attempts: ${e.toString()}'; // Set error message
          notifyListeners(); // Notify listeners of state change
        } else {
          await Future.delayed(retryDelay); // Wait before the next retry
        }
      }
    }
  }

  // Save page and selected chapter to SharedPreferences
  Future<void> saveData(int page, int selectedChapter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Page', page);
    await prefs.setInt('SelectedChapter', selectedChapter);
  }

  // Check if the current page is the end of a Surah
  bool endSurah(int chapter, int page) {
    return page == chapter;
  }

  // Load saved page from SharedPreferences
  Future<int> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Page') ?? -1; // Return -1 if no saved page is found
  }
}