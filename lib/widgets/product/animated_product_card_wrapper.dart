import 'package:beauty_tracker/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

class AnimatedProductCardWrapper extends StatelessWidget {
  const AnimatedProductCardWrapper({
    super.key,
    required this.animation,
    required this.child,
    this.isRemoving = false,
  });

  final Animation<double> animation;
  final ProductCard child;
  final bool isRemoving;

  static const double _kSlideOutFactor = 1.2;

  @override
  Widget build(BuildContext context) {
    final slideAnim = isRemoving ? ReverseAnimation(animation) : animation;

    final positionTween = isRemoving
        ? Tween<Offset>(
            begin: Offset.zero,
            end: Offset(_kSlideOutFactor, 0),
          )
        : Tween<Offset>(
            begin: Offset(-_kSlideOutFactor, 0),
            end: Offset.zero,
          );

    return SlideTransition(
      position: positionTween.animate(
        CurvedAnimation(
          parent: slideAnim,
          curve: isRemoving ? Curves.easeInCubic : Curves.easeOutCubic,
        ),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: isRemoving ? Curves.easeIn : Curves.easeOut,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: child,
        ),
      ),
    );
  }
}
