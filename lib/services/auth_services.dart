import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://655f-2001-448a-10e9-3016-25df-e3ad-510e-1c6f.ngrok-free.app/api";

  /*
  * Register pengguna dengan input nama pengguna, email, password, dan confirmation password
  * */
  Future<Map<String, dynamic>?> register(String name, String email, String password, String confirmPassword) async {
    // response

    return null;
    /*final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      print("${jsonDecode(response.body)}");
      return jsonDecode(response.body);
     } else {
      print("error");
      return null;
    }*/
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
