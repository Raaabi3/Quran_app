import 'TranslationModel.dart';

class WordModel {
  final int id;
  final int position;
  final String audioUrl;
  final String charTypeName;
  final int lineNumber;
  final int pageNumber;
  final String codeV1;
  final TranslationModel translation;
  final TranslationModel transliteration;

  WordModel({
    required this.id,
    required this.position,
    required this.audioUrl,
    required this.charTypeName,
    required this.lineNumber,
    required this.pageNumber,
    required this.codeV1,
    required this.translation,
    required this.transliteration,
  });

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      position: map['position'],
      audioUrl: map['audio_url']  ?? '',
      charTypeName: map['char_type_name'],
      lineNumber: map['line_number'],
      pageNumber: map['page_number'],
      codeV1: map['code_v1'],
      translation: TranslationModel.fromMap(map['translation']),
      transliteration: TranslationModel.fromMap(map['transliteration']),
    );
  }
}
