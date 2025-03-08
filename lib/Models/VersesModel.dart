import 'package:quran_app/Models/VerseModel.dart';

class Versesmodel {
  List<VerseModel> verses;

  Versesmodel({required this.verses});

  factory Versesmodel.fromJson(List<dynamic> jsonList) {
    return Versesmodel(
      verses: jsonList.map((data) => VerseModel.fromMap(data)).toList(),
    );
  }
}
