import 'VerseModel.dart';
import 'PaginationModel.dart';

class VersesResponseModel {
  final List<VerseModel> verses;
  final PaginationModel pagination;

  VersesResponseModel({
    required this.verses,
    required this.pagination,
  });

  factory VersesResponseModel.fromMap(Map<String, dynamic> map) {
    return VersesResponseModel(
      verses: (map['verses'] as List<dynamic>?)
              ?.map((x) => VerseModel.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [], // Default empty list
      pagination: PaginationModel.fromMap(map['pagination'] as Map<String, dynamic>),
    );
  }
}
