import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/layouts/safe_child.dart';

/*
* CustomPageLayout untuk membungkus konten form sektor dan perangkat (devices)
* */

class CustomPageLayout extends StatelessWidget {
  final List<Widget> leadingWidget; //..
  final List<Widget> body;

  const CustomPageLayout({super.key, required this.leadingWidget, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeChild(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: leadingWidget.isNotEmpty
                    ? leadingWidget
                    : [
                        const SizedBox.shrink(),
                      ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body.isNotEmpty
                        ? body
                        : [
                            const SizedBox.shrink(),
                          ],
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
