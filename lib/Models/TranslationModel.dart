class TranslationModel {
  final String text;
  final String languageName;

  TranslationModel({
    required this.text,
    required this.languageName,
  });

  factory TranslationModel.fromMap(Map<String, dynamic> map) {
    return TranslationModel(
      text: map['text']  ?? '',
      languageName: map['language_name'] ?? '',
    );
  }
}
