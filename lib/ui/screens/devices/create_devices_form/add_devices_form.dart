import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

class AddDevicesForm extends StatefulWidget {
  const AddDevicesForm({super.key});

  @override
  State<AddDevicesForm> createState() => _AddDevicesFormState();
}

class _AddDevicesFormState extends State<AddDevicesForm> {
  final TextEditingController nameDevices = TextEditingController();
  List<Map<String, dynamic>> sectors = [];

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
          "Final Tambahkan Perangkat",
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
            "Tambahkan perangkat baru dengan memasukkan nama perangkat dan sektor yang dipilih.",
            style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 30),
          //.. Text Field
          CustomTextField(
            controller: nameDevices,
            label: "Nama Perangkat",
            errorText: errors?['name_device']?.first,
          ),
          SizedBox(height: 20),
          //.. Select Dropdown Sector Form
        ],
      ),
    );
  }
}
