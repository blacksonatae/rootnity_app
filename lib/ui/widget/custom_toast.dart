import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';

class CustomToast {
  static final List<OverlayEntry> _toasts = []; //.. Gunakan list untuk antrian toast
  //.. Fungsi show untuk menampilkan toast dengan memasukan parameter pesan dan jenis toast
  static void show(BuildContext context, String message, String type) {
    if (context.mounted == false) return; //.. Pastikan context masih ada

    Color backgroundColor; //.. Background color berdasarkan jenis toast
    // Menentukan warna berdasarkan tipe toast
    switch (type) {
      case 'success':
        backgroundColor = Themes.kellyGreen;
        break;
      case 'error':
        backgroundColor = Colors.red;
        break;
      case 'info':
      default:
        backgroundColor = Themes.brandeisBlue;
        break;
    }

    OverlayEntry overlayEntry;
    final overlayState = Overlay.of(context);
    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 200),
    );
    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(animationController);
    final slideAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(animationController);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20 + (_toasts.length * 60), //.. Menyesuaikan posisi agar setiap toast dalam antrian yang tidak tumpah tindih
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    _toasts.add(overlayEntry);
    overlayState.insert(overlayEntry);

    animationController.forward(); // Animasi Fade In & Slide Down

    Future.delayed(const Duration(seconds: 5), () => _removeToast(overlayEntry));
  }

  static void _removeToast(OverlayEntry overlayEntry) {
    if (_toasts.contains(overlayEntry)) {
      overlayEntry.remove();
      _toasts.remove(overlayEntry);
    }
  }
}