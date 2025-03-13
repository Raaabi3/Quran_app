import 'ResultsModel.dart';

class Searchmodel {
  String? query;
  int? total_results;
  int? current_page;
  int? total_pages;
  List<Resultsmodel>? results; // Change this to a List

  Searchmodel({
    this.query,
    this.total_results,
    this.current_page,
    this.total_pages,
    this.results,
  });

  factory Searchmodel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey("search")) {
      throw Exception("Missing 'search' key in response");
    }

    final searchData = map["search"]; // Extract the "search" object
    return Searchmodel(
      query: searchData['query'] ?? "",
      total_results: searchData['total_results'],
      current_page: searchData['current_page'],
      total_pages: searchData['total_pages'],
      results: searchData['results'] != null
          ? List<Resultsmodel>.from(
              searchData['results'].map((x) => Resultsmodel.fromMap(x)))
          : [],
    );
  }
}
