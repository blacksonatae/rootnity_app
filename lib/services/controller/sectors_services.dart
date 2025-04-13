import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/core/model/sectors.dart';
import 'package:rootnity_app/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectorsServices {
  static final StreamController<List<Sectors>> _sectorStreamController =
      StreamController<List<Sectors>>.broadcast();

  //.. Getter untuk stream
  static Stream<List<Sectors>> get sectorStream =>
      _sectorStreamController.stream;

  //.. Ambil data sektor dari local jika ada
  static Future<List<Sectors>> getStoreSectors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedSectors = preferences.getString('sectors');

    if (storedSectors != null) {
      List<dynamic> decode = jsonDecode(storedSectors);
      return decode.map((e) => Sectors.fromJson(e)).toList();
    }
    return [];
  }

  //.. Fungsi untuk simpan data sektor ke local storage
  static Future<void> saveSectorsToLocal(List<Sectors> sectors) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(sectors.map((e) => e.toJson()).toList());

    await preferences.setString('sectors', encodedData);
  }

  //.. Fetch sektor dari API, jika gagal gunakan data local
  static Future<void> fetchSectors(context) async {
    try {
      var response = await ApiServices.getData('/sectors', context);
      if (response != null && response.statusCode == 200) {
        List data = response.data['data'];
        List<Sectors> sectors =
            data.map((sector) => Sectors.fromJson(sector)).toList();

        _sectorStreamController.add(sectors);
        await saveSectorsToLocal(sectors);
      } else {
        //.. Jika gagal ambil data dari server -> gunakan fallback ke lokal
        List<Sectors> storedSectors = await getStoreSectors();
        _sectorStreamController.add(storedSectors);
      }
    } catch (e) {
      List<Sectors> storedSectors = await getStoreSectors();
      _sectorStreamController.add(storedSectors);
    }
  }

  //.. Create Sectors -> mengirim data sektor baru ke API
  static Future<Map<String, dynamic>> createSectors(
      String nameSectors, context) async {
    var response = await ApiServices.postData(
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
