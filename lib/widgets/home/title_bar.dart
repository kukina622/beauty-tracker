import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
    required this.title,
    this.enableAddOption = true,
    this.onAddIconPressed,
  });
  final String title;
  final bool enableAddOption;
  final VoidCallback? onAddIconPressed;

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
        SizedBox(width: 8),
        if (enableAddOption)
          GestureDetector(
            onTap: onAddIconPressed,
            child: const Icon(
              size: 24,
              Icons.add_circle_outline,
              color: Color(0xFFFF9A9E),
            ),
          )
      ],
    );
  }
}
