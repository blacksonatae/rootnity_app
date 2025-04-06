import 'package:flutter/material.dart';

/*
* Gunakan class popupmenu untuk mengurangi pengguna memori, dengan membuat object dari class popup menu
* */

class CustomPopupMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuItems;
  final Widget child;
  final Offset offset;

  const CustomPopupMenu(
      {super.key,
      required this.menuItems,
      required this.child,
      this.offset = const Offset(40, 0)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        /*final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset position = renderBox.localToGlobal(Offset.zero);*/

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx + offset.dx,
            details.globalPosition.dy + offset.dy,
            details.globalPosition.dx + offset.dx + 1,
            details.globalPosition.dy + offset.dy + 1,
          ),
          items: menuItems,
          color: Colors.white,
        );
      },
      child: child,
    );
  }
}
