import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  //.. List halaman (Home dan Profile)
  final List<Widget> _listPages = const[

  ];

  //.. Fungsi untuk mengubah tab halaman saat tombol di BottomNavigationBar ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
