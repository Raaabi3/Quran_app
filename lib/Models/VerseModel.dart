import 'TafsirModel.dart';
import 'TranslationModel.dart';
import 'WordModel.dart';

class VerseModel {
  final int? id;
  final int? verseNumber;
  final int? pageNumber;
  final String verseKey;
  final int? juzNumber;
  final int? hizbNumber;
  final int? rubElHizbNumber;
  final List<WordModel> words;
  final List<TranslationModel> translations;
  final List<TafsirModel> tafsirs;

  VerseModel({
    this.id,
    this.verseNumber,
    this.pageNumber,
    required this.verseKey,
    this.juzNumber,
    this.hizbNumber,
    this.rubElHizbNumber,
    required this.words,
    required this.translations,
    required this.tafsirs,
  });

  factory VerseModel.fromMap(Map<String, dynamic> map) {
    return VerseModel(
      id: map['id'],
      verseNumber: map['verse_number'] ?? '',
      pageNumber: map['page_number'] ?? '',
      verseKey: map['verse_key'] ?? '',  // Default to empty string if null
      juzNumber: map['juz_number'] ?? '',
      hizbNumber: map['hizb_number'] ?? '',
      rubElHizbNumber: map['rub_el_hizb_number'] ?? '',
      words: map['words'] != null
          ? List<WordModel>.from(map['words'].map((x) => WordModel.fromMap(x)))
          : [],  // Default empty list if words are missing
      translations: map['translations'] != null
          ? List<TranslationModel>.from(map['translations'].map((x) => TranslationModel.fromMap(x)))
          : [],  // Default empty list if translations are missing
      tafsirs: map['tafsirs'] != null
          ? List<TafsirModel>.from(map['tafsirs'].map((x) => TafsirModel.fromMap(x)))
          : [],  // Default empty list if tafsirs are missing
    );
  }
}
