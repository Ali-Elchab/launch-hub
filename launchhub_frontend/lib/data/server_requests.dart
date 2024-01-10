import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseURL = 'http://10.0.2.16:8000/api/';

Future<List<dynamic>> fetchAdvisors(String category) async {
  const endpoint = 'startup/advisors'; // Replace with actual endpoint
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // Add any other headers here, like authorization tokens if needed
  };
  final queryParameters = {'category': category};

  final uri =
      Uri.parse('$_baseURL$endpoint').replace(queryParameters: queryParameters);
  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
  } else {
    throw Exception('Failed to fetch advisors: ${response.body}');
  }
}
