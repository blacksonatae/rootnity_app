import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/models/device.dart';
import 'package:rootnity_app/core/models/sector.dart';
import 'package:rootnity_app/data/controllers/devices_controller.dart';
import 'package:rootnity_app/data/controllers/sectors_controller.dart';
import 'package:rootnity_app/data/storages/devices_storage.dart';
import 'package:rootnity_app/data/storages/sectors_storage.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
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

    // .. Mengambil data lokal pada sector dan device
    SectorsStorage.init().then((_) {
      // data lokal sudah di-push ke stream
      // UI akan mendengar streamnya di StreamBuilder
    });

    DevicesStorage.init().then((_) {
      // data lokal sudah di-push ke stream
      // UI akan mendengar streamnya di StreamBuilder
    });
  }

  void _onRefresh() async {
    try {
      await SectorsController.fetchSectors(
          context); // Fetch Sector jika merefresh halaman
      await DevicesController.fetchDevices(
          context); // Fetch Devices jika merefresh halaman
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
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
    return Baselayout(
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      body: Column(
        children: [
          StreamBuilder<List<Sector>>(
            stream: SectorsStorage.sectorStream,
            builder: (context, sector) {
              final sectors = sector.data ?? [];

              return ListSectors(
                sectors: sectors,
                sectorCurrentIndex: _sectorCurrentIndex,
                scrollController: _scrollController,
                onSectorsTap: (index) {
                  _onSectorTapped(index);
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<Sector>>(
              stream: SectorsStorage.sectorStream,
              builder: (context, sector) {
                final sectors = sector.data ?? [];
                return StreamBuilder<List<Device>>(
                  stream: DevicesStorage.deviceStream,
                  builder: (context, index) {
                    final device = index.data ?? [];

                    return PageView.builder(
                      controller: _pageController,
                      itemCount: sectors.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final sector = sectors[index];
                        final devices = device
                            .where((device) => device.sectorId == sector.id)
                            .toList();

                        return ListDevices(devices: devices);
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
