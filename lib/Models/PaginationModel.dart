class PaginationModel {
  final int? perPage;
  final int? currentPage;
  final int? nextPage;
  final int? totalPages;
  final int? totalRecords;

  PaginationModel({
    this.perPage,
    this.currentPage,
    this.nextPage,
    this.totalPages,
    this.totalRecords,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      perPage: map['per_page'] as int?,
      currentPage: map['current_page'] as int?,
      nextPage: map['next_page'] as int?,
      totalPages: map['total_pages'] as int?,
      totalRecords: map['total_records'] as int?,
    );
  }
}
