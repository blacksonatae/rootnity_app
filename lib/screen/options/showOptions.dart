import 'package:flutter/material.dart';

class ShowOptions {
  // Menampilkan menu popup menu untuk logout saat menekan button
  static void showMenuUser(BuildContext context, GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double menuWidth = 120;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - menuWidth,
        position.dy + renderBox.size.height + 5, // Muncul di bawah tombol
        position.dx,
        position.dy + 150,
      ),
      items: [
        PopupMenuItem(
          height: 35,
          value: "logout",
          child: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0),
          ),
          onTap: () {},
        ),
      ],
      color: Colors.white,
    );
  }

  // Untuk menampilkan halaman Add menu saat menekan button add
  static void showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.category),
                title: Text('Add Sectors'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.devices),
                title: Text('Add Devices'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
