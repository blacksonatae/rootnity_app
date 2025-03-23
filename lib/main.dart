import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //.. Panggil fungsi 
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //.. Mengambil token dari preferences yang diambil dari local yang sudah didapatkan dari token laravel
  String? token = preferences.getString('token');
  
  //.. Fungsi untuk menjalankan program
  runApp(MyApp(isLoggedIn: token != null));
  
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; //.. Sebagai status login untuk menentukan apakah pengguna sudah login atau belum

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
