import 'dart:async';

import 'package:rootnity_app/core/models/sector.dart';
import 'package:rootnity_app/core/services/api_services.dart';
import 'package:rootnity_app/data/storages/sectors_storage.dart';

class SectorsController {
  static Stream<List<Sector>> get stream => SectorsStorage.sectorStream;

  //.. Fetch or ambil data dari api
  static Future<void> fetchSectors(context) async {
    var response = await APIServices.getData('/sectors', context);
    if (response != null && response.statusCode == 200) {
      List sector = response.data['data'];
      print(sector);
      List<Sector> sectors =
          sector.map((sector) => Sector.fromJson(sector)).toList();

      await SectorsStorage.saveSectorsToLocal(sectors);
    }
  }
}
