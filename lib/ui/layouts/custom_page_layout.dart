import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';

/*
* CustomPageLayout untuk membungkus konten pada
* sektor dan perangkat (devices)
* */

class CustomPageLayout extends StatelessWidget {
  final List<Widget> leadingWidget; //./ Header menu
  final List<Widget> body; //.. Konten
  const CustomPageLayout({
    super.key,
    required this.leadingWidget,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      isPadding: true,
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. Header widget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            //.. leading widget
            children: leadingWidget.isNotEmpty
                ? leadingWidget
                : [const SizedBox.shrink()],
          ),
          //.. Konten
          SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
