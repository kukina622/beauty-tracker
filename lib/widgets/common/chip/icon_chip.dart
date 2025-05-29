import 'package:flutter/material.dart';

class IconChip extends StatelessWidget {
  const IconChip({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.iconSize = 24,
    this.size = 50,
  });
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
