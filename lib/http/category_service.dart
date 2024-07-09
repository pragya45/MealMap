import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class CategoryService {
  static const String baseUrl = 'http://10.0.2.2:5000/api/categories';

  static Future<List<dynamic>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['categories'];
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to load categories');
    }
  }

  static Future<Map<String, dynamic>> getCategoryById(String categoryId) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/$categoryId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final category = json.decode(response.body)['category'];
        print('Fetched category: $category');
        return category;
      } else {
        print('Failed to load category: ${response.body}');
        throw Exception('Failed to load category');
      }
    } catch (e) {
      print('Error fetching category: $e');
      throw Exception('Failed to load category');
    }
  }

  static Future<List<dynamic>> searchCategories(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/categories/search?query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['categories'];
    } else {
      throw Exception('Failed to search categories');
    }
  }
}
