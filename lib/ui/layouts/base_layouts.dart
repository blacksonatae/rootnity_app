import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/widgets/custom_header_widget.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final Widget footer;

  const BaseLayout({super.key, required this.body, required this.footer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderWidget(),
            Expanded(child: body),
            footer,
          ],
        ),
      ),
    );
  }
}
