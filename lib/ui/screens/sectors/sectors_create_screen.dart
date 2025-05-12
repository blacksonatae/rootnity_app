import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/data/controllers/sectors_controller.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

class SectorsCreateScreen extends StatefulWidget {
  const SectorsCreateScreen({super.key});

  @override
  State<SectorsCreateScreen> createState() => _SectorsCreateScreenState();
}

class _SectorsCreateScreenState extends State<SectorsCreateScreen> {
  final TextEditingController name = TextEditingController();

  //.. Variabel untuk mengampung error dari API
  Map<String, dynamic>? errors;

  void _addSectors() async {
    var result = await SectorsController.createSectors(name.text, context);

    if (result['status'] == true) {
      Navigator.pop(context);
    }

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      layout: Baselayout(
        leadingWidgets: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: RootColors.eerieBlack,
            ),
          ),
          Text(
            "Kelola Sektor",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: RootColors.eerieBlack),
          ),
          GestureDetector(
            //.. Mengarah ke halaman konfigurasi wifi
            onTap: () => _addSectors(),
            child: Icon(
              Icons.check,
              color: RootColors.brandeisBlue,
            ),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SizedBox(height: 10),
            //.. Text Keterangan
            Text(
              "Masukan nama sektor untuk menambah sektor baru !",
              style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            //.. Text Field
            CustomTextField(
              controller: name,
              label: "Masukkan Sektor",
              errorText: errors?['name_sectors']?.first,
            ),
          ],
        ),
      ),
    );
  }
}
