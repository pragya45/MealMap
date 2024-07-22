import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealmap/core/app.dart';
import 'package:mealmap/features/forgotpass/password_reset_sucess_view.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.100.8:5000/api';
//'http://10.0.2.2:5000/api
//for phone http://192.168.100.8:5000/api

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

    print('Register response status: ${response.statusCode}');
    print('Register response body: ${response.body}');

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

    print('Login response status: ${response.statusCode}');
    print('Login response body: ${response.body}');

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
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['user'];
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  // Update User Profile
// Update User Profile
  static Future<void> updateUserProfile(Map<String, dynamic> user,
      [File? image]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/user/profile'),
    );

    // Add image file if provided
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          filename: basename(image.path),
        ),
      );
    }

    // Add other user fields as fields (not files)
    user.forEach((key, value) {
      if (key != 'image') {
        // Skip 'image' key as it's handled separately
        request.fields[key] = value.toString();
      }
    });

    // Set authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Send request
    final response = await request.send();

    // Handle response
    if (response.statusCode == 200) {
      // Handle successful update
      print('Profile updated successfully');
    } else {
      // Handle failure
      throw Exception('Failed to update profile: ${response.reasonPhrase}');
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
      await refreshToken();
      response = await requestFunction();
    }
    return response;
  }

  // Refresh Token
  static Future<bool> refreshToken() async {
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
      return true;
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  // Change Password
  static Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final token = await getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/user/profile/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'currentPassword': currentPassword,
        'newPassword': newPassword
      }),
    );

    if (response.statusCode != 200) {
      final errorData = json.decode(response.body);
      throw Exception('Failed to change password: ${errorData['message']}');
    }
  }

  // Delete Account
  static Future<void> deleteAccount() async {
    final token = await getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete account');
    }
  }

  // Add this method in AuthService
  static Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    }
  }

  // Reset Password
  static Future<void> resetPassword(String userId, String token,
      String password, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/reset-password/$userId/$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success'] == true) {
          print('Password reset successful, navigating to success view.');
          navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PasswordResetSuccessView()),
            (route) => false,
          );
        } else {
          print('Password reset failed: ${responseBody['message']}');
          throw Exception(responseBody['message']);
        }
      } else {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print('Error: ${responseBody['message']}');
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to reset password. Please try again later.');
    }
  }
}
