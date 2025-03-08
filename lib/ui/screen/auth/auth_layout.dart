import 'dart:math';

import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String backgroundImages;
  final List<Widget> body;

  const AuthLayout(
      {super.key,
      required this.title,
      required this.backgroundImages,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // .. Background
            AspectRatio(
              aspectRatio: 1.25,
              child: Image.asset(
                backgroundImages,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                  ...body,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
