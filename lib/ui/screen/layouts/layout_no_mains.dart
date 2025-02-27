import 'package:flutter/material.dart';

class LayoutNoMains extends StatelessWidget {
  final String title;
  final List<Widget>?
      leadingWidget; // pakai list karena ada beberapa button dan komponen yang ingin dimasukkan
  final List<Widget> body;

  const LayoutNoMains(
      {super.key, required this.title, this.leadingWidget, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading atau App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingWidget != null) ...leadingWidget!,
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body.isNotEmpty ? body : [const SizedBox.shrink()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
