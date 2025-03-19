import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:rootnity_app/models/wifi.dart';

class UdpService {
  RawDatagramSocket? _socket;
  InternetAddress? _esp32Ip;
  final int udpPort = 4210;
  final int listenPort = 4211;

  //.. Inisialisasi UDP untuk menerima boardcast dari ESP32
  Future<void> initializeUDP() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, listenPort);
    _socket?.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = _socket?.receive();
        if (datagram != null) {
          String message = utf8.decode(datagram.data);
          _handleIncomingMessage(message, datagram.address);
        }
      }
    });
  }

  //.. Mendeteksi IP ESP32 dari UDP Boardcast
  void _handleIncomingMessage(String message, InternetAddress seeder) {
    try {
      final Map<String, dynamic> data = jsonDecode(message);
      if (data.containsKey('ip')) {
        _esp32Ip = InternetAddress(data['ip']);
        debugPrint("ESP32 Detected at IP: $_esp32Ip");
      }
    } catch (e) {
      debugPrint("Error decoding UDP: $e");
    }
  }

  //.. Menerima daftar wifi yang dipindahin ESP32
  Future<List<WiFi>> receiveWiFiList() async {
    List<WiFi> wifiList = [];

    _socket?.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = _socket?.receive();
        if (datagram != null) {
          String message = utf8.decode(datagram.data);
          try {
            final Map<String, dynamic> data = jsonDecode(message);
            if (data.containsKey("wifi")) {
              wifiList = List<Map<String, dynamic>>.from(data["wifi"]).map((wifi) => WiFi.fromJson(wifi)).toList();
            }
          } catch (e) {
            debugPrint("Error parsing WiFi JSON: $e");
          }
        }
      }
    });

    await Future.delayed(Duration(seconds: 2));
    return wifiList;
  }
}
