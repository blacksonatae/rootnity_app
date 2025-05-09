import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String nameButton;
  final VoidCallback? onPressed;

  const CustomElevatedButton(
      {super.key, required this.nameButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(RootColors.eerieBlack),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          nameButton,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
