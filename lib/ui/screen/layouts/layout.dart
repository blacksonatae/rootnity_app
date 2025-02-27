import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/screen/home.dart';
import 'package:rootnity_app/ui/screen/sectors/sectors_manager.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
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
                "Kazuya",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SectorsManager()));
                },
              ),
              PopupMenuItem(
                child: Text("Tambah Perangkat"),
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
