import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/screens/devices/create/add_devices_form.dart';

class ConfigureWifi extends StatefulWidget {
  const ConfigureWifi({super.key});

  @override
  State<ConfigureWifi> createState() => _ConfigureWifiState();
}

class _ConfigureWifiState extends State<ConfigureWifi> {
  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_outlined,
            color: ThemeApp.eerieBlack,
          ),
        ),
        Text(
          "Konfigurasi WiFi",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          //.. Mengarah ke halaman konfigurasi wifi
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddDevicesForm(),
              ),
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
          "Konfigurasi WiFi",
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
      ],
    );
  }
}
