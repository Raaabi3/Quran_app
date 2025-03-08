// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'TranslationsNamesModel.dart';

class Languagemodel {
int? id;
String? name;
String? iso_code;
String? native_name;
String? direction;
int? translations_count;
Translationsnamesmodel? translated_name;
  Languagemodel({
    this.id,
    this.name,
    this.iso_code,
    this.native_name,
    this.direction,
    this.translations_count,
    this.translated_name,
  });


 factory Languagemodel.fromMap(Map<String, dynamic> map) {
  return Languagemodel(
    id: map['id'] as int?,
    name: map['name'] as String?,
    iso_code: map['iso_code'] as String?,
    native_name: map['native_name'] as String?,
    direction: map['direction'] as String?,
    translations_count: map['translations_count'] as int?,
    translated_name: map['translated_name'] != null
        ? Translationsnamesmodel.fromMap(map['translated_name'])
        : null,
  );
}

 }
