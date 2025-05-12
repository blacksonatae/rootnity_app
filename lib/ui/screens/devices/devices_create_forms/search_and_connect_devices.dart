import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/services/wifi_config/wifi_services.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';
import 'package:rootnity_app/ui/screens/devices/devices_create_forms/search_and_connect_wifi.dart';
import 'package:wifi_scan/wifi_scan.dart';

class SearchAndConnectDevices extends StatefulWidget {
  const SearchAndConnectDevices({super.key});

  @override
  State<SearchAndConnectDevices> createState() =>
      _SearchAndConnectDevicesState();
}

class _SearchAndConnectDevicesState extends State<SearchAndConnectDevices> {
  final WifiServices _wifiServices = WifiServices();
  List<WiFiAccessPoint> _wifiList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _wifiServices.stopScan();
    super.dispose();
  }

  Future<void> _initialize() async {
    // Start scan Wi-Fi
    final started = await _wifiServices.startScanDevices((results) {
      final visible = results.where((ap) => ap.ssid != null && ap.ssid!.isNotEmpty).toList();
          setState(() => _wifiList = visible);
        }, Duration(seconds: 3));

    if (!started) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memulai pemindaian Wi-Fi')),
      );
    }

    // Cek koneksi saat ini
    await _wifiServices.checkCurrentConnection();
    setState(() {});
  }

  void _onTapTile(String ssid) async {
    if (_wifiServices.connectedSSID == ssid) {
      await _wifiServices.disconnect();
      _showSnack('Berhasil memutuskan koneksi dari $ssid');
    } else {
      final success = await _wifiServices.connect(ssid);
      _showSnack(success ? 'Berhasil terhubung ke $ssid' : 'Gagal terhubung ke $ssid');
    }
    setState(() {});
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      layout: Baselayout(
        /*refreshController: _refreshController,
        onRefresh: _onRefresh,*/
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
            onTap: () =>
                NavigatorHelper.push(context, const SearchAndConnectWifi()),
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
              "Pencarian Perangkat",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: RootColors.eerieBlack,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Temukan dan hubungkan perangkat yang tersedia. Anda juga dapat mengganti perangkat yang sudah terhubung.",
              style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
            Expanded(
              child: _wifiList.isEmpty
                  ? const Center(child: Text('Tidak ada perangkat ditemukan'))
                  : ListView.separated(
                itemCount: _wifiList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final wifi = _wifiList[index];
                  final ssid = wifi.ssid ?? 'SSID Tidak Diketahui';
                  final status = _wifiServices.connectionStatus[ssid] ?? '';
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(ssid),
                      subtitle: Text(status, style: TextStyle(color: _getStatusColor(status))),
                      onTap: () => _onTapTile(ssid),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Connecting...':
        return Colors.orange;
      case 'Connected':
        return Colors.green;
      case 'Failed':
        return Colors.red;
      case 'Disconnected':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
