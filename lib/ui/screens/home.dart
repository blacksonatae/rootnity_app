import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/model/devices.dart';
import 'package:rootnity_app/core/model/sectors.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/devices_services.dart';
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

  int _sectorCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch data pertama kali
    SectorsServices.fetchSectors(context);
    DevicesServices.fetchDevices(context);
  }

  // Fungsi untuk mengurangi panjang nama sektor
  String showNameSectors(String nameSectors) {
    return (nameSectors.length > 12)
        ? "${nameSectors.substring(0, 12)}..."
        : nameSectors;
  }

  // Fungsi refresh halaman
  void _onRefresh() async {
    await SectorsServices.fetchSectors(context);
    await DevicesServices.fetchDevices(context);
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
        (MediaQuery.of(context).size.width / 2 - itemWidth / 2);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // List Sektor
          StreamBuilder<List<Sectors>>(
            stream: SectorsServices.sectorStream,
            builder: (context, snapshot) {
              final sectors = snapshot.data ?? [];
              print("Stream Sectors: ${sectors.map((s) => s.toJson()).toList()}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              }
              if (sectors.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Belum ada sektor'),
                );
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
                          bool isSelected = index == _sectorCurrentIndex;
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
                        separatorBuilder: (_, __) => const SizedBox(width: 25),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPopupMenu(
                    menuItems: [
                      PopupMenuItem(
                        enabled: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
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
                                          showNameSectors(sectors[index].name)),
                                      onTap: () {
                                        _onSectorTapped(index);
                                        print(
                                            "Sektor dipilih: ${sectors[index].toJson()}");
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManagerSectors(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    offset: const Offset(-145, 5),
                    child: const Icon(
                      BootstrapIcons.list,
                      size: 24,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // List Devices (Grid 2 kolom per sektor)
          Expanded(
            child: StreamBuilder<List<Sectors>>(
              stream: SectorsServices.sectorStream,
              builder: (context, sectorSnapshot) {
                final sectors = sectorSnapshot.data ?? [];
                if (sectors.isEmpty) {
                  return const Center(child: Text("Tidak ada sektor."));
                }
                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => _onPageChanged(index),
                  itemCount: sectors.length,
                  itemBuilder: (context, pageIndex) {
                    // Debug print data sektor aktif
                    print("Menampilkan sektor: ${sectors[pageIndex].toJson()}");
                    final currentSectorId = sectors[pageIndex].id;
                    return SingleChildScrollView(
                      child: StreamBuilder<List<Devices>>(
                        stream: DevicesServices.devicesStream,
                        builder: (context, deviceSnapshot) {
                          final allDevices = deviceSnapshot.data ?? [];
                          // Debug: print seluruh data devices
                          print("Data Devices: ${allDevices.map((d) => d.toJson()).toList()}");
                          final sectorDevices = allDevices
                              .where((d) => d.sectors_id == currentSectorId)
                              .toList();

                          print("Devices pada sektor $currentSectorId: ${sectorDevices.map((d) => d.toJson()).toList()}");

                          print("👉 Filtering devices untuk sektor ID: $currentSectorId");
                          for (var d in allDevices) {
                            print("Device ${d.name_device} sector_id: ${d.sectors_id}");
                          }
                          if (sectorDevices.isEmpty) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      const SizedBox(height: 18),
                                      const Text(
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
                          }
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sectorDevices.length,
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.2,
                            ),
                            itemBuilder: (context, gridIndex) {
                              final device = sectorDevices[gridIndex];
                              print("Menampilkan device: ${device.toJson()}");
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        BootstrapIcons.device_hdd,
                                        size: 30,
                                        color: ThemeApp.eerieBlack,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        device.name_device,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
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
