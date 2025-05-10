import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_header_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_refresh_status.dart';

/**
 * File: BaseLayout
 * -> Sebagai dasar yang menggabungkan header (Custom Header Widget), konten, SmartRefresher, dan footer (CustomFooterWidget)
 */

class Baselayout extends StatelessWidget {
  //.. Konten utama
  final Widget body;

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

  final bool isMainScreen;

  const Baselayout({
    super.key,
    required this.body,
    this.refreshController,
    this.onRefresh,
    this.leadingWidgets,
    this.footerWidgets = false,
    this.selectedIndex,
    this.onItemTapped,
    this.isMainScreen = false,
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
          //.. Header
          if (leadingWidgets != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: leadingWidgets!.isNotEmpty
                    ? leadingWidgets!
                    : [const SizedBox.shrink()],
              ),
            )
          else
            const CustomHeaderWidget(),

          //.. Konten utama dengan padding
          Expanded(
            child: isMainScreen
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SingleChildScrollView(
                      child: body,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: body,
                  ),
          ),

          //.. Footer jika diaktifkan
          if (footerWidgets)
            CustomFooterWidget(
                selectedIndex: selectedIndex ?? 0,
                onItemTapped: onItemTapped ?? (_) {}),
        ],
      ),
    );
  }
}
