import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.width,
    this.height = 56,
    this.isFilled = false,
    required this.text,
  });
  final void Function()? onPressed;
  final double? width;
  final double height;
  final String text;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFilled ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
