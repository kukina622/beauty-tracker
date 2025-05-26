import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actionButton,
  });

  final String title;
  final String? subtitle;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
              ),
          ],
        ),
        actionButton ?? const SizedBox.shrink(),
      ],
    );
  }
}
