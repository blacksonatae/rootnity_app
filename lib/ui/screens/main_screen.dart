import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';
import 'package:rootnity_app/ui/screens/home/home.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      layout: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                Home(),
              ],
            ),
          ),
          CustomFooterWidget(
              selectedIndex: _selectedIndex, onItemTapped: _onItemTapped)
        ],
      ),
    );
  }
}
