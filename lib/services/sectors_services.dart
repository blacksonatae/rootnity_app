import 'dart:convert';

import 'api_services.dart';


class SectorsServices {

  //.. Method : Get Sektor untuk mengambil sektor
  static Future<List<dynamic>> getSectors() async {
    final response = await APIServices.getData('/sectors');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return [];
    }
  }

  //.. Method : Post Sektor untuk menambah sektor ke dalam database
  Future<Map<String, dynamic>?> addSectors(String nameSector) async {
    final response = await APIServices.postData('/sectors', {
      'name_sectors': nameSector,
    });
    print(response);

    final responseData = jsonDecode(response.body);

    print(responseData);

    if (response.statusCode == 201) {
      return {'status': true};
    } else {
      return {'status': false, 'errors': responseData['errors']};
    }
  }
}