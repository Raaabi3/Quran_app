import 'package:http/http.dart' as http;
import 'package:quran_app/Helpers/Apilinks.dart';

Future<http.Response> FetchVersesByKeyService(String key) async {
  final response = await http.get(
    headers: {
      "x-rapidapi-host": Apilinks.host,
      "x-rapidapi-key": Apilinks.key,
    },
    Uri.parse("https://quran-com.p.rapidapi.com/quran/verses/imlaei?chapter_number=1&hizb_number=1&rub_el_hizb_number=1&verse_key=1%3A1&page_number=1&juz_number=1"),
  );
  return response;
}
