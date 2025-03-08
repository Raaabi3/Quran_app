import 'package:http/http.dart' as http;
import 'package:quran_app/Helpers/Apilinks.dart';

Future<http.Response> fetchLanguagesService() async {
  final response = await http.get(
    headers: {
      "x-rapidapi-host": "${Apilinks.host}",
      "x-rapidapi-key": "${Apilinks.key}",
    },
    Uri.parse(Apilinks.languages),
  );
  return response;
}
