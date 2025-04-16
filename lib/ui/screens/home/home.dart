import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/layouts/base_layout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  //.. fungsi onRefresh untuk merefresh halaman
  void _onRefresh() async {

  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      enableRefresh: true,
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. List Sektor
        ],
      ),
    );
  }
}
