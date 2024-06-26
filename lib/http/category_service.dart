import 'dart:convert';

import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<dynamic>> getCategories() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.8:5000/api/categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['categories'];
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
