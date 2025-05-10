import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/widgets/custom_header_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_refresh_status.dart';

/**
 * File: BaseLayout
 * -> Sebagai dasar yang menggabungkan header (Custom Header Widget), konten, SmartRefresher, dan footer (CustomFooterWidget)
 */

class Baselayout extends StatelessWidget {
  //.. Konten utama
  final Widget content;

  //.. Refresh controller untuk pull to refresh
  final RefreshController? refreshController;

  //..
  // Callback ketika refresh dijalankan
  final VoidCallback? onRefresh;

  //.. Custom header widgets
  final List<Widget>? leadingWidgets;

  //.. Tampilkan footer
  final bool footerWidgets;

  //.. Footer navigation
  final int? selectedIndex;
  final ValueChanged<int>? onItemTapped;

  const Baselayout({
    super.key,
    required this.content,
    this.refreshController,
    this.onRefresh,
    this.leadingWidgets,
    required this.footerWidgets,
    this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController!,
      enablePullDown: true,
      header: CustomRefreshStatus(),
      onRefresh: onRefresh,
      child: Column(
        children: [
          if (leadingWidgets != null)
            ...?leadingWidgets
          else
            const CustomHeaderWidget(),
          
        ],
      ),
    );
  }
}
