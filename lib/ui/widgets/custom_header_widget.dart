import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/ui/screens/devices/devices_create_forms/search_and_connect_devices.dart';
import 'package:rootnity_app/ui/screens/sectors/sectors_create_screen.dart';
import 'package:rootnity_app/ui/screens/sectors/sectors_manager_screen.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHeaderWidget extends StatefulWidget {
  const CustomHeaderWidget({super.key});

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  //.. Variabel untuk nama pengguna
  String? _username = "User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserName();
  }

  //.. Fungsi untuk mengambil nama pengguna dari SharedPreferences
  void _getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString("name") ?? "User";

    setState(() {
      _username =
          (username.length > 12) ? "${username.substring(0, 12)}..." : username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //.. Tampilkan user name
              Text(
                _username ?? "User",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                  color: RootColors.eerieBlack,
                ),
              ),
              //.. Popup menu sebagai dropdown untuk menampilkan menu logout
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
                onTap: () => NavigatorHelper.push(context, const SectorsCreateScreen()),
              ),
              //.. Tombol tambah perangkat
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
                onTap: () => NavigatorHelper.push(context, const SearchAndConnectDevices()),
              ),
            ],
            offset: Offset(-150, 30),
            child: Icon(
              Icons.add_circle_outline,
              color: RootColors.eerieBlack,
            ),
          ),
        ],
      ),
    );
  }
}
