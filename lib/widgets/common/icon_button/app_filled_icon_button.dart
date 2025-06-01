import 'package:flutter/material.dart';

class AppFilledIconButton extends StatelessWidget {
  const AppFilledIconButton({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFF2D3142),
    this.backgroundColor = Colors.white,
    this.size = 44.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onPressed,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        highlightColor: Colors.transparent,
        onPressed: onPressed,
      ),
    );
  }
}
