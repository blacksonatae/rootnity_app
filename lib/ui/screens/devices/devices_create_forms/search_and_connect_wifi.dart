import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';

class SearchAndConnectWifi extends StatefulWidget {
  const SearchAndConnectWifi({super.key});

  @override
  State<SearchAndConnectWifi> createState() => _SearchAndConnectWifiState();
}

class _SearchAndConnectWifiState extends State<SearchAndConnectWifi> {

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      layout: Baselayout(
        leadingWidgets: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: RootColors.eerieBlack,
            ),
          ),
          Text(
            "Tambahkan Perangkat",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: RootColors.eerieBlack),
          ),
          GestureDetector(
            //.. Mengarah ke halaman konfigurasi wifi
            onTap: () => (),
            child: Icon(
              Icons.check,
              color: RootColors.brandeisBlue,
            ),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Konfigurasi WiFi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: RootColors.eerieBlack,
              ),
            ),
            SizedBox(height: 10),
            //.. Text Keterangan
            Text(
              "Temukan dan hubungkan WiFi yang tersedia. Anda juga dapat mengganti WiFi yang sudah terhubung.",
              style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
