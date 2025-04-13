import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/sectors.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/devices_services.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_dropdown_select.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDevicesForm extends StatefulWidget {
  const AddDevicesForm({super.key});

  @override
  State<AddDevicesForm> createState() => _AddDevicesFormState();
}

class _AddDevicesFormState extends State<AddDevicesForm> {
  final TextEditingController nameDevices = TextEditingController();
  List<Map<String, dynamic>> sectors = [];

  Sectors? selectedSectors;

  Map<String, dynamic>? errors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SectorsServices.fetchSectors(context);
  }


  void _addDevices() async {
    var result = await DevicesServices.createDevices(nameDevices.text, selectedSectors!.id, context);


    if (result['status']) {
      Navigator.pop(context);
    } else {
      setState(() => errors = result['errors']);
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
          "Final Tambahkan Perangkat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          //.. Mengarah ke halaman konfigurasi wifi
          onTap: () {
            _addDevices();
          },
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
          controller: nameDevices,
          label: "Nama Perangkat",
          errorText: errors?['name_device']?.first,
        ),
        SizedBox(height: 20),
        //.. Select Dropdown Sector Form
        StreamBuilder<List<Sectors>>(
          stream: SectorsServices.sectorStream,
          builder: (context, snapshot) {
            final sectors = snapshot.data ?? [];

            return CustomDropdownSelect(
              labelText: "Sektor",
              items: sectors.map((sector) {
                return DropdownMenuItem(
                  value: sector,
                  child: Text(sector.name),
                );
              }).toList(),
              selectedValue: selectedSectors,
              errorText: errors?['sectors_id']?.first,
              hintText: "Pilih Sektor",
              onChanged: (sector) {
                setState(() => selectedSectors = sector);
              },
            );
          },
        ),
      ],
    );
  }
}
