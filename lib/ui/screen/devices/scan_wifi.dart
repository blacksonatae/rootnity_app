import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:network_info_plus/network_info_plus.dart";
import "package:rootnity_app/core/theme_app.dart";
import "package:rootnity_app/ui/screen/layout/layout_no_mains.dart";
import 'package:http/http.dart' as http;
import "package:wifi_iot/wifi_iot.dart";

class ScanWifi extends StatefulWidget {
  const ScanWifi({super.key});

  @override
  State<ScanWifi> createState() => _ScanWifiState();
}

class _ScanWifiState extends State<ScanWifi> {
  List<Map<String, dynamic>> _wifiList = [];
  String esp32Url = "http://192.168.4.1"; // Gunakan IP yang benar
  bool _isConnectedToESP32 = false;

  @override
  void initState() {
    super.initState();
    _checkESP32Connection();
  }

  Future<void> _checkESP32Connection() async {
    String? ssid = await WiFiForIoTPlugin.getSSID();
    String? wifiIP = await WiFiForIoTPlugin.getIP();

    print("Perangkat menggunakan IP: $wifiIP");

    if (ssid != null && ssid.contains("Sabba-12")) {  // Pastikan SSID sesuai
      setState(() {
        _isConnectedToESP32 = true;
      });
      print("Flutter terhubung ke ESP32 dengan IP: $wifiIP");
      _fetchWifiList();
    } else {
      setState(() {
        _isConnectedToESP32 = false;
      });
      print("Flutter belum terhubung ke ESP32. Pastikan koneksi benar.");
    }
  }

  Future<void> _fetchWifiList() async {
    if (!_isConnectedToESP32) {
      print("Tidak terhubung ke ESP32, tidak dapat memindai WiFi.");
      return;
    }

    try {
      print("Mengirim permintaan pemindaian WiFi ke ESP32...");
      final response = await http.get(Uri.parse("$esp32Url/scan"));

      if (response.statusCode == 200) {
        setState(() {
          _wifiList = List<Map<String, dynamic>>.from(jsonDecode(response.body)["wifi"]);
        });
        print("WiFi yang ditemukan: $_wifiList");
      } else {
        print("ESP32 tidak merespons dengan benar. Kode status: ${response.statusCode}");
      }
    } catch (e) {
      print("Gagal menghubungi ESP32: $e");
    }
  }

  /*List<Map<String, dynamic>> _wifiList = [];
  String _status = "Disconnected";
  String esp32Url = "http://192.168.4.1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWifiList();
    _fetchWiFiStatus();
  }

  Future<void> _fetchWifiList() async {
    try {
      final response = await http.get(Uri.parse("$esp32Url/scan"));
      if (response.statusCode == 200) {
        setState(() {
          _wifiList = List<Map<String, dynamic>>.from(
              jsonDecode(response.body)["wifi"]);
          print(_wifiList);
        });
      }
    } catch (e) {
      print("Error saat mengambil daftar WiFi: $e");
    }
  }

  Future<void> _fetchWiFiStatus() async {
    try {
      final response = await http.get(Uri.parse("$esp32Url/status"));
      if (response.statusCode == 200) {
        setState(() {
          _status = response.body;
        });
      }
    } catch (e) {
      print("Error saat mengambil status WiFi: $e");
    }
  }

  void _connectToWiFi(String ssid, {String? password}) async {
    final response = await http.post(
      Uri.parse("$esp32Url/connect"),
      body: {"ssid": ssid, "password": password ?? ""},
    );

    if (response.statusCode == 200) {
      setState(() {
        _status = "Connecting...";
      });
      Future.delayed(Duration(seconds: 5), _fetchWiFiStatus);
    }
  }

  void _disconnectWiFi() async {
    final response = await http.post(Uri.parse("$esp32Url/disconnect"));

    if (response.statusCode == 200) {
      setState(() {
        _status = "Disconnected";
      });
    }
  }*/

  /*void _showPasswordDialog(String ssid) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Masukkan Password"),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password WiFi"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _connectToWiFi(ssid, password: passwordController.text);
            },
            child: Text("Hubungkan"),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(
      title: "",
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
          "Pencarian WiFi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
        //.. Text Keterangan
        Text(
          "Temukan dan hubungkan WiFi yang tersedia. Anda juga dapat mengganti WiFi yang sudah terhubung.",
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
                    return Card(
                      elevation: 1,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(wifi["ssid"] ?? "SSID Tidak Diketahui"),
                        subtitle: Text(
                          wifi["secured"] ? "Memerlukan password" : "Terbuka",
                        ),
                        onTap: () {
                          /*if (wifi["secured"]) {
                            _showPasswordDialog(wifi["ssid"]);
                          } else {
                            _connectToWiFi(wifi["ssid"]);
                          }*//*if (wifi["secured"]) {
                            _showPasswordDialog(wifi["ssid"]);
                          } else {
                            _connectToWiFi(wifi["ssid"]);
                          }*/
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
