import 'dart:async';

import 'package:rootnity_app/core/models/sector.dart';
import 'package:rootnity_app/core/services/server/api_services.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/toast/custom_toast.dart';
import 'package:rootnity_app/data/storages/sectors_storage.dart';

class SectorsController {
  static Stream<List<Sector>> get stream => SectorsStorage.sectorStream;

  //.. Fetch or ambil data dari api
  static Future<void> fetchSectors(context) async {
    var response = await APIServices.getData('/sectors', context);
    if (response != null && response.statusCode == 200) {
      List sector = response.data['data'];

      List<Sector> sectors =
          sector.map((sector) => Sector.fromJson(sector)).toList();

      await SectorsStorage.saveSectorsToLocal(sectors);
    }
  }

  static Future<Map<String, dynamic>> createSectors(
      String nameSector, context) async {
    var response = await APIServices.postData(
      '/sectors',
      {
        'name_sectors': nameSector,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      fetchSectors(context);
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      CustomToast.show(
          context: context,
          message: "Terjadi kesalahan, tidak dapat menambah sektor, ",
          position: ToastPosition.center,
          backgroundColor: RootColors.redPantone);
      return {'status': false};
    }
  }
}
