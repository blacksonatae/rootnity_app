import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/layout/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //.. Mengambil token dari preferences yang sudah diambil dari database
  String? token = preferences.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; //.. Sebagai status login apakah ada token;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? LayoutScreen() : LoginScreen(),
    );
  }
}