import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://69b5-116-90-214-39.ngrok-free.app/api";

  /*
  * Register pengguna dengan input nama pengguna, email, password, dan confirmation password
  * */
  Future<Map<String, dynamic>?> register(String name, String email,
      String password, String confirmPassword) async {
    try {
      // Tampilkan data input yang dikirim
      final requestBody = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      });

      print("Request Body: $requestBody");

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      final responseData = jsonDecode(response.body);

      print(response.body);
      if (response.statusCode == 201) {
        print("Login berhasil: ${responseData["data"]}");
        // Registrasi berhasil
        return {
          "data": responseData["data"],
        };
      } else if (response.statusCode == 422) {
        print("errors: ${responseData["errors"]}");
        // Validasi gagal, kirim pesan error
        return {
          "errors": responseData["errors"],
        };
      } else {
        print("errors: ${responseData["errors"]}");
        return {
          "errors": responseData["errors"],
        };
      }
    } catch (e) {
      print("errors: $e");
      return {
        "errors": e,
      };
    }
  }

  /*
  * Login pengguan dengan input email dan password
  * */
  Future<Map<String, dynamic>?> login(String email, String password) async {
    // response

    return null;
  }
}
