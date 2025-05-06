import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

class SectorsAddScreen extends StatefulWidget {
  const SectorsAddScreen({super.key});

  @override
  State<SectorsAddScreen> createState() => _SectorsAddScreenState();
}

class _SectorsAddScreenState extends State<SectorsAddScreen> {
  final TextEditingController nameSectors = TextEditingController();

  Map<String, dynamic>? errors;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      leadingWidgets: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_outlined,
            color: RootColors.eerieBlack,
          ),
        ),
        Text(
          "Tambahkan Sektor",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: RootColors.eerieBlack,
          ),
        ),
        GestureDetector(
          //.. Mengarah ke halaman konfigurasi wifi
          onTap: () => (),
          child: Icon(
            Icons.check,
            color: RootColors.brandeisBlue,
          ),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. Heading
          Text(
            "Tambahkan Sektor Baru",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: RootColors.eerieBlack,
            ),
          ),
          SizedBox(height: 7.5),
          //.. Text Keterangan
          Text(
            "Masukan nama sektor untuk menambah sektor baru !",
            style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 30),
          //.. Text Field
          CustomTextField(
            controller: nameSectors,
            label: "Masukkan Sektor",
            errorText: errors?['name_sectors']?.first,
          ),
        ],
      ),
    );
  }
}
