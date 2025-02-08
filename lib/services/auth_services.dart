import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://50fd-180-254-162-81.ngrok-free.app/api";

  /*
  * Register pengguna dengan input nama pengguna, email, password, dan confirmation password
  * */
  Future<Map<String, dynamic>?> register(String name, String email, String password, String confirmPassword) async {

  }

  /*
  * Login pengguan dengan input email dan password
  * */
  Future<Map<String, dynamic>?> login(String email, String password) async {
    // response
    return null;
    /*final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }*/
  }
}
