import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://localhost:5000/api';

  Future<Map<String, dynamic>> registerUser(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['message']
      };
    }
  }
}
