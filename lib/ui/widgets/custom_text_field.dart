import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/validators.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? errorText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.isPassword = false,
      this.errorText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText =
      true; //.. Variabel untuk menampilkan atau menyembunyikan password

  late FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: RootColors.eerieBlack,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorText: Validators().capitalize(widget.errorText),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText =
                        !obscureText; //.. Jika menekan icon maka obscure teks akan false, sehingga dapat melihat password yang dimasukan
                  });
                },
                icon: Icon(obscureText
                    ? Icons.visibility
                    : Icons.visibility_off_outlined),
              )
            : null,
        //.. Jika text field bukan tipe password maka kondisi null atau tidak ada field password
        focusColor: RootColors.seasalt,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: RootColors.seasalt, width: 1.5),
        ),
      ),
    );
  }
}
