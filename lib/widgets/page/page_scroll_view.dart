import 'package:flutter/material.dart';

class PageScrollView extends StatelessWidget {
  const PageScrollView({
    super.key,
    this.header = const [],
    this.slivers = const [],
    this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 0),
    this.enableRefresh = false,
    this.onRefresh,
  });

  final List<Widget> header;
  final List<Widget> slivers;
  final EdgeInsets padding;
  final bool enableRefresh;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets headerPadding = header.isNotEmpty
        ? EdgeInsets.only(top: 16, bottom: 0, left: padding.left, right: padding.right)
        : EdgeInsets.zero;

    final customScrollView = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: headerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: header,
            ),
          ),
        ),
        ...slivers.map(
          (sliver) => SliverPadding(
            padding: padding,
            sliver: sliver,
          ),
        ),
      ],
    );

    final Widget scrollViewWithRefresh = enableRefresh && onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh!,
            child: customScrollView,
          )
        : customScrollView;

    return SafeArea(
      maintainBottomViewPadding: true,
      child: scrollViewWithRefresh,
    );
  }
}
