import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Models/VersesKeyModel.dart';
import 'package:quran_app/Services/FetchVerseByKey.dart';

import '../QuranHomeScreenController.dart';

class VersesProvider with ChangeNotifier {
  Verseskeymodel? verseskeymodel;
  bool _isLoadingVerses = false;
  String? _verseErrorMessage;
  bool get isLoadingVerses => _isLoadingVerses;
  String? get verseErrorMessage => _verseErrorMessage;

  int? _page;

  get page => _page;
  void setPage(page) {
    _page = page;
    notifyListeners();
  }

  Future<void> fetchVerseByKey(
    int page,
    QuranHomeScreenController controller,
  ) async {
    await controller.fetchWithRetry(() async {
      try {
        _isLoadingVerses = true;
        _verseErrorMessage = null;
        notifyListeners();
        final response = await FetchVersesByKeyService(pagenumber: page);
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('verses')) {
          verseskeymodel = Verseskeymodel.fromMap(jsonData);
          notifyListeners();
        } else {
          throw Exception('Error: "Verses" key not found in response.');
        }
      } catch (e) {
        debugPrint('Error fetching verses: $e');
        _verseErrorMessage = 'Failed to load verses: $e';
        notifyListeners();
        throw e;
      } finally {
        _isLoadingVerses = false;
        notifyListeners();
      }
    });
  }
}
