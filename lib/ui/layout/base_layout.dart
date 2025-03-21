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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _selectedIndex = 0; //.. Variabel halaman saat ini

  final List<Widget> _pages = [
    const Center(
      child: Text("Halaman Home"),
    ),
    const Center(
      child: Text("Halaman Profile"),
    )
  ];

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /*
            * SmartRefresher untuk membungkus header
            * dan konten sehingga bisa merefresh halaman
            * */
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                header: CustomHeader(
                  builder: (context, mode) {
                    Widget body;
                    switch (mode) {
                      case RefreshStatus.canRefresh:
                        body = const CustomRefreshStatus(textRefreshStatus: "Lepaskan untuk memuat...", dirAnimation: "assets/animations/hover_arrow_down.gif");
                        break;
                      case RefreshStatus.refreshing:
                        body = const CustomRefreshStatus(textRefreshStatus: "Lepaskan untuk memuat...", dirAnimation: "assets/animations/checklist_animation.gif");
                        break;
                      case RefreshStatus.completed:
                        body = const CustomRefreshStatus(textRefreshStatus: "Sukses", dirAnimation: "assets/animations/checklist_animation.gif");
                        break;
                      case RefreshStatus.failed:
                        body = const CustomRefreshStatus(textRefreshStatus: "Gagal! Terjadi Kesalahan..", dirAnimation: "assets/animations/errors_animation.gif");
                        break;
                      default:
                        body = const Text("Pull down to refresh");
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
                    //.. Fungsi List Widget pada halaman
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                ),
              ),
            ),
            //.. Fungsi Footer
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
