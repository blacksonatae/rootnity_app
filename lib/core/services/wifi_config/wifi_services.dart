import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/toast/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiServices {
  final Map<String, String> connectionStatus = {};
  String? connectedSSID;
  StreamSubscription<List<WiFiAccessPoint>>? _streamScanDevicesSubscription;

  //.. Fungsi untuk memeriksa status GPS
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  //..
  Future<void> _saveLastConnectedSSID(String ssid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_connected_ssid', ssid);
  }

  //..
  Future<String?> _loadLastConnectedSSID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('last_connected_ssid');
  }

  //.. Fungsi untuk memulai pencarian WiFi/Perangkat
  Future<bool> startScanDevices(
      void Function(List<WiFiAccessPoint>) onData, context) async {
    //.. Pastikan izin lokasi diberikan
    if (!await requestLocationPermission()) return false;

    //.. Pastikan izin wifi diberikan
    if (await WiFiScan.instance.canStartScan(askPermissions: false) !=
        CanStartScan.yes) {
      //.. Menampilkan toast
      CustomToast.show(
          context: context,
          message:
              "Terjadi kesalahan, silahkan hidupkan WiFi di perangkat Anda",
          position: ToastPosition.bottom,
          backgroundColor: RootColors.redPantone);
      return false;
    }

    //.. Listen hasil scan
    _streamScanDevicesSubscription =
        WiFiScan.instance.onScannedResultsAvailable.listen(onData);
    await WiFiScan.instance.startScan();
    return true;
  }

  //.. Fungsi untuk menghentikan pencarian
  /*Future<void> stopScan() async {
    _streamScanDevicesSubscription?.cancel();
  }*/

  void stopScan() {
    _streamScanDevicesSubscription?.cancel();
  }

  Future<void> checkCurrentConnection() async {
    // Cek plugin dulu
    final pluginSSID = await WiFiForIoTPlugin.getSSID();
    connectedSSID = pluginSSID;

    // Fallback ke prefs
    if (connectedSSID == null) {
      connectedSSID = await _loadLastConnectedSSID();
    }
    // Jika ada SSID yang masih terkoneksi, tandai status-nya
    if (connectedSSID != null) {
      connectionStatus[connectedSSID!] = 'Connected';
    }
  }


  Future<bool> connect(String ssid) async {
    connectionStatus[ssid] = 'Connecting...';
    final success = await WiFiForIoTPlugin.connect(ssid,
        joinOnce: true,
        security: NetworkSecurity.NONE,
        withInternet: false,
        isHidden: false);
    connectionStatus[ssid] = success ? 'Connected' : 'Failed';

    if (success) {
      connectedSSID = ssid;
      await _saveLastConnectedSSID(ssid);
    }
    return success;
  }

  Future<void> disconnect() async {
    await WiFiForIoTPlugin.disconnect();
    if (connectedSSID != null) {
      connectionStatus[connectedSSID!] = 'Disconnected';
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('last_connected_ssid');
      connectedSSID = null;
    }
  }
}
