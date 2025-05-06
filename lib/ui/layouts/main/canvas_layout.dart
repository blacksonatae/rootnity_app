import 'package:flutter/material.dart';

class CanvasLayout extends StatelessWidget {
  final Widget layouts;

  const CanvasLayout({super.key, required this.layouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //.. Gunakan SafeArea untuk membungkus halaman lain agar tidak tumpah tindih dengan indikator gadget
      body: SafeArea(child: layouts),
    );
  }
}
