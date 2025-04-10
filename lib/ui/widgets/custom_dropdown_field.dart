import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Widget? hint;
  final void Function(T?)? onChanged;
  final String? errorText;

  const CustomDropdownField(
      {super.key,
      required this.items,
      required this.value,
      required this.onChanged,
      this.errorText, this.hint});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ThemeApp.seasalt, width: 2),
        ),
      ),
      isEmpty: value == null,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged,
          hint: hint,
        ),
      ),
    );
  }
}
