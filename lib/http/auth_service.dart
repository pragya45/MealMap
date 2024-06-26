import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<bool> register(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.8:5000/api/user/register'),
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
      Uri.parse('http://192.168.100.8:5000/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      throw Exception(responseBody['message']);
    } else {
      throw Exception('Failed to login');
    }
  }
}
