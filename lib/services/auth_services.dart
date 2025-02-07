import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://28da-116-90-214-39.ngrok-free.app/api";

  /*
  * Register pengguna dengan input nama pengguna, email, password, dan confirmation password
  * */
  Future<Map<String, dynamic>?> register(String name, String email, String password, String confirmPassword) async {
    // response
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 202) {
        print("Register sukses: $responseData");
        return responseData;
      } else {
        print("Register gagal: ${responseData['message']}");
        return {'error': responseData['message']};
      }
    } catch (e) {
      print("Error saat register: $e");
      return {'error': 'Terjadi kesalahan, coba lagi'};
    }
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
