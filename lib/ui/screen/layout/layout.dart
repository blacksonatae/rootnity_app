import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/ui/screen/devices/scan_devices.dart';
import 'package:rootnity_app/ui/screen/home.dart';
import 'package:rootnity_app/ui/screen/sectors/add_sectors.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  String? _username; //.. Variabel user name atau pengguna

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString('name');

    setState(() {
      _username = (username != null && username.length > 12)
          ? username.substring(0, 12)
          : username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: const HomeScreen(),
            ),
          ],
        ),
      ),
    );
  }

  /* Header */
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //.. Untuk menampilkan username atau nama pengguna
              Text(
                _username ?? "User",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.5,
                    color: ThemeApp.eerieBlack),
              ),
              //.. Popupmenu sebagai dropdown untuk menampilkan menu logout
              CustomPopupmenu(
                menuItems: [
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () => print("Terkeluar"),
                  ),
                ],
                offset: Offset(-60, 30),
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: ThemeApp.eerieBlack,
                ),
              ),
            ],
          ),
          CustomPopupmenu(
            menuItems: [
              PopupMenuItem(
                child: Text("Tambah Sektor"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSectors(),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScanDevices())),
              ),
            ],
            offset: Offset(-150, 30),
            child: Icon(
              Icons.add_circle_outline,
              color: ThemeApp.eerieBlack,
            ),
          )
        ],
      ),
    );
  }
}
