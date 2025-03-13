import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Models/VerseModel.dart';
import 'package:quran_app/Models/VersesKeyModel.dart';
import 'package:quran_app/Services/FetchVerseByPage.dart';

import '../../Services/FetchVerseByKey.dart';
import '../QuranHomeScreenController.dart';

class VersesProvider with ChangeNotifier {
  Verseskeymodel? verseskeymodel;
  VerseModel? verseModel;
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
    String key,
    QuranHomeScreenController controller,
  ) async {
    await controller.fetchWithRetry(() async {
      try {
        
        _isLoadingVerses = true;
        _verseErrorMessage = null;
        notifyListeners();
        final response = await fetchVerseByKeyService(key);
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('verse')) {
          verseModel = VerseModel.fromMap(jsonData);
          setPage(verseModel!.pageNumber);
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

  Future<void> fetchVerseByPage(
    int page,
    QuranHomeScreenController controller,
  ) async {
    await controller.fetchWithRetry(() async {
      try {
        _isLoadingVerses = true;
        _verseErrorMessage = null;
        notifyListeners();
        final response = await fetchVersesService(pagenumber: page);
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
