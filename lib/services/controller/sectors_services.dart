import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/core/model/Sector.dart';
import 'package:rootnity_app/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectorsServices {
  static final StreamController<List<Sector>> _streamController = StreamController<List<Sector>>.broadcast();

  //.. getter untuk stream
  static Stream<List<Sector>> get sectorStream =>
      _streamController.stream;

  //.. Ambil data sektor dari local jika ada
  static Future<List<Sector>> getStoreSectors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedSectors = preferences.getString('sectors');

    if (storedSectors != null) {
      List<dynamic> decode = jsonDecode(storedSectors);
      return decode.map((sector) => Sector.fromJson(sector)).toList();
    }
    //.. Kosong jika tidak ada data
    return [];
  }

  //.. Fungsi untuk simpan data sektor ke local storage
  static Future<void> saveSectorToLocal(List<Sector> sectors) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedData = jsonEncode((sectors.map((sector)=> sector.toJson()).toList()));

    await preferences.setString('sectors', encodedData);
  }

  //.. Fetch sektor dari api jika gagal gunakan data lokal
  static Future<void> fetchSectors(context) async {
    try {
      var response = await ApiServices.getData('/sectors', context);
      if (response != null && response.statusCode == 200) {
        List data = response.data['data'];
        List<Sector> sectors = data.map((sector) => Sector.fromJson(sector)).toList();

        _streamController.add(sectors);
        await saveSectorToLocal(sectors);
      } else {
        List<Sector> storedSectors = await getStoreSectors();
        _streamController.add(storedSectors);
      }

    } catch (e) {
      List<Sector> storedSectors = await getStoreSectors();
      _streamController.add(storedSectors);
    }
  }
}