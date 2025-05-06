import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/model/Sector.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/services/controller/sectors_services.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  int _sectorCurrentIndex = 0;

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  // Fungsi untuk mengurangi panjang nama sektor
  String showNameSectors(String nameSectors) {
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
            builder: (context, snapshot) {
              final sectors = snapshot.data ?? [];
              //.. List Sektor dan Menu dibungkus dalam baris
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        itemCount: sectors.length,
                        separatorBuilder: (context, snapshoot) =>
                            const SizedBox(
                          width: 25,
                        ),
                        itemBuilder: (context, index) {
                          bool isSelected = index == _sectorCurrentIndex;

                          return GestureDetector(
                            onTap: () => (),
                            child: Text(
                              showNameSectors(sectors[index].nameSectors),
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? RootColors.eerieBlack
                                    : RootColors.seasalt,
                                fontWeight: isSelected
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //.. Menu yang berisi daftar sektor dan manager sektor
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
                                      child: Text(showNameSectors(
                                          sectors[index].nameSectors)),
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
                              onTap: () {},
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
          //.. List Device yang berisi nama
          Expanded(
            child: StreamBuilder<List<Sector>>(
              stream: SectorsServices.sectorStream,
              builder: (context, snapshot) {
                final sectors = snapshot.data ?? [];
                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => _onPageChanged(index),
                  itemCount: sectors.length,
                  itemBuilder: (context, device) {
                    final devices = snapshot.data ?? [];
                    return Card();
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
