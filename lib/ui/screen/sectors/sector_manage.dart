import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/screen/home.dart';

class SectorManagers extends StatefulWidget {
  const SectorManagers({super.key});

  @override
  State<SectorManagers> createState() => _SectorManagersState();
}

class _SectorManagersState extends State<SectorManagers> {
  final List<String> sectors = [
    "Home",
    "Tora Farms",
    "Hans",
    "Halaman Belakang",
    "Kevin Farms",
    "Kedamaian Permai",
    "Mayor Ruslan",
    "Kazana",
    "Farm Smasf",
    "John Farms",
    "Johans",
    "Hanas",
    "Kenten Farms",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tombol Back ke Home Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Themes.eerieBlack,
                    ),
                  ),

                  // Menu
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Pengaturan Sektor
                      GestureDetector(
                        onTap: () {
                          print("Pengaturan Sektor");
                        },
                        child: Icon(
                          Icons.edit_note,
                          color: Themes.eerieBlack,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // Add Sektor
                      GestureDetector(
                        onTap: () {
                          print("Add Sektor");
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Themes.eerieBlack,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),

              // Heading
              Text(
                "Kelola Sektor",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Themes.eerieBlack,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              /*
              * List Sektor */
              Expanded(
                child: SingleChildScrollView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
