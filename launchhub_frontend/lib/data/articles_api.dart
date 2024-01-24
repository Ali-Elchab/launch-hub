// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<List<dynamic>> fetchArticles(query) async {
//   final response = await http.get(
//     Uri.parse(
//         'https://newsapi.org/v2/everything?q=$query&pageSize=8&sortBy=popularity&apiKey=9c1cdbcfe9564f01bf1e3e18e85ab91f'),
//     headers: {
//       "Content-Type": "application/json",
//       "Accept": "application/json, text/plain, */*",
//     },
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     final List<dynamic> articles = data['articles'];
//     return articles;
//   } else {
//     throw Exception('Failed to load Articles');
//   }
// }
