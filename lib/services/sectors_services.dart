import 'dart:convert';
import 'api_services.dart';

class SectorServices {
  //.. Method: Get Sektor untuk mengambil sektor
  static Future<List<dynamic>> getSectors() async {
    final response = await APIServices.getData('/sectors');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return [];
    }
  }
}