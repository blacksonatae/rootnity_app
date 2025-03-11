import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/layouts/layout.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // Mengambil token dari preferences yang sudah diambil dari database setelah login dan register
  String? token = preferences.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; // Sebagai status login apakah ada token

  const MyApp({super.key, required bool this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Jika status loggged in false maka diarahkan ke halaman login screen
      home: isLoggedIn ? LayoutScreen() : LoginScreen(),
    );
  }
}
