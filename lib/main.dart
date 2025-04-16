import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //.. Memanggil Fungsi SharedPreferences untuk local storages
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //.. Mengambil token dari preferences yang sudah diambil dari local storages
  String? token = preferences.getString('token');

  //.. Fungsi untuk menjalankan program
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool
      isLoggedIn; //.. Sebagai status login untuk menentukan pengguna login atau belum
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.grey.shade300, //.. Untuk warna highlight pada text
          selectionHandleColor: Colors.grey, //.. Untuk warna titik bulat untuk pegangan pada teks
          cursorColor: Colors.grey, //.. Untuk warna cursor
        ),
      ),
      home: Login(),
    );
  }
}
