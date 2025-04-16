import 'package:flutter/material.dart';

enum ToastPosition { top, center, bottom }

class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
    Color backgroundColor = Colors.black,
    double opacity = 0.7,
  }) {
    final overlay = Overlay.of(context);

    final mediaQuery = MediaQuery.of(context);
    final double topPadding = mediaQuery.padding.top;
    final double buttomPadding = mediaQuery.viewInsets.bottom;

    Alignment alignment;
    EdgeInsets margin;

    switch (position) {
      case ToastPosition.top:
        alignment = Alignment.topCenter;
        margin = EdgeInsets.only(top: topPadding + 20.0);
        break;
      case ToastPosition.center:
        alignment = Alignment.center;
        margin = EdgeInsets.zero;
        break;
      case ToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        margin = EdgeInsets.only(bottom: buttomPadding + 20.0);
        break;
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: alignment,
            child: Container(
              margin: margin,
              child: _buildToast(message, backgroundColor, opacity),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration).then((_) => overlayEntry.remove());
  }

  static Widget _buildToast(String message, Color bgColor, double opacity) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
