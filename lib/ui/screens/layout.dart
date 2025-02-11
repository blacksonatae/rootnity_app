import 'package:flutter/material.dart';
import 'package:rootnity_app/core/app_theme.dart';
import 'package:rootnity_app/ui/widget/popupmenu/show_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutsScreen extends StatefulWidget {
  const LayoutsScreen({super.key});

  @override
  State<LayoutsScreen> createState() => _LayoutsScreenState();
}

class _LayoutsScreenState extends State<LayoutsScreen> {
  final GlobalKey _userMenuKey = GlobalKey(); // Key untuk mengetahui posisi tombol
  final GlobalKey _addMenuKey = GlobalKey(); // Key untuk mengetahui posisi tombol

  // Pada variabel userName inisialisasi loading, sebelum user diambil
  String _userName = "loading...";

  // Variabel index halaman yang akan dipilih
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  // Fungsi untuk mengambil nama user dari SharedPreferences
  void _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String fullName = preferences.getString('name') ?? "User";
    setState(() {
      _userName =
      (fullName.length > 12) ? "${fullName.substring(0, 12)}..." : fullName;
    });
  }

  // List widget pada halaman yang akan dipilih
  final List<Widget> _pages = [
    const Center(
      child: Text("Halaman Home"),
    ),
    const Center(
      child: Text("Halaman Profile"),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _pages[_selectedIndex]),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                _userName,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                key: _userMenuKey,
                onTap: () {
                  CustomPopUpMenu.showMenuUser(context, _userMenuKey);
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
            key: _addMenuKey,
            onPressed: () {
              CustomPopUpMenu.showAddOptions(context, _addMenuKey, () {
                print("Sector Clicked");
              }, () {
                print("Devices Clicked");
              });
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Footer or Bottom Nav
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: Colors.white,
      selectedItemColor: AppTheme.kellyGreen,
      unselectedItemColor: AppTheme.seasalt,
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
