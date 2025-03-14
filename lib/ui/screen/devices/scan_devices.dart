import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/ui/screen/layout/layout_no_mains.dart';
import 'package:wifi_iot/wifi_iot.dart';

/*
* Scan Devices untuk mencari perangkat arduino ESP32
* untuk menghubungkan dan mencari menggunaakan wifi
* setelah terhubung user dapat menekan tombol centang untuk ke halaman penamaan
* jika user menekan navigator pop maka otomatis cancel dan arduino wifi terputus
* */
class ScanDevices extends StatelessWidget {
  const ScanDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(
      title: "Tambahkan Perangkat",
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
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
          onTap: () => (),
          child: Icon(
            Icons.check,
            color: ThemeApp.brandeisBlue,
          ),
        ),
      ],
      body: [
        //.. Menampilkan daftar perangkat ESP32
      ],
    );
  }
}
