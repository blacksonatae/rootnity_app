import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';

class CustomFooterWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomFooterWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomFooterWidget> createState() => _CustomFooterWidgetState();
}

class _CustomFooterWidgetState extends State<CustomFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
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
