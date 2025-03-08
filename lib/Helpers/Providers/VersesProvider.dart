import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Models/VerseModel.dart'; // Assuming VerseModel is your model
import 'package:quran_app/Models/TranslationModel.dart';
import '../../Models/TafsirModel.dart';
import '../../Services/FetchRandomVerseService.dart'; // Assuming TranslationModel is your model

class VersesProvider with ChangeNotifier {
  VerseModel verse = VerseModel(
    id: null,
    verseNumber: null,
    pageNumber: null,
    verseKey: '',
    juzNumber: null,
    hizbNumber: null,
    rubElHizbNumber: null,
    words: [],
    translations: [],
    tafsirs: [],
  );
  
  List<TranslationModel> translations = [];
  List<TafsirModel> tafsirs = [];

  Future<void> fetchRandomVerse() async {
    try {
      final response = await fetchRandomVerseService();
      if (response.statusCode == 200) {
        print("success");
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('verse')) {
          final verseData = jsonData['verse'];
          verse = VerseModel.fromMap(verseData);
          if (jsonData.containsKey('translations')) {
            translations =
                (jsonData['translations'] as List)
                    .map((data) => TranslationModel.fromMap(data))
                    .toList();
          }
          if (jsonData.containsKey('tafsirs')) {
            tafsirs =
                (jsonData['tafsirs'] as List)
                    .map((data) => TafsirModel.fromMap(data))
                    .toList();
          }

          notifyListeners();
        } else {
          debugPrint('Error: "verse" key not found in response.');
        }
      } else {
        debugPrint('Failed to fetch verse: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching verse: $e');
    }
  }
}
