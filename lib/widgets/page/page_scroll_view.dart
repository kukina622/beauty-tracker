import 'package:flutter/material.dart';

class PageScrollView extends StatelessWidget {
  const PageScrollView({
    super.key,
    this.header = const [],
    this.slivers = const [],
    this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 0),
  });

  final List<Widget> header;
  final List<Widget> slivers;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets headerPadding = header.isNotEmpty
        ? EdgeInsets.only(top: 24, bottom: 0, left: padding.left, right: padding.right)
        : EdgeInsets.zero;

    return SafeArea(
      maintainBottomViewPadding: true,
      child: CustomScrollView(
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
      ),
    );
  }
}
