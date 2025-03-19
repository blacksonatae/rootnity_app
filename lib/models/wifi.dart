import 'dart:convert';

import 'package:flutter/foundation.dart';

class WiFi {
  final String ssid;
  final String bssid;
  final String ip;
  final String gateway;
  final String subnetMask;

  WiFi({
    required this.ssid,
    required this.bssid,
    required this.ip,
    required this.gateway,
    required this.subnetMask,
  });

  //.. Convert Json ke Object
  factory WiFi.fromJson(Map<String, dynamic> json) {
    return WiFi(
      ssid: json['ssid'] ?? "",
      bssid: json['bssid'] ?? "",
      ip: json['ip'] ?? "",
      gateway: json['gateway'] ?? "",
      subnetMask: json['subnetMask'] ?? "",
    );
  }
  
  //.. Convert Object to Json
  Map<String, dynamic> toJson() {
    return {
      'ssid': ssid,
      'bssid': bssid,
      'ip': ip,
      'gateway': gateway,
      'subnetMask': subnetMask,
    };
  }
}
