import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/screens/devices/create/scan_devices.dart';
import 'package:rootnity_app/ui/screens/main_screen.dart';
import 'package:rootnity_app/ui/screens/sectors/create_sectors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //.. Memanggil Fungsi SharedPreferences untuk local storages
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //.. Mengambil token dari preferences yang sudah diambil dari local storages
  String? token = prefs.getString('token');

  //.. Fungsi untuk menjalankan program
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool
      isLoggedIn; //.. Sebagai status login untuk menentukan pengguna sudah login atau belum

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: isLoggedIn ? MainScreen() : LoginScreen(),
      // home: MainScreen(),
    );
  }
}
