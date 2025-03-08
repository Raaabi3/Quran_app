import 'ChapterModel.dart';

class ChaptersModel {
  final List<ChapterModel> chapters;
  ChaptersModel({required this.chapters});
  factory ChaptersModel.fromMap(Map<String, dynamic> map) {
    return ChaptersModel(
      chapters: List<ChapterModel>.from(
        map['chapters'].map((chapter) => ChapterModel.fromMap(chapter)),
      ),
    );
  }
  Map<String, dynamic> toMap() {
    return {'chapters': chapters.map((chapter) => chapter.toMap()).toList()};
  }
}
