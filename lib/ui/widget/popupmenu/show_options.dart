import 'package:flutter/material.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';

class CustomPopUpMenu {
  static void PopUpMenu(
      BuildContext context, GlobalKey key, List<PopupMenuEntry> menuItems) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double menuWidth = 160;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - menuWidth / 2,
        position.dy + renderBox.size.height + 5,
        position.dx + menuWidth / 2,
        position.dy + 150,
      ),
      items: menuItems,
      color: Colors.white,
    );
  }

  static void showMenuUser(BuildContext context, GlobalKey key) {
    PopUpMenu(context, key, [
      PopupMenuItem(
        value: "logout",
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        onTap: () async {
          await AuthServices.logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      ),
    ]);
  }

  // Menampilkan popup menu Add Options
  static void showAddOptions(BuildContext context, GlobalKey key,
      VoidCallback onAddSectors, VoidCallback onAddDevices) {
    PopUpMenu(
      context,
      key,
      [
        PopupMenuItem(
          value: "add_sectors",
          onTap: onAddSectors,
          child: Row(
            children: [
              Icon(Icons.category, size: 20),
              SizedBox(width: 10),
              Text("Add Sectors"),
            ],
          ),
        ),
        PopupMenuItem(
          value: "add_devices",
          onTap: onAddDevices,
          child: Row(
            children: [
              Icon(Icons.devices, size: 20),
              SizedBox(width: 10),
              Text("Add Devices"),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowOptions {
  // Menampilkan menu popup menu untuk logout saat menekan button arrow sebelah nama user
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
          onTap: () async {
            await AuthServices.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ],
      color: Colors.white,
    );
  }

  // Untuk menampilkan halaman pada popup menu Add menu saat menekan button add
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
