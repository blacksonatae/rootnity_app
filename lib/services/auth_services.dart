import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_services.dart';

class AuthServices {
  // Login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await APIServices.postData('/login', {
      'email': email,
      'password': password,
    });

    final responseData = jsonDecode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // Simpan token & nama user di local storage
      await preferences.setString('token', responseData['data']['token']);
      await preferences.setString('name', responseData['data']['name']);
      await preferences.setString('email', responseData['data']['email']);
      return {'status': true};
    } else {
      return {'status': false, 'errors': responseData['errors']};
    }
  }

  // Register
  Future<Map<String, dynamic>?> register(String name, String email, String password, String confirmPassword) async {
    final response = await APIServices.postData('/register',{
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // Simpan token & nama user di local storage
      await preferences.setString('token', responseData['data']['token']);
      await preferences.setString('name', responseData['data']['name']);
      await preferences.setString('email', responseData['data']['email']);
      return {'status': true};
    } else {
      return {'status': false, 'errors': responseData['errors']};
    }
  }

  // Logout
  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear(); // Hapus semua data saat logout
  }
}
