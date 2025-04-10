import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_dropdown_field.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

class AddDevicesForm extends StatefulWidget {
  const AddDevicesForm({super.key});

  @override
  State<AddDevicesForm> createState() => _AddDevicesFormState();
}

class _AddDevicesFormState extends State<AddDevicesForm> {
  final TextEditingController _nameDevices = TextEditingController();

  String? _selectedOption;
  final _options = ['Pilih Sektor', 'Pendidikan', 'Kesehatan'];

  Map<String, dynamic>? errors;

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
          "Final Tambahkan Perangkat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          //.. Mengarah ke halaman konfigurasi wifi
          onTap: () {},
          child: Icon(
            Icons.check,
            color: ThemeApp.brandeisBlue,
          ),
        ),
      ],
      body: [
        //.. Heading
        Text(
          "Final Perangkat Baru",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
        //.. Text Keterangan
        Text(
          "Tambahkan perangkat baru dengan memasukkan nama perangkat dan sektor yang dipilih.",
          style: TextStyle(fontSize: 14.5, color: ThemeApp.seasalt),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 30),
        CustomTextField(
          controller: _nameDevices,
          label: "Nama Perangkat",
          errorText: errors?['name_devices']?.first,
        ),
        SizedBox(height: 15),
        //.. Select form
        CustomDropdownField<String>(
          items: _options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          value: _selectedOption, // harus null jika belum dipilih
          hint: Text("Pilih Sektor"), // tampil hanya jika belum dipilih
          onChanged: (val) {
            setState(() {
              _selectedOption = val;
            });
          },
          errorText: _selectedOption == null ? 'Wajib diisi' : null,
        )

      ],
    );
  }
}
