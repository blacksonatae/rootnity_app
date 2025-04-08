import 'package:flutter/material.dart';

class AuthBaseLayout extends StatelessWidget {
  final String title; //.. Header atau title pada halaman
  final String backgroundImagesUri;
  final List<Widget> body;

  const AuthBaseLayout(
      {super.key,
      required this.title,
      required this.backgroundImagesUri,
      required this.body});

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
                backgroundImagesUri,
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                  //.. Body atau elemen wiget
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
