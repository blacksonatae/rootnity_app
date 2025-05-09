import 'package:flutter/material.dart';

class NavigatorHelper {
  //.. Navigasi ke halaman baru (tanpa kembali)
  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  //.. Navigasi ke halaman baru dan hapus semua halaman sebelumnua
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  //.. Kembali ke halaman sebelumnya
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}