import 'package:flutter/material.dart';

enum ToastPosition { top, center, bottom }

class CustomToast {
  static OverlayEntry? _currentToast;

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    ToastPosition position = ToastPosition.bottom,
    Color backgroundColor = Colors.black,
    double opacity = 0.7,
  }) {
    final overlay = Overlay.of(context);

    //.. Menghapus toast sebelumnya jika ada
    _currentToast?.remove();
    _currentToast = null;

    //.. Konfigurasi posisi dan ukuran pada toast
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
        margin = EdgeInsets.only(bottom: buttomPadding + 15.0);
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
              child: _ToastWidget(
                message: message,
                duration: duration,
                backgroundColor: backgroundColor,
                opacity: opacity,
                onDismissed: () {
                  _currentToast = null;
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    _currentToast = overlayEntry;
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final double opacity;
  final VoidCallback onDismissed;

  const _ToastWidget(
      {super.key,
      required this.message,
      required this.duration,
      required this.backgroundColor,
      required this.opacity,
      required this.onDismissed});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();

    _animationController.forward();

    Future.delayed(widget.duration, () async {
      if (!mounted) return;

      await _animationController.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.backgroundColor.withOpacity(widget.opacity),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
