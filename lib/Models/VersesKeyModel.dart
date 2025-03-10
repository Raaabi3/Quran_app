import 'VerseKeyModel.dart';

class Verseskeymodel {
  final List<VerseKeyModel> verseKeyModel;

  Verseskeymodel({
    required this.verseKeyModel,
  });

  factory Verseskeymodel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> versesList = map['verses'];
    final List<VerseKeyModel> verses = versesList
        .map((verse) => VerseKeyModel.fromMap(verse))
        .toList();

    return Verseskeymodel(
      verseKeyModel: verses,
    );
  }
}