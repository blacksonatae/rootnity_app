import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/model/sectors.dart';
import 'package:rootnity_app/service/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectorServices {
  static final StreamController<List<Sectors>> _sectorController =
      StreamController<List<Sectors>>.broadcast();

  static Stream<List<Sectors>> get sectorStream => _sectorController.stream;

  //..
  static Future<List<Sectors>> getStoredSectors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedSectors = preferences.getString('sectors');

    print(storedSectors);
    if (storedSectors != null) {
      List<dynamic> decoded = jsonDecode(storedSectors);
      return decoded.map((e) => Sectors.fromJson(e)).toList();
    }
    return [];
  }
  //..
  static Future<void> saveSectorsToLocal(List<Sectors> sectors) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(sectors.map((e) => e.toJson()).toList());
    await preferences.setString('sectors', encodedData);
  }

  //..
  static Future<void> fetchSectors(context) async {
    try {
      var response = await APIServices.getData('/sectors', context);

      if (response != null && response.statusCode == 200) {
        List data = response.data['data'];
        List<Sectors> sectors =
        data.map((sector) => Sectors.fromJson(sector)).toList();

        _sectorController.add(sectors);
        await saveSectorsToLocal(sectors);
      } else {
        //..
        List<Sectors> storedSectors = await getStoredSectors();
        _sectorController.add(storedSectors);
      }
    } catch (e) {
      List<Sectors> storedSectors = await getStoredSectors();
      _sectorController.add(storedSectors);
    }
  }

  //..
  static Future<Map<String, dynamic>> createSectors(
      String nameSectors, context) async {
    var response = await APIServices.postData(
      '/sectors',
      {
        'name_sectors': nameSectors,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      fetchSectors(context);
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      return {'status': false};
    }
  }
}
