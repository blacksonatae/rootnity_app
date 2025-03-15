import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/ui/screen/devices/scan_wifi.dart';
import 'package:rootnity_app/ui/screen/layout/layout_no_mains.dart';
import 'package:wifi_iot/wifi_iot.dart';

<<<<<<< HEAD
/*
* Scan Devices untuk mencari perangkat arduino ESP32
* untuk menghubungkan dan mencari menggunaakan wifi
* setelah terhubung user dapat menekan tombol centang untuk ke halaman penamaan
* jika user menekan navigator pop maka otomatis cancel dan arduino wifi terputus
* */
class ScanDevices extends StatelessWidget {
=======
class ScanDevices extends StatefulWidget {
>>>>>>> a335fe51410725e807fe0ea011dff5f6bf2bedcd
  const ScanDevices({super.key});

  @override
  State<ScanDevices> createState() => _ScanDevicesState();
}

class _ScanDevicesState extends State<ScanDevices> {
  List<WifiNetwork> _wifiList = [];
  Timer? _scanTimer;
  bool _isScanning = false;
  String? _connectedSSID;
  Map<String, String> _connectionStatus = {};

  @override
  void initState() {
    print("test");
    super.initState();
    _requestPermissions().then((granted) {
      if (granted) _startRealtimeScan();
    });
    _checkCurrentConnection();
  }

  @override
  void dispose() {
    _scanTimer?.cancel(); // Hentikan scanning saat widget ditutup
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  void _startRealtimeScan() {
    _scanTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        List<WifiNetwork>? results = await WiFiForIoTPlugin.loadWifiList();
        setState(() {
          _wifiList = results;
          /*print(_wifiList
              .map((wifi) =>
                  "SSID: ${wifi.ssid}, BSSID: ${wifi.bssid}, Signal: ${wifi.level} dBm")
              .join("\n"));*/
        });
      } catch (e) {
        print("Error saat scan WiFi: $e");
      }
    });
  }

  void _checkCurrentConnection() async {
    String? ssid = await WiFiForIoTPlugin.getSSID();
    setState(() {
      _connectedSSID = ssid;
    });
  }

  void connectToDevices(String ssid) async {
    setState(() {
      _connectionStatus[ssid] = "Connecting...";
    });

    bool connected = await WiFiForIoTPlugin.connect(
      ssid,
      joinOnce: true,
      security: NetworkSecurity.NONE,
      withInternet: false,
      isHidden: false,
    );

    setState(() {
      if (connected) {
        _connectionStatus[ssid] = "Connected";
        _connectedSSID = ssid;
      } else {
        _connectionStatus[ssid] = "Failed";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(connected
              ? "Berhasil terhubung ke $ssid"
              : "Gagal terhubung ke $ssid")),
    );
  }

  void disconnectDevices(String ssid) async {
    await WiFiForIoTPlugin.disconnect();
    setState(() {
      _connectedSSID = null;
      _connectionStatus[ssid] = "Disconnected";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Berhasil memutuskan koneksi dari $ssid")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(
      title: "Tambahkan Perangkat",
      leadingWidget: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: ThemeApp.eerieBlack,
          ),
        ),
        Text(
          "Tambahkan Perangkat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Tambahkan aksi setelah memilih perangkat
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanWifi()),
            );
          },
          child: Icon(
            Icons.check,
            color: ThemeApp.brandeisBlue,
          ),
        ),
      ],
      body: [
        //.. Heading
        Text(
          "Pencarian Perangkat",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
        //.. Text Keterangan
        Text(
          "Temukan dan hubungkan perangkat yang tersedia. Anda juga dapat mengganti perangkat yang sudah terhubung.",
          style: TextStyle(fontSize: 14.5, color: ThemeApp.seasalt),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 500,
          child: _wifiList.isEmpty
              ? const Center(
                  child: Text("Tidak ada perangkat ditemukan"),
                )
              : ListView.separated(
                  itemCount: _wifiList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final wifi = _wifiList[index];
                    final status = _connectionStatus[wifi.ssid] ?? "";
                    return Card(
                      elevation: 1,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(wifi.ssid ?? "SSID Tidak Diketahui"),
                        subtitle: Text(
                          status,
                          style: TextStyle(color: _getStatusColor(status)),
                        ),
                        onTap: () {
                          if (_connectedSSID == wifi.ssid) {
                            disconnectDevices(wifi.ssid ?? "");
                          } else {
                            connectToDevices(wifi.ssid ?? "");
                          }
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Menentukan warna status berdasarkan kondisi
  Color _getStatusColor(String status) {
    switch (status) {
      case "Connecting...":
        return Colors.orange;
      case "Connected":
        return Colors.green;
      case "Failed":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
