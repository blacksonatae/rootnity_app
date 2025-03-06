import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/home.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sectors/add_sectors.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  String _userName = "User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String fullName = preferences.getString('name') ?? "User";
    print(fullName);
    setState(() {
      _userName = (fullName.length > 12) ? "${fullName.substring(0, 12)}..." : fullName;
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

  /*
  * Header */
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // nama user or username
              Text(
                _userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.3,
                  color: Themes.eerieBlack,
                ),
              ),
              // button untuk logout
              CustomPopupmenu(
                menuItems: [
                  PopupMenuItem(
                    child: Text("Logout"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  ),
                ],
                offset: Offset(-60, 30),
                child: Icon(Icons.arrow_drop_down_rounded),
              ),
            ],
          ),
          // button untuk add sektor dan devices
          CustomPopupmenu(
            menuItems: [
              PopupMenuItem(
                child: Text("Tambah Sektor"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddSectors()));
                },
              ),
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
                onTap: () {
                  
                }
              ),
            ],
            offset: Offset(-150, 30),
            child: Icon(
              Icons.add_circle_outline,
              color: Themes.eerieBlack,
            ),
          ),
        ],
      ),
    );
  }
}
