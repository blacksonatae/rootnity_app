import 'package:flutter/material.dart';
import 'options/showAddOptions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index halaman yang akan dipilih

  final List<Widget> _pages = [
    Center(child: Text("Devices Page", style: TextStyle(fontSize: 20))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              /* Isi Konten Header*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    /*
                  * Pengguna ada nama dan button menu
                  * */
                    children: [
                      Text(
                        'Kazuya',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  /*
                * Button Add akan menampilkan bentuk list card seperti add sectors dan add devices
                * */
                  IconButton(
                      onPressed: () {
                        ShowOptions.showAddOptions(context);
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
            Expanded(
              child: _pages[_selectedIndex],
            ),

            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index; // Ubah halaman saat item ditekan
                });
              },
              backgroundColor: Colors.white,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.monitor),
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
