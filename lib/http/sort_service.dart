import 'dart:convert';

import 'package:http/http.dart' as http;

class SortService {
  static const String baseUrl = 'http://10.0.2.2:5000/api/sort';

  static Future<List<dynamic>> sortByDistance(String categoryId,
      double latitude, double longitude, String order) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/distance/$categoryId?latitude=$latitude&longitude=$longitude&order=$order'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load restaurants sorted by distance');
    }
  }

  static Future<List<dynamic>> sortByRatings(
      String categoryId, double rating) async {
    final response =
        await http.get(Uri.parse('$baseUrl/ratings/$categoryId/$rating'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load restaurants sorted by ratings');
    }
  }
}
