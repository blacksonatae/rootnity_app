import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  int _sectorCurrentIndex = 0; //.. Indeks pada sektor saat ini

  @override
  void initState() {
    super.initState();
    // Pastikan fetchSectors dijalankan setelah build pertama
    Future.delayed(Duration.zero, () => SectorServices.fetchSectors(context));
  }

  //.. Fungsi untuk mengurangi nama sektor jika terlalu panjang
  String nameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  //..

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. List sectors
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: StreamBuilder<List<Sectors>>(
                    stream: SectorServices.sectorStream, // Perbaiki nama stream
                    builder: (context, snapshot) {
                      // Periksa jika data kosong
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("Tidak ada sektor tersedia."));
                      }

                      List<Sectors> sectors = snapshot.data!;

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: sectors.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 25),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                nameSectors(sectors[index].name),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),

            ],
          )
        ],
      ),
    );
  }
}
