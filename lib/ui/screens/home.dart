import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //.. Fungsi untuk merefresh halaman
  void _onRefresh() async {}
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //.. List sektor dan pengaturan sektor (kelola)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text("Home Screen"),
                ),
              ],
            )
          ],
        ),
      ),
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      selectedIndex: 0,
    );
  }
}
