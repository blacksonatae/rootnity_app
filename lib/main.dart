import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/screens/main_screen.dart';
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
      home: isLoggedIn ? const MainScreen(): const LoginScreen(),
    );
  }
}