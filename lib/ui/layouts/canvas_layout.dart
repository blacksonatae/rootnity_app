import 'package:flutter/material.dart';

class CanvasLayout extends StatelessWidget {
  final bool isPadding;
  final EdgeInsets? padding;
  final Widget child;

  const CanvasLayout(
      {super.key, required this.child, this.isPadding = false, this.padding});

  @override
  Widget build(BuildContext context) {
    //.. Scaffold sebagai kanvas untuk menaruk widget elemen
    return Scaffold(
      //.. Sebagai padding untuk mencegah widget menabrak pada indikator smartphone
      body: SafeArea(
        //.. Padding
        child: isPadding
            ? Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              )
            : child,
      ),
    );
  }
}
