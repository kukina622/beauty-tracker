import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.height = 56,
    this.isFilled = false,
    this.borderColor = const Color(0xFFFF9A9E),
    this.textColor = const Color(0xFFFF9A9E),
    this.iconColor = const Color(0xFFFF9A9E),
    this.backgroundColor = Colors.white,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.textStyle,
    this.iconSize = 20,
    this.spacing = 8,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isFilled;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final TextStyle? textStyle;
  final double iconSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: textColor,
    );

    return SizedBox(
      width: isFilled ? double.infinity : width,
      height: height,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: borderWidth,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                  SizedBox(width: spacing),
                ],
                Text(
                  text,
                  style: textStyle ?? defaultTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
