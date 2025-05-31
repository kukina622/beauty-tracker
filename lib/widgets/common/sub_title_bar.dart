import 'package:flutter/material.dart';

class SubTitleBar extends StatelessWidget {
  const SubTitleBar({
    super.key,
    required this.title,
    this.action = const [],
  });
  final String title;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (action.isNotEmpty) ...[
          const SizedBox(width: 8),
          ...action,
        ],
      ],
    );
  }
}
