import 'package:flutter/material.dart';

class TabPageScrollView extends StatelessWidget {
  const TabPageScrollView({
    super.key,
    this.header = const [],
    required this.sliver,
    this.padding = const EdgeInsets.all(24),
  });

  final List<Widget> header;
  final Widget sliver;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets headerPadding = header.isNotEmpty
        ? EdgeInsets.only(top: 24, bottom: 0, left: padding.left, right: padding.right)
        : EdgeInsets.zero;

    return SafeArea(
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
          SliverPadding(
            padding: padding,
            sliver: sliver,
          )
        ],
      ),
    );
  }
}
