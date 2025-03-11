import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/models/sectors.dart';
import 'package:rootnity_app/services/sectors_services.dart';
import 'package:rootnity_app/ui/screen/sectors/add_sectors.dart';
import 'package:rootnity_app/ui/widget/custom_popupmenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  int _sectorCurrentIndex = 0; //.. Indeks pada sektor
  Future<List<Sectors>>?
      _sectorsFuture; //.. Variabel list sektor untuk mengampung daftar sektor
  bool isLoading = false; //.. Variabel kondisi untuk toast

  //.. Membuat fungsi untuk mengurangi nama sektor yang berlebih.
  String showNameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  //.. Gunakan iniState agar data atau konten diload saat halama dibuka
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        _sectorsFuture = SectorServices.getSectors(context);
      });
    });
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

    _pageController.jumpToPage(index);
    _scrollToCurrentSector(index);
  }

  void _scrollToCurrentSector(int index) {
    double itemWidth = 120;
    double offset = (index * itemWidth) -
        (MediaQuery.of(context).size.width / 2 - itemWidth / 2);

    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: Duration(microseconds: 300),
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
          // List Sectors
          FutureBuilder<List<Sectors>>(
            future: _sectorsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return Center(child: Text("Tidak ada sektor tersedia."));
              }

              List<Sectors> sectors = snapshot.data!;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: sectors.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 25,
                        ),
                        itemBuilder: (context, index) {
                          bool isSelected = _sectorCurrentIndex == index;
                          return GestureDetector(
                            onTap: () {
                              _onSectorTapped(index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                showNameSectors(sectors[index].name),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Themes.eerieBlack
                                      : Themes.seasalt,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomPopupmenu(
                    menuItems: [
                      PopupMenuItem(
                        enabled: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 150,
                                maxHeight: 200,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                    sectors.length,
                                    (index) => PopupMenuItem(
                                      child: Text(
                                        showNameSectors(sectors[index].name),
                                      ),
                                      onTap: () {
                                        _onSectorTapped(index);
                                        print("${sectors[index]} dipilih");
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Divider tetap di bawah
                            PopupMenuDivider(),
                            // "Pengaturan" tetap di bawah
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Kelola Sektor",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    BootstrapIcons.tablet,
                                    size: 14,
                                  ),
                                ],
                              ),
                              onTap: () {
                                print("Kelola Sektor ditekan");
                                /*Navigator.push(context, MaterialPageRoute(builder: (context) => SectorsManager()));*/
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    offset: Offset(-145, 5),
                    child: Icon(
                      BootstrapIcons.list,
                      size: 24,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20),
          /*
          * Buatkan bentuk card
          * */
          Expanded(
            child: FutureBuilder(
              future: _sectorsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return Center(child: Text("Tidak ada sektor tersedia."));
                }

                List<Sectors> sectors = snapshot.data!;

                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _onPageChanged(index);
                  },
                  itemCount: sectors.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(18.0),
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
                                  color: Themes.seasalt,
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
            ),
          ),
        ],
      ),
    );
  }
}
