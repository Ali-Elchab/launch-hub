import 'package:http/http.dart' as http;
import 'dart:convert';

const String clientId = 'akowmxxqMxFpa8HRgBb9IQuQXiTCrLFqhlZySmXU';
const String clientSecret =
    'gXX1dxEIz6NphE4MBhO2UfKaBWO6et6cKPDjRak5Rdl3E0ycU8pYl0knNKjdYnQGf623F3Bh6s2SWUWkkuJ8Jt25eXRReoFESZVC2TgRD5ecvwCXLxiYd30wewLcjATc';
const String apiUrl = 'https://www.udemy.com/api-2.0/';

String get basicAuth {
  String clientIdAndSecret = '$clientId:$clientSecret';
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(clientIdAndSecret);
  return 'Basic $encoded';
}

Future<List<dynamic>> fetchUdemyCourses(searchQuery) async {
  final response = await http.get(
    Uri.parse('${apiUrl}courses/?page=1&page_size=15&search=$searchQuery'),
    headers: {
      'Authorization': basicAuth,
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> courses = data['results'];
    return courses;
  } else {
    throw Exception('Failed to load courses');
  }
}
