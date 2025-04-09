import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

class CreateSectors extends StatefulWidget {
  const CreateSectors({super.key});

  @override
  State<CreateSectors> createState() => _CreateSectorsState();
}

class _CreateSectorsState extends State<CreateSectors> {
  final TextEditingController nameSectors = TextEditingController();

  Map<String, dynamic>? errors;

  void _createSectors() async {
    var result = await SectorsServices.createSectors(nameSectors.text, context);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result['status'] == true) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageLayout(
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_outlined,
            color: ThemeApp.eerieBlack,
          ),
        ),
        Text(
          "Tambahkan Sektor",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          //.. Mengarah ke halaman konfigurasi wifi
          onTap: () => _createSectors(),
          child: Icon(
            Icons.check,
            color: ThemeApp.brandeisBlue,
          ),
        ),
      ],
      body: [
        //.. Heading
        Text(
          "Tambahkan Sektor Baru",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
        //.. Text Keterangan
        Text(
          "Masukan nama sektor untuk menambah sektor baru !",
          style: TextStyle(fontSize: 14.5, color: ThemeApp.seasalt),
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
    );
  }
}
