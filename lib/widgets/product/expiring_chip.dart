import 'package:beauty_tracker/constants.dart';
import 'package:beauty_tracker/widgets/common/chip/text_chip.dart';
import 'package:beauty_tracker/widgets/common/chip/text_icon_chip.dart';
import 'package:flutter/material.dart';

class ExpiringChip extends StatelessWidget {
  const ExpiringChip({super.key, required this.expiryDate});
  final DateTime expiryDate;

  @override
  Widget build(BuildContext context) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    final isExpired = daysUntilExpiry < 0;
    final isExpiringSoon = daysUntilExpiry >= 0 && daysUntilExpiry <= AppConstants.expiringSoonDays;

    String text;
    if (daysUntilExpiry == 0) {
      text = '今日過期';
    } else if (isExpired) {
      text = '已過期 ${daysUntilExpiry.abs()} 天';
    } else {
      text = '有效期還有 $daysUntilExpiry 天';
    }

    Color statusColor;
    if (daysUntilExpiry == 0) {
      statusColor = const Color(0xFFE91E63);
    } else if (isExpired) {
      statusColor = const Color(0xFFFF6B6B);
    } else if (isExpiringSoon) {
      statusColor = const Color(0xFFFF9F1C);
    } else {
      statusColor = const Color(0xFF5ECCC4);
    }

    if (daysUntilExpiry == 0) {
      return TextIconChip(
        text: text,
        icon: Icons.bookmark,
        iconColor: statusColor,
        textColor: statusColor,
        backgroundColor: statusColor.withValues(alpha: .2),
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      );
    }

    return TextChip(
      text: text,
      backgroundColor: statusColor.withValues(alpha: .2),
      textColor: statusColor,
    );
  }
}
