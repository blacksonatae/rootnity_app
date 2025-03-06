import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  static const String _baseUrl = "https://5b17-116-90-214-76.ngrok-free.app/api";

  // .. Method Get
  static Future<http.Response> getData(String endpoint) async {
    var fullUrl = '$_baseUrl$endpoint';

    return await http.get(
      Uri.parse(fullUrl),
      headers: await _setHeaders(),
    );
  }

  // .. Method Post
  static Future<http.Response> postData(
      String endpoint, Map<String, dynamic> data) async {
    var fullUrl = '$_baseUrl$endpoint';

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: await _setHeaders(),
    );
  }

  // .. Method berfungsi untuk mengatur headers, termasuk token jika ada
  static Future<Map<String, String>> _setHeaders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      // Menambahkan token jika user sudah login atau melakukan operasi CRUD pada Sector dan Devices
    };
  }
}
