import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Models/VerseModel.dart'; 
import 'package:quran_app/Models/TranslationModel.dart';
import 'package:quran_app/Services/FetchVerseByKey.dart';
import '../../Models/TafsirModel.dart';
import '../../Models/VerseKeyModel.dart';
import '../../Services/FetchVerseByPageService.dart'; 

class VersesProvider with ChangeNotifier {
  VerseModel? verse;
  List<TranslationModel> translations = [];
  List<TafsirModel> tafsirs = [];

  VerseKeyModel verseKeyModel = VerseKeyModel(
    id: null,
    verseKey: '',
    text_imlaei: '',
  );

  Future<void> fetchVerseByKey(String key) async{
    try {
     final response = await FetchVersesByKeyService(key);  
      if (response.statusCode == 200) {
        print("success");
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('verses')) {
          final verseData = jsonData['verses'][0];  
          verseKeyModel = VerseKeyModel.fromMap(verseData);  
          notifyListeners();
        } else {
          debugPrint('Error: "verses" key not found in response.');
        }
      } else {
        debugPrint('Failed to fetch verse: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching verse: $e');
    }
}

  Future<void> fetchVersesByPage(int page) async {
    try {
      final response = await FetchVersesByPageService(page);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('verses') && (jsonData['verses'] as List).isNotEmpty) {
          final verseData = jsonData['verses'][0];  
          verse = VerseModel.fromMap(verseData);
          translations = (verseData['translations'] as List?)?.map((data) => TranslationModel.fromMap(data)).toList() ?? [];
          tafsirs = (verseData['tafsirs'] as List?)?.map((data) => TafsirModel.fromMap(data)).toList() ?? [];
          notifyListeners();
        } else {
          debugPrint('Error: "verses" key not found or empty in response.');
        }
      } else {
        debugPrint('Failed to fetch verse: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching verse: $e');
    }
  }
}
