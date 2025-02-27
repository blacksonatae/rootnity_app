import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/layouts/layout_no_mains.dart';

import '../../../core/themes.dart';

class SectorsManager extends StatefulWidget {
  const SectorsManager({super.key});

  @override
  State<SectorsManager> createState() => _SectorsManagerState();
}

class _SectorsManagerState extends State<SectorsManager> {
  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(title: "Sektor",
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_outlined, color: Themes.eerieBlack,),
        ),
        Text("Tambahkan", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        SizedBox() // Kosongkan saja agar teks tetap ditengah
      ],
    );
  }
}
