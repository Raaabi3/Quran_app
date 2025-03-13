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
  final int? sajdahNumber; // Changed from `bool?` to `int?`
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
    this.sajdahNumber, // Fixed type
    required this.words,
    required this.translations,
    required this.tafsirs,
  });

  factory VerseModel.fromMap(Map<String, dynamic> map) {
    // Extract the 'verse' object from JSON
    final verseData = map['verse'] ?? {};

    return VerseModel(
      id: verseData['id'],
      verseNumber: verseData['verse_number'],
      pageNumber: verseData['page_number'],
      verseKey: verseData['verse_key'] ?? '', // Ensure it's a string
      juzNumber: verseData['juz_number'],
      hizbNumber: verseData['hizb_number'],
      rubElHizbNumber: verseData['rub_el_hizb_number'],
      sajdahNumber: verseData['sajdah_number'], // Fixed type
      words: verseData['words'] != null
          ? List<WordModel>.from(verseData['words'].map((x) => WordModel.fromMap(x)))
          : [],
      translations: verseData['translations'] != null
          ? List<TranslationModel>.from(verseData['translations'].map((x) => TranslationModel.fromMap(x)))
          : [],
      tafsirs: verseData['tafsirs'] != null
          ? List<TafsirModel>.from(verseData['tafsirs'].map((x) => TafsirModel.fromMap(x)))
          : [],
    );
  }
}
