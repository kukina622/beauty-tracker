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
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
