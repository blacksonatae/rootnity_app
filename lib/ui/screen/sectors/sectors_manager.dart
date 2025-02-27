import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/layouts/layout_no_mains.dart';
import 'package:rootnity_app/ui/screen/sectors/add_sectors.dart';
import '../../../core/themes.dart';

class SectorsManager extends StatefulWidget {
  const SectorsManager({super.key});

  @override
  State<SectorsManager> createState() => _SectorsManagerState();
}

class _SectorsManagerState extends State<SectorsManager> {
  bool editMenu = false;

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
    return LayoutNoMains(
      title: "Sektor",
      leadingWidget: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Themes.eerieBlack,
          ),
        ),
        const Text(
          "Kelola Sektor",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Themes.eerieBlack),
        ),
        editMenu
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    editMenu = !editMenu;
                  });
                },
                child: const Text(
                  "Batal",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                ),
              )
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        editMenu = true;
                      });
                    },
                    child: const Icon(Icons.edit_note),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddSectors()));
                    },
                    child: const Icon(Icons.add_circle_outline,
                        color: Themes.eerieBlack),
                  )
                ],
              )
      ],
      body: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
          color: Colors.white,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sectors.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    sectors[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  if (editMenu)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Edited clicked");
                          },
                          child: Icon(BootstrapIcons.pencil_square,
                              size: 22, color: Themes.eerieBlack),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            print("Deleted Selected");
                          },
                          child: Icon(BootstrapIcons.dash_circle_fill,
                              size: 22, color: Colors.red),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
