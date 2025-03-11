import 'dart:convert';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_services.dart';

class SectorServices {
  //..
  static Future<void> saveSectors(List<Sectors> sectors) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> sectorsList = sectors.map((sector) => jsonEncode(sector.toJson())).toList();
    await preferences.setStringList('sectors', sectorsList);
  }

  //..
  static Future<List<Sectors>> loadSectors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? sectorsList = preferences.getStringList('sectors');

    if (sectorsList == null) return [];
    return sectorsList.map((sector) => Sectors.fromJson(jsonDecode(sector))).toList();
  }

  //.. Method: Get Sektor untuk mengambil sektor
  static Future<List<Sectors>> getSectors(context) async {
    var response = await APIServices.getData('/sectors', context);

    if (response != null && response.statusCode == 200) {
      List<Sectors> sectors = (response.data['data'] as List).map((json) => Sectors.fromJson(json)).toList();
      await saveSectors(sectors);
      CustomToast.show(context, 'Data Sektor telah diperbarui!', "success");
      return sectors;
    } else {
      CustomToast.show(context, "Menggunakan data sektor offline!", "info");
      return await loadSectors();
    }
  }
  //.. Method: Post untuk membuat sektor baru
  static Future<Map<String, dynamic>> createSectors(String nameSectors, context) async {
    var response = await APIServices.postData('/sectors', {
      'name_sectors': nameSectors,
    }, context);

    if (response != null && response.statusCode == 201) {
      var data = response.data['data'];

      //.. Perbarui sektor yang disimpan di local
      List<Sectors> updatedSectors = await getSectors(context);
      updatedSectors.add(Sectors.fromJson(data));
      await saveSectors(updatedSectors);

      CustomToast.show(context, "Sektor berhasil ditambahkan!", "success");
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      CustomToast.show(context, "Menambah sektor gagal !, Silahkan coba lagi.", "error");
      return {'status': false};
    }
  }
}