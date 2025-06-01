import 'package:flutter/material.dart';

class AppStandardIconButton extends StatelessWidget {
  const AppStandardIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor = const Color(0xFF5ECCC4),
    this.size = 20.0,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        color: iconColor,
        size: size,
      ),
    );
  }
}
