import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_books_app/model/mybook_model.dart';

class ApiService {
  static const String baseUrl = "https://openlibrary.org/subjects/novel.json";

  static Future<List<Book>> fetchBooks({int offset = 0, int limit = 15}) async {
    final url = "$baseUrl?limit=$limit&offset=$offset";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List booksJson = data['works'];
      return booksJson.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
