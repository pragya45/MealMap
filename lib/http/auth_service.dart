import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.100.8:5000/api';

  static Future<bool> register(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullName': fullName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    } else {
      throw Exception('Failed to register');
    }
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    } else {
      throw Exception('Failed to login');
    }
  }

//getting token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

//liked restaurant
  static Future<List<dynamic>> getLikedRestaurants() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');
    final response = await http.get(
      Uri.parse('$baseUrl/user-restaurants/liked'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['likedRestaurants'];
    } else {
      throw Exception('Failed to load liked restaurants');
    }
  }

//saved redstaurant
  static Future<List<dynamic>> getSavedRestaurants() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');
    final response = await http.get(
      Uri.parse('$baseUrl/user-restaurants/saved'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['savedRestaurants'];
    } else {
      throw Exception('Failed to load saved restaurants');
    }
  }

//featured res
  static Future<List<dynamic>> getFeaturedRestaurants() async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.100.8:5000/api/restaurants/featured'), // Ensure this URL is correct
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load featured restaurants');
    }
  }

//get res
  static Future<List<dynamic>> getRestaurants() async {
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

//search
  static Future<List<dynamic>> searchRestaurants(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/restaurants/search?q=$query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['restaurants'];
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  //   static Future<Map<String, dynamic>?> getUserProfile() async {
  //   final token = await getToken();
  //   if (token == null) {
  //     return null;
  //   }

  //   final response = await http.get(
  //     Uri.parse('http://localhost:5000/api/user/profile'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to load profile');
  //   }
  // }
}
