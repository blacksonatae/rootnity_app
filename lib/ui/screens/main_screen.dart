import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/layouts/base_layouts.dart';
import 'package:rootnity_app/ui/screens/home.dart';
import 'package:rootnity_app/ui/screens/profile.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';

//.. Main Screen bertanggung jawab penuh untuk navigasi dan menyusun konten halaman utama

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; //.. Variabel untuk menyimpan indeks yang dipilih

  //.. Fungsi untuk menyimpan halaman yang dipilih berdasarkan index
  final List<Widget> _pages = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      //.. Menampilkan halaman yang dipilih berdasarkan indeks, gunakan IndexedStack agar state daru tiap halaman tidak akan reset saat berpindah
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      footer: CustomFooterWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
