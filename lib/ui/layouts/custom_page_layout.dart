import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rootnity_app/ui/layouts/canvas_layout.dart';

/*
* CustomPageLayout untuk membungkus konten pada
* sektor dan perangkat (devices)
* */

class CustomPageLayout extends StatelessWidget {
  final List<Widget> leadingWidget; //./ Header menu
  final Widget body; //.. Konten
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final bool enableRefresh;

  const CustomPageLayout({
    super.key,
    required this.leadingWidget,
    required this.body,
    required this.refreshController,
    required this.onRefresh,
    this.enableRefresh = false,
  });

  @override
  Widget build(BuildContext context) {
    return CanvasLayout(
      isPadding: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //.. Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: leadingWidget.isNotEmpty
                ? leadingWidget
                : [const SizedBox.shrink()],
          ),
          const SizedBox(height: 30),
          Expanded(
            child:
                enableRefresh && refreshController != null && onRefresh != null
                    ? SmartRefresher(
                        controller: refreshController!,
                        onRefresh: onRefresh,
                        child: _buildContent(),
                      )
                    : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: body,
    );
  }
}
