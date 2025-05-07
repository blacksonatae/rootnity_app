import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/core/model/Device.dart';
import 'package:rootnity_app/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesServices {
  static final StreamController<List<Device>> _streamController = StreamController<List<Device>>.broadcast();

  //.. getter untuk stram
  static Stream<List<Device>> get devicesStream => _streamController.stream;

  /*
  * Penerapan Websocket */


  /*
  * Penerapan API */
  //.. Ambil data devices dari local jika ada
  static Future<List<Device>> getStoreDevices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedDevices = preferences.getString('devices');

    if (storedDevices != null) {
      List<dynamic> decode = jsonDecode(storedDevices);
      return decode.map((e) => Device.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //.. Fungsi untuk menyimpan data devices ke local storage
  static Future<void> saveDevicesToLocal(List<Device> devices) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String encodedData = jsonEncode(devices.map((e) => e.toJson()).toList());

    await preferences.setString('devices', encodedData);
  }

  //.. Fetch Devices dari API + Local SharedPreferences (Jika koneksi gagal)
  static Future<void> fetchDevices(context) async {
    try {
      var response = await ApiServices.getData('/devices', context);

      if (response != null && response.statusCode == 200) {
        List data = response.data['data'];
        List<Device> devices =
        data.map((device) => Device.fromJson(device)).toList();
        print(devices.map((e) => e.toJson()).toList());

        _streamController.add(devices);
        await saveDevicesToLocal(devices);
      } else {
        //.. Jika gagal ambil data dari server -> gunakan fallback ke lokal
        List<Device> storedDevices = await getStoreDevices();
        _streamController.add(storedDevices);
      }
    } catch (e) {
      List<Device> storedDevices = await getStoreDevices();
      _streamController.add(storedDevices);
    }
  }

  //.. Fungsi untuk mengirim data baru ke server (menggunakan API)
  static Future<Map<String, dynamic>> createDevices(
      String nameDevices, int sectorId, context) async {
    var response = await ApiServices.postData(
      '/devices',
      {
        'name_devices': nameDevices,
        'sectors_id': sectorId,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      //..
      fetchDevices(context);
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      return {'status': false};
    }
  }
}