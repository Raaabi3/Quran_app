import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Services/FetchChaptersService.dart';
import '../../Models/ChapterModel.dart';
import '../../Models/ChaptersModel.dart';

class ChaptersProvider with ChangeNotifier {
  ChaptersModel chaptersModel = ChaptersModel(chapters: []);
  int? _Selectedchapter;


  get selectedchapter => _Selectedchapter;

  void setSelectedchapter(chapter) {
    _Selectedchapter = chapter;
    notifyListeners();
  }

  Future<void> fetchChapters() async {
    try {
      final response = await fetchChaptersService();
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('chapters')) {
        chaptersModel = ChaptersModel(
          chapters: List<ChapterModel>.from(
            jsonData['chapters'].map(
              (chapter) => ChapterModel.fromMap(chapter),
            ),
          ),
        );
        notifyListeners();
      } else {
        throw Exception('Error: "Chapters" key not found in response.');
      }
    } catch (e) {
      debugPrint('Error fetching Chapters: $e');
      throw e;
    }
  }
}
