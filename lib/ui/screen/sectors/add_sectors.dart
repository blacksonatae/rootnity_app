import 'package:flutter/material.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/screen/layouts/layout_no_mains.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

class AddSectors extends StatefulWidget {
  const AddSectors({super.key});

  @override
  State<AddSectors> createState() => _AddSectorsState();
}

class _AddSectorsState extends State<AddSectors> {
  final TextEditingController sectors = TextEditingController();
  bool isLoading = false;

  Map<String, dynamic>? errors;

  void _addSectors() async {
    final result = await SectorServices.createSectors(sectors.text, context);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result['status'] == true) {
      Navigator.pop(context, true);
    }
  }

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
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Themes.eerieBlack,
          ),
        ),
        GestureDetector(
          onTap: () => _addSectors(),
          child: Icon(
            Icons.check,
            color: Themes.brandeisBlue,
          ),
        )
      ],
      body: [
        CustomTextField(controller: sectors, label: "Masukkan Sektor", errorText: errors?['name_sectors']?.first,),
      ],
    );
  }
}
