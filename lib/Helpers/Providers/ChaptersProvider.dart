import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_app/Services/FetchChaptersService.dart';

import '../../Models/ChapterModel.dart';
import '../../Models/ChaptersModel.dart';

class ChaptersProvider with ChangeNotifier {
  ChaptersModel chaptersModel = ChaptersModel(chapters: []);

  Future<void> fetchChapters() async {
    final response = await fetchChaptersService();
    try {
      debugPrint('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print("succcess");
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
          debugPrint('Error: "Chapters" key not found in response.');
        }
      } else {
        debugPrint('Failed to fetch Chapters: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching Chapters: $e');
    }
  }
}
