import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quran_app/Models/LanguageModel.dart';
import 'package:quran_app/Models/LanguagesModel.dart';
import 'package:quran_app/Services/FetchLanguagesService.dart';

class LanguagesProvider with ChangeNotifier {
  Languagesmodel languagesModel = Languagesmodel(languages: []);

  Future<void> fetchLanguages() async {
    try {
      final response = await fetchLanguagesService();
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('languages')) {
          languagesModel = Languagesmodel(
            languages:
                (jsonData['languages'] as List)
                    .map((data) => Languagemodel.fromMap(data))
                    .toList(),
          );
          notifyListeners();
        } else {
          debugPrint('Error: "languages" key not found in response.');
        }
      } else {
        debugPrint('Failed to fetch languages: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching languages: $e');
    }
  }
}
