// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quran_app/Models/WordModel.dart';

class Resultsmodel {
String? verse_key;
int? verse_id;
String? text;
bool? highlighted;
WordModel? words;
String? translations;
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
      verse_key: map['verse_key'] != null ? map['verse_key'] as String : null,
      verse_id: map['verse_id'] != null ? map['verse_id'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
      highlighted: map['highlighted'] != null ? map['highlighted'] as bool : null,
      words: map['words'] != null ? WordModel.fromMap(map['words'] as Map<String,dynamic>) : null,
      translations: map['translations'] != null ? map['translations'] as String : null,
    );
  }

}
