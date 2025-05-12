import 'dart:async';
import 'dart:convert';

import 'package:rootnity_app/core/models/device.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesStorage {
  //.. Penerapan boardcast
  static final BehaviorSubject<List<Device>> _streamController =
      BehaviorSubject<List<Device>>();

  //.. Getter untuk stream
  static Stream<List<Device>> get deviceStream => _streamController.stream;

  static Future<void> init() async {
    final stored = await getStoreDevices();

    _streamController.sink.add(stored);
  }

  //.. Penyimpanan dari database ke local
  static Future<void> saveDevicesToLocal(List<Device> devices) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //.. Simpan data perangkat
    String encodedData =
        jsonEncode((devices.map((device) => device.toJson()).toList()));
    await preferences.setString('devices', encodedData);

    _streamController.sink.add(devices);
  }

  //.. Fetch or ambil data dari api
  static Future<List<Device>> getStoreDevices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedDevices = preferences.getString('devices');
    //.. Jika device yang tersimpan ada data, maka sektor akan dimuat ke halaman
    if (storedDevices != null) {
      List<dynamic> decodedData = jsonDecode(storedDevices);
      return decodedData.map((device) => Device.fromJson(device)).toList();
    }

    //.. Kosong jika tidak ada data
    return [];
  }
}
