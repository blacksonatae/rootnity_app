import 'package:flutter/material.dart';

class LayoutNoMains extends StatelessWidget {
  final String title;
  final List<Widget>? leadingWidget; // pakai list karena ada beberapa button dan komponen yang ingin dimasukkan

  const LayoutNoMains({super.key, required this.title, this.leadingWidget});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
          child: Column(
            children: [
              // Leading atau App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingWidget != null) ...leadingWidget!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
