import 'package:http/http.dart' as http;
import 'package:quran_app/Helpers/Apilinks.dart';

Future<http.Response> fetchChaptersService() async {
  final response = await http.get(
    headers: {
      "x-rapidapi-host": "${Apilinks.host}",
      "x-rapidapi-key": "${Apilinks.key}",
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    Uri.parse(Apilinks.chapters + "?language=en"),
  );
  return response;
}
