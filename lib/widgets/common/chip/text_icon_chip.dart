import 'package:flutter/material.dart';

class TextIconChip extends StatelessWidget {
  const TextIconChip({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor = const Color(0xFF000000),
    this.iconSize = 14,
    this.fontSize = 12,
    this.borderWidth = 1,
    this.suffixIcon,
    this.borderRadius,
    this.onSuffixIconPressed,
  });

  final String text;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double iconSize;
  final double fontSize;
  final double borderWidth;
  final IconData? suffixIcon;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onSuffixIconPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          if (suffixIcon != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onSuffixIconPressed,
              child: Icon(
                suffixIcon,
                color: textColor,
                size: iconSize,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
