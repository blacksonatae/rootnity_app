import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/model/sectors.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/custom_page_layout.dart';
import 'package:rootnity_app/ui/screens/sectors/create_sectors.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';

class ManagerSectors extends StatefulWidget {
  const ManagerSectors({super.key});

  @override
  State<ManagerSectors> createState() => _ManagerSectorsState();
}

class _ManagerSectorsState extends State<ManagerSectors> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //.. Load Awal
    SectorsServices.fetchSectors(context);
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
          "Kelola Sektor",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: ThemeApp.eerieBlack,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateSectors())),
          child: Icon(
            Icons.add_circle_outline,
            color: ThemeApp.eerieBlack,
          ),
        ),
      ],
      body: [
        //.. Heading
        Text(
          "Daftar Sektor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeApp.eerieBlack,
          ),
        ),
        SizedBox(height: 7.5),
        //.. Text Keterangan
        Text(
          "Anda dapat menemukan dan mengubah serta menghapus sektor.",
          style: TextStyle(fontSize: 14.5, color: ThemeApp.seasalt),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 30),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder<List<Sectors>>(
              stream: SectorsServices.sectorStream,
              builder: (context, snapshot) {
                final sectors = snapshot.data ?? [];

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sectors.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //.. Informasi Sektor
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //.. Nama Sektor
                            Text(
                              sectors[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            //.. Jumlah Devices
                            Text(
                              "Tidak ada perangkat",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: ThemeApp.seasalt,
                              ),
                            )
                          ],
                        ),
                        //.. Button Edit dan Delete
                        CustomPopupMenu(
                          menuItems: [
                            //.. Edit Sectors
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ubah Sektor",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(Icons.edit_note),
                                ],
                              ),
                              onTap: () => (),
                            ),
                            //.. Delete Sectors
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hapus Sektor",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(Icons.delete_sweep),
                                ],
                              ),
                              onTap: () => (),
                            ),
                          ],
                          child: Icon(
                            BootstrapIcons.three_dots_vertical,
                            size: 18,
                            color: ThemeApp.seasalt,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
