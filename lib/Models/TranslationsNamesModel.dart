class Translationsnamesmodel {
  String? name;
  String? language_name;

  Translationsnamesmodel({this.name, this.language_name});

  factory Translationsnamesmodel.fromMap(Map<String, dynamic> map) {
    return Translationsnamesmodel(
      name: map['name'] as String?,
      language_name: map['language_name'] as String?,
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'language_name': language_name,
      'name': name,
    };
  }
}
