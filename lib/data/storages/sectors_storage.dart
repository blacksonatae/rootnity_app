import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/core/models/sector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectorsStorage {
  //.. Penerapan boardcast
  static final BehaviorSubject<List<Sector>> _streamController =
  BehaviorSubject<List<Sector>>();

  //.. Getter untuk stream
  static Stream<List<Sector>> get sectorStream => _streamController.stream;

  static Future<void> init() async {
    final stored = await getStoredSectors();
    print(stored);

    print("🔁 Emit from init(): $stored");
    _streamController.sink.add(stored);
  }

  //.. Penyimpanan dari database ke local
  static Future<void> saveSectorsToLocal(List<Sector> sectors) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedData =
        jsonEncode((sectors.map((sector) => sector.toJson()).toList()));

    await preferences.setString('sectors', encodedData);
    _streamController.sink.add(sectors);
  }

  //.. Pengambilan data dari local
  static Future<List<Sector>> getStoredSectors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedSectors = preferences.getString('sectors');
    //.. Jika sektor yang tersimpan ada data, maka sektor akan dimuat ke halaman
    if (storedSectors != null) {
      List<dynamic> decodedData = jsonDecode(storedSectors);
      print(storedSectors);
      return decodedData.map((sector) => Sector.fromJson(sector)).toList();
    }
    //.. Kosong jika tidak ada data
    return [];
  }
}