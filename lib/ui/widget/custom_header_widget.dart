import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHeaderWidget extends StatefulWidget {

  const CustomHeaderWidget({super.key});

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidget();
}

class _CustomHeaderWidget extends State<CustomHeaderWidget> {
  String? _username = "User"; //.. Variabel user name atau pengguna

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName(); //.. Panggil loadUserName untuk memanggil nama pengguna
  }

  //.. Fungsi untuk mengambil nama pengguna dari SharedPreferences
  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString('name');

    setState(() {
      _username = (username != null && username.length > 12)
          ? "${username.substring(0, 12)}..."
          : username;
    });
  }

  void _logout() async {
    /*await AuthServices.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );*/
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
              //.. Untuk menampilkan username atau nama pengguna
              Text(
                _username ?? "User",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                  color: ThemeApp.eerieBlack,
                ),
              ),
              //.. PopupMenu sebagai dropdown untuk menampilkan menu logout
              CustomPopupmenu(
                menuItems: [
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () => _logout(),
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
              //.. Tombol tambah sektor
              PopupMenuItem(
                child: Text("Tambah Sektor"),
                onTap: () => (),
              ),
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
                onTap: () => (),
              ),
              //.. Tombol tambah perangkat
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
