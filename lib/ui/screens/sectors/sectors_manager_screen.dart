import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/core/models/device.dart';
import 'package:rootnity_app/core/models/sector.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/data/controllers/devices_controller.dart';
import 'package:rootnity_app/data/controllers/sectors_controller.dart';
import 'package:rootnity_app/data/storages/devices_storage.dart';
import 'package:rootnity_app/data/storages/sectors_storage.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_popupmenu.dart';

class SectorsManagerScreen extends StatefulWidget {
  const SectorsManagerScreen({super.key});

  @override
  State<SectorsManagerScreen> createState() => _SectorsManagerScreenState();
}

class _SectorsManagerScreenState extends State<SectorsManagerScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      layout: Baselayout(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        isMainScreen: false,
        leadingWidgets: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_outlined,
              color: RootColors.eerieBlack,
            ),
          ),
          Text(
            "Kelola Sektor",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: RootColors.eerieBlack),
          ),
          GestureDetector(
            onTap: () => (),
            child: const Icon(
              Icons.add_circle_outline,
              color: RootColors.eerieBlack,
            ),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Daftar Sektor",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: RootColors.eerieBlack,
              ),
            ),
            SizedBox(height: 7.5),
            //.. Text Keterangan
            Text(
              "Anda dapat menemukan dan mengubah serta menghapus sektor.",
              style: TextStyle(fontSize: 14.5, color: RootColors.seasalt),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 15),
            //.. List Sektor berdasarkan nama dan jumlah perangkat
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: StreamBuilder<List<Sector>>(
                    stream: SectorsStorage.sectorStream,
                    builder: (context, snapshoot) {
                      final sectors = snapshoot.data ?? [];

                      return ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sectors.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return Padding(
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
                                    //.. Jumlah Perangkat
                                    StreamBuilder<List<Device>>(
                                      stream: DevicesStorage.deviceStream,
                                      builder: (context, snapshoot) {
                                        final sector = sectors[index];
                                        final device = snapshoot.data ?? [];
                                        final deviceCounts = device
                                            .where((device) =>
                                                device.sectorId == sector.id)
                                            .toList();

                                        return Text(
                                          deviceCounts.isNotEmpty
                                              ? "${deviceCounts.length} Perangkat"
                                              : "Tidak ada perangkat",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: RootColors.seasalt,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                CustomPopupMenu(
                                  menuItems: [
                                    PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ubah Sektor",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Icon(Icons.edit_note),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: Icon(
                                    BootstrapIcons.three_dots_vertical,
                                    size: 18,
                                    color: RootColors.seasalt,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
