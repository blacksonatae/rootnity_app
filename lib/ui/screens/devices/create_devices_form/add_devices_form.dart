import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/Sector.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/services/api/api_services.dart';
import 'package:rootnity_app/services/controller/devices_services.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_dropdown_select.dart';
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

  Sector? sectorSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SectorsServices.fetchSectors(context);
  }

  void _addDevices() async {
    var result = await DevicesServices.createDevices(nameDevices.text, sectorSelected!.id, context);

    print(sectorSelected!.id);
    if (result['status'] == true) {
      Navigator.pop(context);
    } else {
      setState(() => errors = result['errors'] ?? {});
    }
  }

  /*void _addDevices() async {
    print('▶️ Posting to /api/devices → name = ${nameDevices.text}, sector = ${sectorSelected!.id}');
    final response = await ApiServices.postData(
      '/devices',
      {
        'name_devices': nameDevices.text.trim(),
        'sectors_id'  : sectorSelected!.id,
      },
      context,
    );
    print('🛑 Response: ${response?.statusCode} | ${response?.data}');
  }*/


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
          onTap: () => _addDevices(),
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
            errorText: errors?['name_devices']?.first,
          ),
          SizedBox(height: 20),
          //.. Select Dropdown Sector Form
          //.. Select Dropdown Sector Form
          StreamBuilder<List<Sector>>(
            stream: SectorsServices.sectorStream,
            builder: (context, snapshot) {
              final sectors = snapshot.data ?? [];

              return CustomDropdownSelect(
                labelText: "Sektor",
                items: sectors.map((sector) {
                  return DropdownMenuItem(
                    value: sector,
                    child: Text(sector.nameSectors),
                  );
                }).toList(),
                selectedValue: sectorSelected,
                errorText: errors?['sectors_id']?.first,
                hintText: "Pilih Sektor",
                onChanged: (sector) {
                  print(sectorSelected);
                  setState(() => sectorSelected = sector);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
