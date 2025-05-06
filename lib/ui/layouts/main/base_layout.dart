import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/layouts/main/canvas_layout.dart';
import 'package:rootnity_app/ui/widgets/custom_footer_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_header_widget.dart';
import 'package:rootnity_app/ui/widgets/custom_refresh_status.dart';

/*
* File BaseLayout -> Layout dasar yang menggabung header, konten, dan footer
* */

class BaseLayout extends StatelessWidget {
  // Konten Utama
  final Widget content;

  // Refresh controller untuk pull to refresh
  final RefreshController? refreshController;

  // Callback ketika refresh dijalankan
  final VoidCallback? onRefresh;

  // Footer Navigation
  final int? selectedIndex;
  final ValueChanged<int>? onItemTapped;

  //.. Custom header widgets
  final List<Widget>? leadingWidgets;

  //.. Tampilkan footer
  final bool footerWidgets;

  //.. Aktifkan pull-to-refresh
  final bool enableRefresh;

  // Padding
  final EdgeInsetsGeometry contentPadding;

  const BaseLayout(
      {super.key,
      required this.content,
      this.refreshController,
      this.onRefresh,
      this.selectedIndex,
      this.onItemTapped,
      this.leadingWidgets,
      this.footerWidgets = false,
      this.enableRefresh = false,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0)});

  @override
  Widget build(BuildContext context) {
    final layout =
        enableRefresh && refreshController != null && onRefresh != null
            ? SmartRefresher(
                controller: refreshController!,
                enablePullDown: true,
                header: CustomRefreshStatus(),
                onRefresh: onRefresh,
                child: _buildContent(),
              )
            : _buildContent();
    return CanvasLayout(layouts: layout);
  }

  Widget _buildContent() {
    return Column(
      children: [
        //.. Header
        if (leadingWidgets != null)
          Padding(
            padding: contentPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: leadingWidgets!,
            ),
          )
        else
          CustomHeaderWidget(),

        //.. Konten utama dengan padding
        Expanded(
          child: Padding(
            padding: contentPadding,
            child: content,
          ),
        ),

        //.. Footer jika diaktifkan
        if (footerWidgets)
          CustomFooterWidget(
            selectedIndex: selectedIndex ?? 0,
            onItemTapped: onItemTapped ?? (_) {},
          ),
      ],
    );
  }
}
