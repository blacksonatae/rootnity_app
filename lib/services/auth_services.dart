import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://8c53-2407-0-3002-4817-e9aa-f380-912c-97f6.ngrok-free.app/";

  /*
  * Register pengguna dengan input nama pengguna, email, password, dan confirmation password
  * */
  Future<Map<String, dynamic>?> register(String name, String email, String password, String confirmPassword) async {
    // response
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(object),
    );
    return null;
  }

  /*
  * Login pengguan dengan input email dan password
  * */
  Future<Map<String, dynamic>?> login(String email, String password) async {

    return null;
  }
}
