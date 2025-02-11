import 'package:flutter/material.dart';
import 'package:rootnity_app/core/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppTheme.eerieBlack,
      controller: widget.controller,
      focusNode: focusNode,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorText: widget.errorText,
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              obscureText =
              !obscureText; // Jika menekan icon maka obscure teks akan false, sehingga dapat melihat password yang dimasukan
            });
          },
          icon: Icon(obscureText
              ? Icons.visibility
              : Icons.visibility_off_outlined),
        )
            : null, // Jika text field bukan tipe password maka kondisi null atau tidak ada field password
        focusColor: AppTheme.seasalt,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppTheme.seasalt, width: 2),
        ),
      ),
    );
  }
}
