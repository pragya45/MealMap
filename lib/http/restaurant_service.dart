import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mealmap/model/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

class RestaurantService {
  static const String baseUrl = 'http://192.168.100.8:5000/api/restaurants';

  static Future<List<dynamic>> getRestaurants() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
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

  static Future<List<dynamic>> searchRestaurants(String query) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl?query=$query'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  static Future<Restaurant> getRestaurantById(String id) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  static Future<List<MenuItem>> getMenuItems(String restaurantId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/menu/restaurant/$restaurantId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['menuItems'];
      return data.map((item) => MenuItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  static Future<List<Review>> getReviews(String restaurantId) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/reviews/restaurant/$restaurantId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['reviews'];
      return data.map((item) => Review.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  //list page
  static Future<List<dynamic>> getFeaturedRestaurants() async {
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/featured'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load featured restaurants');
    }
  }

  static Future<List<dynamic>> getSavedRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/user-restaurants/saved'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load saved restaurants');
    }
  }

  static Future<List<dynamic>> getLikedRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/user-restaurants/liked'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load liked restaurants');
    }
  }
}
