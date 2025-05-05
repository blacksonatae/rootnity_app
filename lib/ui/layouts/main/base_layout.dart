import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* File BaseLayout -> Layout dasar yang menggabung header, konten, dan footer
* */

class BaseLayout extends StatelessWidget {
  final Widget content;
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  final bool enableRefresh;

  const BaseLayout(
      {super.key,
      required this.content,
      this.refreshController,
      this.onRefresh,
      this.enableRefresh = false});

  @override
  Widget build(BuildContext context) {
    return enableRefresh && refreshController != null && onRefresh != null
        ? SmartRefresher(
            controller: refreshController!,
            enablePullDown: true,
            header: null,
            onRefresh: onRefresh,
            child: _buildContent())
        : _buildContent();
  }

  Widget _buildContent() {
    return Column(
      children: [
        //.. Header
        
        //.. Content
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: content),
        ),
      ],
    );
  }
}
