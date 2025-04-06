import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';

class CustomFooterWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomFooterWidget(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: ThemeApp.kellyGreen,
      unselectedItemColor: ThemeApp.seasalt,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.devices_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}
