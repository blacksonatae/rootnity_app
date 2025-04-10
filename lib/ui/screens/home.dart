import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/model/sectors.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
import 'package:rootnity_app/ui/screens/sectors/manager_sectors.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  int _sectorCurrentIndex = 0; //.. Indeks pada sektor
  Future<List<Sectors>>?
  _sectorsFuture; //.. Variabel list sektor untuk mengampung daftar sektor

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //.. Fetch pertama kali
    SectorsServices.fetchSectors(context);
  }

  //.. Membuat fungsi untuk mengurangi nama sektor yang berlebih.
  String showNameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  //.. Fungsi untuk merefresh halaman
  void _onRefresh() async {
    await SectorsServices.fetchSectors(context);
    _refreshController.refreshCompleted();
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
        (MediaQuery
            .of(context)
            .size
            .width / 2 - itemWidth / 2);

    _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: Duration(microseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. List Sectors
          StreamBuilder<List<Sectors>>(
            stream: SectorsServices.sectorStream,
            builder: (context, snapshot) {
              final sectors = snapshot.data ?? [];
              if (sectors.isEmpty) {
                return const Text('Belum ada sektor');
              }
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
                        itemBuilder: (context, index) {
                          bool isSelected = _sectorCurrentIndex == index;
                          return GestureDetector(
                            onTap: () => _onSectorTapped(index),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                showNameSectors(sectors[index].name),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? ThemeApp.eerieBlack
                                      : ThemeApp.seasalt,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 25),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomPopupMenu(
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
                                        (index) =>
                                        PopupMenuItem(
                                          child: Text(
                                            showNameSectors(
                                                sectors[index].name),
                                          ),
                                          onTap: () {
                                            _onSectorTapped(index);
                                            print("${sectors[index]
                                                .name} dipilih");
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ManagerSectors()));
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
          const SizedBox(height: 16),
          //.. List Devices (Perangkat)
          Expanded(
            child: StreamBuilder<List<Sectors>>(
              stream: SectorsServices.sectorStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada sektor tersedia."));
                }

                // Perbarui daftar sektor secara real-time
                final sectors = snapshot.data!;

                return StatefulBuilder(
                  builder: (context, setStatePageView) {
                    return PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) => _onPageChanged(index),
                      itemCount: sectors.length,
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
      refreshController: _refreshController,
      onRefresh: _onRefresh,
    );
  }
}
