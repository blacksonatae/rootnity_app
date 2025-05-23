import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final String title; //.. Header atau title pada halaman autenfikasi
  final List<Widget> body; //.. Isi halaman autenfikasi

  const AuthLayout({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //.. Background Images
          AspectRatio(
            aspectRatio: 1.45,
            child: Image.asset(
              "images/pexels-mdsnmdsnmdsn-1216345.jpg",
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 25
                  ),
                ),
                //.. Body atau element widget
                ...body,
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
