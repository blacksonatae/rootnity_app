import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_header_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_refresh_status.dart';

/**
 * File: BaseLayout
 * -> Sebagai dasar yang menggabungkan header (Custom Header Widget), konten, SmartRefresher, dan footer (CustomFooterWidget)
 */
class BaseLayout extends StatelessWidget {
  final Widget
      content; //.. Variabel untuk mengampung konten halaman seperti widget
  final RefreshController
      refreshController; //.. Controller refresh untuk merefresh halaman
  final VoidCallback onRefresh;

  const BaseLayout({
    super.key,
    required this.content,
    required this.refreshController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      header: CustomRefreshStatus(),
      onRefresh: onRefresh,
      child: Column(
        children: [
          const CustomHeaderWidget(),
          //.. Header
          Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: content,
            ),
          ),
          //.. Content atau halaman seperti home dan profile yang memiliki elemen-elemen penting
        ],
      ),
    );
  }
}
