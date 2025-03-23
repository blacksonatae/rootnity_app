import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/widget/custom_footer_widget.dart';
import 'package:rootnity_app/ui/widget/custom_header_widget.dart';
import 'package:rootnity_app/ui/widget/custom_refresh_status.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  //.. Refresh Controller
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _selectedIndex = 0; //.. Variabel untuk menentukan halaman yang aktif

  //.. Fungsi List Widget pada Halaman
  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //.. Implementasi SmartRefresher untuk membungkus header dan konten sehingga bisa merefresh halaman
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                header: CustomHeader(
                  builder: (context, mode) {
                    Widget body;
                    //.. Gunakan kondisi status refresh dengan switch
                    switch (mode) {
                      case RefreshStatus.canRefresh:
                        body = const CustomRefreshStatus(
                            textRefreshStatus: "Lepaskan untuk memuat...",
                            dirAnimation:
                                "assets/animations/hover_arrow_down.gif");
                        break;
                      case RefreshStatus.refreshing:
                        body = const CustomRefreshStatus(
                            textRefreshStatus: "Memuat...",
                            dirAnimation:
                                "assets/animations/loading_animation.gif");
                        break;
                      case RefreshStatus.completed: //.. Jika berhasil refresh
                        body = const CustomRefreshStatus(
                            textRefreshStatus: "Sukses",
                            dirAnimation:
                                "assets/animations/checklist_animation.gif");
                        break;
                      case RefreshStatus.failed:
                        body = const CustomRefreshStatus(
                            textRefreshStatus: "Gagal! Terjadi Kesalahan..",
                            dirAnimation:
                                "assets/animations/errors_animation.gif");
                        break;
                      default:
                        body = const Text(
                          "Tarik kebawah untuk refresh",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        );
                        break;
                    }
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: body,
                      ),
                    );
                  },
                ),
                child: Column(
                  children: [
                    //.. Fungsi Header
                    CustomHeaderWidget(),
                    //.. Fungsi List Widget pada Halaman
                    Expanded(child: pages[_selectedIndex]),
                  ],
                ),
              ),
            ),
            CustomFooterWidget(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
