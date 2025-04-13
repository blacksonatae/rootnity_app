import 'dart:async';
import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:rootnity_app/core/model/devices.dart';
import 'package:rootnity_app/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesServices {
  //..
  static final StreamController<List<Devices>> _devicesStreamController =
      StreamController<List<Devices>>.broadcast();

  //.. Getter untuk stream
  static Stream<List<Devices>> get devicesStream =>
      _devicesStreamController.stream;

  //.. Websockets

  //.. Ambil data devices dari local jika ada
  static Future<List<Devices>> getStoreDevices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedDevices = preferences.getString('devices');

    if (storedDevices != null) {
      List<dynamic> decode = jsonDecode(storedDevices);
      return decode.map((e) => Devices.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //.. Fungsi untuk menyimpan data devices ke local storage
  static Future<void> saveDevicesToLocal(List<Devices> devices) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String encodedData = jsonEncode(devices.map((e) => e.toJson()).toList());

    await preferences.setString('devices', encodedData);
  }

  //.. Fetch Devices dari API + Local SharedPreferences (Jika koneksi gagal)
  static Future<void> fetchDevices(context) async {
    try {
      var response = await ApiServices.getData('/devices', context);
      print("Response fetchDevices: ${response?.data}");

      if (response != null && response.statusCode == 200) {
        List data = response.data['data']; /*
        print(data);*/
        List<Devices> devices =
            data.map((devices) => Devices.fromJson(devices)).toList();

        print(devices.map((e) => e.toJson()).toList());

        _devicesStreamController.add(devices);
        await saveDevicesToLocal(devices);
      } else {
        //.. Jika gagal ambil data dari server -> gunakan fallback ke lokal
        List<Devices> storedDevices = await getStoreDevices();
        _devicesStreamController.add(storedDevices);
      }
    } catch (e) {
      List<Devices> storedDevices = await getStoreDevices();
      _devicesStreamController.add(storedDevices);
    }
  }

  //.. Fungsi untuk mengirim data baru ke server (menggunakan API)
  static Future<Map<String, dynamic>> createDevices(
      String nameDevices, int sectorId, context) async {
    var response = await ApiServices.postData(
      '/devices',
      {
        'name_device': nameDevices,
        'sectors_id': sectorId,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      //..
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      return {'status': false};
    }
  }
}
