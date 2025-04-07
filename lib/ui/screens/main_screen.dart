import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screens/home.dart';
import 'package:rootnity_app/ui/screens/profile.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  //.. List halaman (Home dan Profile)
  final List<Widget> _listPages = const [
    HomeScreen(), //.. Home Screen
    ProfileScreen(), //.. Profile Screen
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
      //.. Gunakan IndexedStack agar state tiap halaman terjaga (tidak refreshing atau fetch data otomatis)
      body: IndexedStack(
        index: _selectedIndex,
        children: _listPages,
      ),
      bottomNavigationBar: CustomFooterWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
