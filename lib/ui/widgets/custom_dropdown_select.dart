import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';

/*
* Custom Dropdown Select
* */

class CustomDropdownSelect<T> extends StatefulWidget {
  final String? labelText;
  final List<DropdownMenuItem<T>> items;
  final T? selectedValue;
  final String? errorText;
  final String? hintText;
  final ValueChanged<T?>? onChanged;

  const CustomDropdownSelect(
      {super.key,
      required this.labelText,
      required this.items,
      required this.selectedValue,
      required this.errorText,
      required this.hintText,
      required this.onChanged});

  @override
  State<CustomDropdownSelect<T>> createState() =>
      _CustomDropdownSelectState<T>();
}

class _CustomDropdownSelectState<T> extends State<CustomDropdownSelect<T>> {
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
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      value: widget.selectedValue,
      items: widget.items,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusColor: RootColors.seasalt,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: RootColors.seasalt, width: 1.5),
        ),
        errorText: widget.errorText,
      ),
      hint: Text(widget.hintText!),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200, //.. Maksimal tingi dropdown
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        elevation: 8,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
