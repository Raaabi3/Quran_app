import 'package:quran_app/Models/LanguageModel.dart';

class Languagesmodel {
  List<Languagemodel> languages;

  Languagesmodel({required this.languages});

  // Factory constructor to create an instance from a JSON list
  factory Languagesmodel.fromJson(List<dynamic> jsonList) {
    return Languagesmodel(
      languages: jsonList.map((data) => Languagemodel.fromMap(data)).toList(),
    );
  }
}
