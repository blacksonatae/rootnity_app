import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String backgroundImageUri;
  final List<Widget> body;

  const AuthLayout({
    super.key,
    required this.title,
    required this.backgroundImageUri,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //.. Background Images
            AspectRatio(
              aspectRatio: 1.45,
              child: Image.asset(
                backgroundImageUri,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  //.. Title atau Header
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  //.. Body isi dalam halaman seperti text field dan beberapa button
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
