import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rootnity_app/core/app_theme.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/screens/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString('token'); // Ambil token

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const LayoutsScreen() : const LoginScreen(),
    );
  }
}
