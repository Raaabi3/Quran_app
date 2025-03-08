class TafsirModel {
  final int id;
  final String languageName;
  final String name;
  final String text;

  TafsirModel({
    required this.id,
    required this.languageName,
    required this.name,
    required this.text,
  });

  factory TafsirModel.fromMap(Map<String, dynamic> map) {
    return TafsirModel(
      id: map['id'],
      languageName: map['language_name'],
      name: map['name'],
      text: map['text'],
    );
  }
}
