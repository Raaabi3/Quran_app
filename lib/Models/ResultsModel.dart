import 'SpecificWordModel.dart';

class Resultsmodel {
  String? verse_key;
  int? verse_id;
  String? text;
  String? highlighted;
  List<Specificwordmodel>? words; // Change to a List
  List<String>? translations; // Change to a List

  Resultsmodel({
    this.verse_key,
    this.verse_id,
    this.text,
    this.highlighted,
    this.words,
    this.translations,
  });

  factory Resultsmodel.fromMap(Map<String, dynamic> map) {
    return Resultsmodel(
      verse_key: map['verse_key'],
      verse_id: map['verse_id'],
      text: map['text'],
      highlighted: map['highlighted'],
      words: map['words'] != null
          ? List<Specificwordmodel>.from(
              map['words'].map((x) => Specificwordmodel.fromMap(x)))
          : [],
      translations: map['translations'] != null
          ? List<String>.from(map['translations'])
          : [],
    );
  }
}
