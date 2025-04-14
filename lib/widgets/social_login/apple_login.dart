import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppleLogin extends HookWidget {
  const AppleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Baseline(
          baseline: 22,
          baselineType: TextBaseline.alphabetic,
          child: Image.asset(
            'assets/icons/apple.png',
            width: 22,
            height: 22,
            color: Colors.white,
          ),
        ),
        label: Baseline(
          baseline: 16,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            'Apple',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
