import 'package:flutter/material.dart';

/*
* Gunakan class popupmenu sehingga mengurangi pengguna memori, untuk objek dari popupmenu untuk logout (hanya logout, list sektor, dan button add (sektor dan perangkat)
* */

class CustomPopupmenu extends StatelessWidget {
  final List<PopupMenuEntry> menuItems;
  final Widget child;
  final Offset offset;

  const CustomPopupmenu({
    super.key,
    required this.menuItems,
    required this.child,
    this.offset = const Offset(40, 0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset position = renderBox.localToGlobal(Offset.zero);
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              position.dx + offset.dx, // Geser sejajar dengan tombol
              position.dy + offset.dy,
              position.dx + offset.dx + 1,
              position.dy + offset.dy + 1,
            ),
            items: menuItems,
            color: Colors.white);
      },
      child: child,
    );
  }
}
