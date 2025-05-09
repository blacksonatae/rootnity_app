import 'dart:async';

import 'package:rootnity_app/core/models/device.dart';
import 'package:rootnity_app/core/services/api_services.dart';
import 'package:rootnity_app/data/storages/devices_storage.dart';

class DevicesController {
  static Future<void> fetchDevices(context) async {
    var response = await APIServices.getData('/devices', context);
    if (response != null && response.statusCode == 200) {
      List sector = response.data['data'];
      List<Device> devices =
          sector.map((device) => Device.fromJson(device)).toList();

      await DevicesStorage.saveDevicesToLocal(devices);
    }
  }
}