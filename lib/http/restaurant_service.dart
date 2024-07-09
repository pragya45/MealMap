import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mealmap/model/restaurant_model.dart';

import 'auth_service.dart';

class RestaurantService {
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  static Future<List<dynamic>> getRestaurants() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/restaurants'),
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
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  static Future<List<dynamic>> getFeaturedRestaurants() async {
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/featured'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load featured restaurants');
    }
  }

  static Future<List<dynamic>> getLikedRestaurants() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user-restaurants/liked'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load liked restaurants');
    }
  }

  static Future<List<dynamic>> getRestaurantsByCategory(String category) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/by-category?category=$category'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load restaurants by category');
    }
  }

  static Future<List<dynamic>> searchRestaurantsByCategory(
      String category, String query) async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/search?category=$category&query=$query'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to search restaurants by category');
    }
  }

  static Future<void> unlikeRestaurant(String restaurantId) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/user-restaurants/unlike'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'restaurantId': restaurantId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to unlike restaurant');
    }
  }

  static Future<List<dynamic>> getSavedRestaurants() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/user-restaurants/saved'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load saved restaurants');
    }
  }

  static Future<void> unsaveRestaurant(String restaurantId) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/user-restaurants/unsave'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'restaurantId': restaurantId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to unsave restaurant');
    }
  }
}
