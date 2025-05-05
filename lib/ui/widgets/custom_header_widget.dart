import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHeaderWidget extends StatefulWidget {
  const CustomHeaderWidget({super.key});

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  //.. Variabel untuk nama pengguna
  String? _username = "User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //.. Fungsi untuk mengambil nama pengguna dari SharedPreferences
  void _getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString("name") ?? "User";

    setState(() {
      _username =
          (username.length > 12) ? "${username.substring(0, 12)}..." : username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
