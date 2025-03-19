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
  String _statusMessage = "";

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


  Future<void> _sendWiFiCredentials(String ssid, String password) async {
    final info = NetworkInfo();
    String? uuidname = await info.getWifiName();
    String? gatewayIP = await info.getWifiGatewayIP(); // Coba ambil gateway
    String? subnetMask = await info.getWifiSubmask(); // Coba ambil subnet mask
    print(gatewayIP);
    print(subnetMask);

    if (gatewayIP == null) {
      print("❌ Gagal menemukan ESP32! Gateway tidak ditemukan.");
      return;
    }

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 4211).then((socket) {
      Map<String, String> data = {"ssid": ssid, "password": password};
      String jsonData = jsonEncode(data);
      List<int> bytes = utf8.encode(jsonData);

      socket.send(bytes, InternetAddress(gatewayIP), 4211);
      print("📤 Mengirim SSID & Password ke $gatewayIP via UDP: $jsonData");

      socket.listen((RawSocketEvent event) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          String message = utf8.decode(datagram.data);
          print("📩 Respons dari ESP32: $message");
        }
      });

      Future.delayed(Duration(seconds: 5), () {
        socket.close();
      });
    });
  }



  void _showPasswordModal(BuildContext context, String ssid) {
    TextEditingController passwordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Masukkan Password untuk $ssid",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password WiFi",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  String password = passwordController.text.trim();
                  if (password.isNotEmpty) {
                    Navigator.pop(context);
                    _sendWiFiCredentials(ssid, password);
                  }
                },
                child: Text("Hubungkan"),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
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
        SizedBox(height: 20),
        Text(
          _statusMessage,
          style: TextStyle(fontSize: 14, color: Colors.green),
        ),
        SizedBox(height: 20),
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
                    if (wifi["secured"]) {
                      _showPasswordModal(context, wifi["ssid"]);
                    } else {
                      _sendWiFiCredentials(wifi["ssid"], "");
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
}
