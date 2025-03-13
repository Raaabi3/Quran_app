import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Models/SearchModel.dart';
import '../../Services/FetchSearchQuery.dart';
import '../QuranHomeScreenController.dart';

class Searchqueryprovider with ChangeNotifier {
  Searchmodel searchmodel = Searchmodel();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Inside Searchqueryprovider class
Future<void> fetchSearchQuery(
  String text,
  QuranHomeScreenController controller,
) async {
  await controller.fetchWithRetry(() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await fetchSearchQueryService(text);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        searchmodel = Searchmodel.fromMap(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch search query: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching search query: $e');
      _errorMessage = 'Failed to load search results: $e';
      notifyListeners();
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  });
}
}
