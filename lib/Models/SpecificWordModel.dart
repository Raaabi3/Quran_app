class Specificwordmodel {
  String? char_type;
  String? text;
  bool? highlight;

  Specificwordmodel({
    this.char_type,
    this.text,
    this.highlight,
  });

  factory Specificwordmodel.fromMap(Map<String, dynamic> map) {
    return Specificwordmodel(
      char_type: map['char_type'],
      text: map['text'],
      highlight: map['highlight'] ?? false, // Default to false if null
    );
  }
}
