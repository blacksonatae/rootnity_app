import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/screen/layout/layout_no_mains.dart';

class SectorsManager extends StatefulWidget {
  const SectorsManager({super.key});

  @override
  State<SectorsManager> createState() => _SectorsManagerState();
}

class _SectorsManagerState extends State<SectorsManager> {
  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    _fetchSectors();
  }

  void _fetchSectors() async {
    await SectorServices.fetchSectors(
        context); //.. Pastikan fetchSectors dijalankan setelah build pertama
  }

  @override
  Widget build(BuildContext context) {
    return LayoutNoMains(
      title: "Kelola Sektor",
      leadingWidget: [
        //.. Tombol back dengan gesture detector
        GestureDetector(
          child: const Icon(
            Icons.arrow_back_outlined,
            color: ThemeApp.eerieBlack,
          ),
          onTap: () => Navigator.pop(context, true),
        ),
        //.. Judul atau heading
        Text(
          "Kelola Sektor",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ThemeApp.eerieBlack),
        ),
        SizedBox(),
      ],
      body: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
          color: Colors.white,
          child: StreamBuilder<List<Sectors>>(
            stream: SectorServices.sectorStream,
            builder: (context, snapshot) {
              // Periksa jika data kosong
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Tidak ada sektor tersedia."));
              }

              List<Sectors> sectors = snapshot
                  .data!; //.. Menyimpan daftar sektor ke variabel global

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        sectors[index].name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(color: Colors.white,),
                itemCount: sectors.length,
              );
            },
          ),
        )
      ],
    );
  }
}
