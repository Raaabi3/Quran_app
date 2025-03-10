import 'package:http/http.dart' as http;
import 'package:quran_app/Helpers/Apilinks.dart';

Future<http.Response> FetchVersesByKeyService({
  String? versekey,
  int? chapternumber,
  int? rubelhizbnumber,
  int? hizbnumber,
  int? pagenumber,
  int? juznumber,
}) async {
  List<String> queryParams = [];
  if (chapternumber != null) {
    queryParams.add("chapter_number=$chapternumber");
  }
  if (hizbnumber != null) {
    queryParams.add("hizb_number=$hizbnumber");
  }
  if (rubelhizbnumber != null) {
    queryParams.add("rub_el_hizb_number=$rubelhizbnumber");
  }
  if (versekey != null && versekey.isNotEmpty) {
    queryParams.add("verse_key=${Uri.encodeComponent(versekey)}");
  }
  if (pagenumber != null) {
    queryParams.add("page_number=$pagenumber");
  }
  if (juznumber != null) {
    queryParams.add("juz_number=$juznumber");
  }
  String url = Apilinks.verse;
  if (queryParams.isNotEmpty) {
    url += "?" + queryParams.join("&");
  }

  final response = await http.get(
    headers: {
      "x-rapidapi-host": Apilinks.host,
      "x-rapidapi-key": Apilinks.key,
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load verses: ${response.statusCode}');
  }
}
