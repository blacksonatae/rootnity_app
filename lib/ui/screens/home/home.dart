import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/model/Device.dart';
import 'package:rootnity_app/core/model/Sector.dart';
import 'package:rootnity_app/services/controller/devices_services.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';
import 'package:rootnity_app/ui/screens/devices/list_devices.dart';
import 'package:rootnity_app/ui/screens/sectors/list_sectors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  int _sectorCurrentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SectorsServices.fetchSectors(context);
    DevicesServices.fetchDevices(context);
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
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
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      enableRefresh: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. List Sektor menggunakan Stream Builder
          StreamBuilder<List<Sector>>(
            stream: SectorsServices.sectorStream,
            builder: (context, sector) {
              final sectors = sector.data ?? [];

              if (sectors.isEmpty) {
                //  ➜ Tampilkan pesan jika belum ada sektor
                return const Center(
                  child: Text("Tidak ada sektor yang tersedia."),
                );
              }

              //.. List Sektor dan Menu dibungkus dalam baris
              return ListSectors(
                sectors: sectors,
                scrollController: _scrollController,
                sectorsCurrentIndex: _sectorCurrentIndex,
                onSectorsTap: (index) {
                  _onSectorTapped(index);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          //.. List Device yang berisi nama
          Expanded(
            child: StreamBuilder<List<Sector>>(
              stream: SectorsServices.sectorStream,
              builder: (context, sector) {
                final sectors = sector.data ?? [];
                return StreamBuilder<List<Device>>(
                  stream: DevicesServices.devicesStream,
                  builder: (context, device) {
                    final devices = device.data ?? [];

                    return PageView.builder(
                      controller: _pageController,
                      itemCount: sectors.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final sector = sectors[index];
                        //.. Filter devices OOP
                        final sectorDevices = devices.where((device) => device.sectorsId == sector.id).toList();

                        return SingleChildScrollView(
                          child: ListDevices(devices: sectorDevices),
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
