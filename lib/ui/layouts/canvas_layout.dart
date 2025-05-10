import 'package:flutter/material.dart';

class CanvasLayout extends StatelessWidget {
  final Widget layout;

  const CanvasLayout({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //.. Gunakan SafeArea untuk membungkus halaman lain agar tidak tumpah tindih dengan indikator gadget
      body: SafeArea(child: layout),
    );
  }
}
