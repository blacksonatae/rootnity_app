import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/layouts/layout_no_mains.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

import '../../../core/themes.dart';

class AddSectors extends StatefulWidget {
  const AddSectors({super.key});

  @override
  State<AddSectors> createState() => _AddSectorsState();
}

class _AddSectorsState extends State<AddSectors> {
  final TextEditingController sectorsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(
      title: "Tambahkan Sektor",
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Themes.eerieBlack,
          ),
        ),
        const Text(
          "Tambah Sektor",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Themes.eerieBlack),
        ),
        SizedBox(),
      ],
      body: [
        CustomTextField(controller: sectorsController, label: "Masukkan Sektor"),
      ],
    );
  }
}
