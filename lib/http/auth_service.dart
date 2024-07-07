import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.100.8:5000/api';

  // Register
  static Future<bool> register(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'fullName': fullName,
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    }
  }

  // Login
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return true;
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    }
  }

  // Get User Profile
  static Future<Map<String, dynamic>> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await _sendRequestWithTokenRetry(
      () => http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      ),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['user'];
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  // Update User Profile
  static Future<void> updateUserProfile(Map<String, dynamic> user,
      [File? image]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/user/profile'),
    );

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path,
            filename: basename(image.path)),
      );
    }

    user.forEach((key, value) {
      request.fields[key] = value;
    });

    request.headers['Authorization'] = 'Bearer $token';

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  // Logout
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Check if Logged In
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  // Get Token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Send Request with Token Retry
  static Future<http.Response> _sendRequestWithTokenRetry(
      Future<http.Response> Function() requestFunction) async {
    http.Response response = await requestFunction();
    if (response.statusCode == 401 &&
        json.decode(response.body)['message'] == 'Token expired') {
      await _refreshToken();
      response = await requestFunction();
    }
    return response;
  }

  // Refresh Token
  static Future<void> _refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await prefs.setString('token', data['token']);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  static Future<void> changePassword(
      String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$baseUrl/user/profile/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to change password');
    }
  }

  //delete acc
  static Future<void> deleteAccount() async {
    final url = Uri.parse('$baseUrl/profile');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete account');
    }
  }
}
