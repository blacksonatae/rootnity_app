import 'package:flutter/material.dart';

/*
* File: SafeChild untuk membungkus halaman lain agar tidak tumpah tindih
* dengan indikator gadget.
* */

class SafeChild extends StatelessWidget {
  final Widget child;

  const SafeChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
