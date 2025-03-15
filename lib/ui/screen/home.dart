import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme_app.dart';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/screen/sectors/sectors_manager.dart';
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
  List<Sectors> _sectors = []; //.. Variabel list sektor yang secara global

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pastikan fetchSectors dijalankan setelah build pertama;
    _fetchSectors();
  }

  void _fetchSectors() async {
    await SectorServices.fetchSectors(
        context); //.. Pastikan fetchSectors dijalankan setelah build pertama
  }

  //.. Fungsi untuk mengurangi nama sektor jika terlalu panjang
  String nameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  void _onPageChanged(int index) {
    setState(() {
      _sectorCurrentIndex = index;
    });
    _scrollToCurrentSector(index);
  }

  void _onSectorTapped(int index) {
    setState(() {
      _sectorCurrentIndex = index;
    });
    _pageController.jumpToPage(index); //.. Memindahkan langsung tanpa animasi
    _scrollToCurrentSector(
        index); //.. Fungsi untuk mengatur scroll ke sektor saat dipilih
  }

  //..
  void _scrollToCurrentSector(int index) {
    double itemWidth = 90; // Sesuaikan dengan ukuran sektor
    double offset = (index * itemWidth) -
        (MediaQuery.of(context).size.width / 2 - itemWidth / 2);
    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. List sectors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      _sectors = snapshot
                          .data!; //.. Menyimpan daftar sektor ke variabel global

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: _sectors.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 25),
                        itemBuilder: (context, index) {
                          bool isSelected = _sectorCurrentIndex == index;
                          return GestureDetector(
                            onTap: () => _onSectorTapped(index),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                nameSectors(_sectors[index].name),
                                style: TextStyle(
                                  color: isSelected
                                      ? ThemeApp.eerieBlack
                                      : ThemeApp.seasalt,
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
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
              //.. Menu popupmenu untuk daftar sektor bisa menggunakan StatefulBuilder
              CustomPopupmenu(
                menuItems: [
                  PopupMenuItem(
                    enabled: false,
                    child: StatefulBuilder(
                      builder: (context, setStatePopup) {
                        return Column(
                          children: [
                            if (_sectors.isEmpty)
                              const Text("Tidak ada sektor tersedia."),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 200,
                                maxWidth: 150,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _sectors.map((sector) {
                                    return PopupMenuItem(
                                      child: Text(
                                        nameSectors(sector.name),
                                      ),
                                      onTap: () => _onSectorTapped(
                                        _sectors.indexOf(sector),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            PopupMenuDivider(),
                            //.. Pembatas untuk memisahkan list sektor dan kelola sektor
                            PopupMenuItem(
                              //.. Kelola sektor
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Kelola Sektor",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    BootstrapIcons.tablet,
                                    size: 14,
                                    color: ThemeApp.eerieBlack,
                                  ),
                                ],
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const SectorsManager())),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                offset: Offset(-145, 5),
                child: Icon(
                  BootstrapIcons.list,
                  color: ThemeApp.eerieBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          /*
          * Buatkan daftar perangkat masing" sektor dalam bentuk card */
          Expanded(
            child: StreamBuilder<List<Sectors>>(
              stream: SectorServices.sectorStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada sektor tersedia."));
                }

                // Perbarui daftar sektor secara real-time
                _sectors = snapshot.data!;

                return StatefulBuilder(
                  builder: (context, setStatePageView) {
                    return PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) => _onPageChanged(index),
                      itemCount: _sectors.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(18.0),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/plant_design.png',
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 100,
                                  ),
                                  SizedBox(height: 18),
                                  Text(
                                    "Tidak Ada Perangkat",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeApp.seasalt,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}