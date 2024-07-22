import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class SortService {
  static const String baseUrl = 'http://192.168.100.8:5000/api';
//  static const String baseUrl = 'http://192.168.100.8:5000/api';
//
  static Future<List<dynamic>> getRestaurantsSortedByDistance(String categoryId,
      double latitude, double longitude, String order) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse(
          '$baseUrl/sort/distance/$categoryId?latitude=$latitude&longitude=$longitude&order=$order'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  static Future<List<dynamic>> getRestaurantsSortedByRatings(
      String categoryId, double rating) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/sort/ratings/$categoryId/$rating'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
