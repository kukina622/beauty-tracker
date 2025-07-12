import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actionButton,
    this.backButtonEnabled = false,
  });

  final String title;
  final String? subtitle;
  final Widget? actionButton;
  final bool backButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (backButtonEnabled) ...[
                  GestureDetector(
                    onTap: () => AutoRouter.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  SizedBox(width: 15),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                )
              ],
            ),
            SizedBox(height: 4),
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
