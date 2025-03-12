// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quran_app/Models/ResultsModel.dart';
class Searchmodel {
String? query;
int? total_results;
int? current_page;
int? total_pages;
Resultsmodel? results;
  Searchmodel({
    this.query,
    this.total_results,
    this.current_page,
    this.total_pages,
    this.results,
  });

  factory Searchmodel.fromMap(Map<String, dynamic> map) {
    return Searchmodel(
      query: map['query'] != null ? map['query'] as String : null,
      total_results: map['total_results'] != null ? map['total_results'] as int : null,
      current_page: map['current_page'] != null ? map['current_page'] as int : null,
      total_pages: map['total_pages'] != null ? map['total_pages'] as int : null,
      results: map['results'] != null ? Resultsmodel.fromMap(map['results'] as Map<String,dynamic>) : null,
    );
  }

}
