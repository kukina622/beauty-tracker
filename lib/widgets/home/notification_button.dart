import 'package:beauty_tracker/widgets/common/icon_button/app_filled_icon_button.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFilledIconButton(
      icon: Icons.notifications_outlined,
      iconColor: const Color(0xFF2D3142),
      backgroundColor: Colors.white,
      size: 44.0,
      borderRadius: BorderRadius.circular(12),
      onPressed: () {},
    );
  }
}
