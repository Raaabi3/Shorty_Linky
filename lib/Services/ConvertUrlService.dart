import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Helpers/apilinks.dart';

Future<http.Response> shortenUrlService(String originalUrl) async {
  final response = await http.post(
    Uri.parse(Apilinks.shortenEndpoint),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'x-rapidapi-host': Apilinks.host,
      'x-rapidapi-key': Apilinks.key,
    },
    body: jsonEncode({"url": originalUrl}),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to shorten URL: ${response.statusCode}');
  }
}
