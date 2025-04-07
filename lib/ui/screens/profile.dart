import "package:flutter/material.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";
import "package:rootnity_app/ui/layouts/base_layout.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //.. Fungsi untuk merefresh halaman
  void _onRefresh() async {}
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("Profile Screen"),
              )
            ],
          ),
        ),
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        selectedIndex: 1);
  }
}
