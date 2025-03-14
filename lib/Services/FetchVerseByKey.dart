import 'package:http/http.dart' as http;
import 'package:quran_app/Helpers/Apilinks.dart';

Future<http.Response> fetchVerseByKeyService(key) async {
  final response = await http.get(
    headers: {
      "x-rapidapi-host": Apilinks.host,
      "x-rapidapi-key": Apilinks.key,
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    Uri.parse(Apilinks.versebykey(key)+"?language=en"),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load chapters: ${response.statusCode}');
  }
}
