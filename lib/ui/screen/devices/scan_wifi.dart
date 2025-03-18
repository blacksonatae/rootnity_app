import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/ui/screen/layout/layout_no_mains.dart';

class ScanWifi extends StatefulWidget {
  const ScanWifi({super.key});

  @override
  State<ScanWifi> createState() => _ScanWifiState();
}

class _ScanWifiState extends State<ScanWifi> {
  List<Map<String, dynamic>> _wifiList = [];
  bool _isConnectedToESP32 = false;

  @override
  void initState() {
    super.initState();
    _checkESP32Connection();
    _listenForUdpWiFiList();
  }

  Future<void> _checkESP32Connection() async {
    final info = NetworkInfo();
    String? ssid = await info.getWifiName();

    print("SSID saat ini: $ssid");

    if (ssid != null && ssid.contains("Sabba-12")) {
      setState(() {
        _isConnectedToESP32 = true;
      });
      print("✅ Flutter sudah terhubung ke ESP32.");
    } else {
      setState(() {
        _isConnectedToESP32 = false;
      });
      print("❌ Flutter belum terhubung ke ESP32.");
    }
  }

  void _listenForUdpWiFiList() async {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4210).then((socket) {
      print("✅ Mendengarkan UDP untuk daftar WiFi...");
      socket.listen((RawSocketEvent event) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          String message = utf8.decode(datagram.data);
          print("📡 Data WiFi diterima: $message");

          try {
            Map<String, dynamic> jsonData = jsonDecode(message);
            List<Map<String, dynamic>> wifiList =
            List<Map<String, dynamic>>.from(jsonData["wifi"]);

            setState(() {
              _wifiList = wifiList;
            });
          } catch (e) {
            print("❌ Gagal memproses data WiFi: $e");
          }
        }
      });
    });
  }



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
        Text(
          "Pencarian WiFi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
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
                    
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
