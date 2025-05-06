import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/layouts/main/base_layout.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      refreshController: _refreshController,
      onRefresh: _onRefresh,
      enableRefresh: true,
      content: Center(
        child: Text("Profile"),
      ),
    );
  }
}
