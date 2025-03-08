import 'package:quran_app/Models/TranslationsNamesModel.dart';

class ChapterModel {
  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final int versesCount;
  final List<int> pages;
  final Translationsnamesmodel translatedName;

  ChapterModel({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'],
      revelationPlace: map['revelation_place'],
      revelationOrder: map['revelation_order'],
      bismillahPre: map['bismillah_pre'],
      nameSimple: map['name_simple'],
      nameComplex: map['name_complex'],
      nameArabic: map['name_arabic'],
      versesCount: map['verses_count'],
      pages: List<int>.from(map['pages']),
      translatedName: Translationsnamesmodel.fromMap(map['translated_name']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'revelation_place': revelationPlace,
      'revelation_order': revelationOrder,
      'bismillah_pre': bismillahPre,
      'name_simple': nameSimple,
      'name_complex': nameComplex,
      'name_arabic': nameArabic,
      'verses_count': versesCount,
      'pages': pages,
      'translated_name': translatedName.toMap(),
    };
  }
}
