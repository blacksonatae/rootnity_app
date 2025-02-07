import 'package:flutter/material.dart';
import 'package:rootnity_app/screen/auth/login.dart';
import 'package:rootnity_app/screen/auth/register.dart';
import 'package:rootnity_app/screen/home.dart';
import 'package:rootnity_app/screen/options/show_options.dart';
import 'package:rootnity_app/screen/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    );
  }
}

/*
* Main Screen sebagai halaman canvas atau layout
* */
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Index halaman yang akan dipilih

  final GlobalKey _menuKey = GlobalKey(); // Key untuk mengetahui posisi tombol

  // List widget pada halaamn yang akan dipilih
  final List<Widget> _pages = [
    // Halaman home yang berisi berbagai sektor dan perangkat
    HomeScreen(),
    // Halaman profile yang berisi informasi user dan pengaturan akun serta logout
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header yang berisi menu logout, add menu (sektor dan devices) dan nama pengguna
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              /* Isi Kontent Header */
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    /*
                      * User header yang berisi nama pengguna dan menu untuk logout
                      * */
                    children: [
                      Text(
                        'Kazuya',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        key: _menuKey,
                        onTap: () {
                          ShowOptions.showMenuUser(context, _menuKey);
                        },
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  /*
                    * Button add akan menampilkan menu dalam bentuk list card seperti add sectors dan add devices
                    * */
                  IconButton(
                    onPressed: () {
                      ShowOptions.showAddOptions(context);
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            /*
            * Sebagai main extended halaman
            * */
            Expanded(child: _pages[_selectedIndex]),

            /*
            * Footer
            * */
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedItemColor: Colors.green.shade300,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.devices_outlined),
                  label: "Devices",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
