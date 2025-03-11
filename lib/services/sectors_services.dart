import 'dart:async';

import 'package:http/http.dart';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectorServices {
  static final StreamController<List<Sectors>> _sectorController =
      StreamController<List<Sectors>>.broadcast();

  static Stream<List<Sectors>> get sectorStream => _sectorController.stream;

  //..
  static Future<void> fetchSectors(context) async {
    var response = await APIServices.getData('/sectors', context);

    if (response != null && response.statusCode == 200) {
      List data = response.data['data'];
      List<Sectors> sectors =
          data.map((sector) => Sectors.fromJson(sector)).toList();

      _sectorController.add(sectors);
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
