import 'package:flutter/material.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/screen/layouts/layout_no_mains.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

import '../../../core/themes.dart';

class AddSectors extends StatefulWidget {
  const AddSectors({super.key});

  @override
  State<AddSectors> createState() => _AddSectorsState();
}

class _AddSectorsState extends State<AddSectors> {
  bool isButtonDisabled = true;

  final TextEditingController sectorsController = TextEditingController();

  Map<String, dynamic>? errors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sectorsController.addListener(() {
      setState(() {
        isButtonDisabled = sectorsController.text.isEmpty || sectorsController.text.contains(RegExp(r'[^\w]')) || sectorsController.text.contains(r'[^a-zA-Z0-9]');
      });
    });
  }

  void _addSectors() async {
    final result = await SectorsServices().addSectors(sectorsController.text);

    print(result);

    if (result != null && result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result != null && result['status'] == true) {
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
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Themes.eerieBlack),
        ),
        GestureDetector(
          onTap: isButtonDisabled ? null : () {
            _addSectors();
          },
          child: Icon(
            Icons.check,
            color: isButtonDisabled ? Themes.seasalt : Themes.brandeisBlue,
          ),
        ),
      ],
      body: [
        CustomTextField(
            controller: sectorsController, label: "Masukkan Sektor"),
      ],
    );
  }
}
