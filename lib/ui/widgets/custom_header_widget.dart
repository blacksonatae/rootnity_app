import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/ui/screens/devices/create/scan_devices.dart';
import 'package:rootnity_app/ui/screens/sectors/create_sectors.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHeaderWidget extends StatefulWidget {
  const CustomHeaderWidget({super.key});

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  String? _username = "User"; //.. Variabel user name atau pengguna

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName(); //.. Panggil loadUserName untuk memanggil nama pengguna dari local storages
  }

  //.. Fungsi untuk mengambil nama pengguna dari SharedPreferences
  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString('name') ?? "User";

    setState(() {
      _username =
          (username.length > 12) ? "${username.substring(0, 12)}..." : username;
    });
  }

  void _logout() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //.. Tampilan username (nama pengguna)
              Text(
                _username ?? "User",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                  color: ThemeApp.eerieBlack,
                ),
              ),
              //.. PopupMenu sebagai dropdown untuk menampilkan menu logout
              CustomPopupMenu(
                menuItems: [
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () {},
                  ),
                ],
                offset: Offset(-60, 30),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
            ],
          ),

          //.. PopupMenu akan menampilkan beberapa menu dalam bentuk list yang berisi add sektor dan add devices
          CustomPopupMenu(
            menuItems: [
              //.. Tombol tambah sektor
              PopupMenuItem(
                child: Text("Tambah Sektor"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateSectors())),
              ),
              //.. Tombol tambah perangkat
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanDevices())),
              ),
            ],
            offset: Offset(-150, 30),
            child: Icon(
              Icons.add_circle_outline,
              color: ThemeApp.eerieBlack,
            ),
          ),
        ],
      ),
    );
  }
}
