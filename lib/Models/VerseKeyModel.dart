class VerseKeyModel {
  final int? id;
  final String verseKey;
  final String text_imlaei;

  VerseKeyModel({
    this.id,
    required this.verseKey,
    required this.text_imlaei ,
  });

  factory VerseKeyModel.fromMap(Map<String, dynamic> map) {
    return VerseKeyModel(
      id: map['id'],
      verseKey: map['verse_key'] ?? '',
      text_imlaei: map['text_imlaei'] ?? '',
    );
  }
}
