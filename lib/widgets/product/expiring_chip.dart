import 'package:beauty_tracker/constants.dart';
import 'package:beauty_tracker/widgets/common/chip/text_chip.dart';
import 'package:flutter/material.dart';

class ExpiringChip extends StatelessWidget {
  const ExpiringChip({super.key, required this.expiryDate});
  final DateTime expiryDate;

  @override
  Widget build(BuildContext context) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    final isExpired = daysUntilExpiry < 0;
    final isExpiringSoon = daysUntilExpiry >= 0 && daysUntilExpiry <= AppConstants.expiringSoonDays;

    Color statusColor;

    if (isExpired) {
      statusColor = const Color(0xFFFF6B6B);
    } else if (isExpiringSoon) {
      statusColor = const Color(0xFFFF9F1C);
    } else {
      statusColor = const Color(0xFF5ECCC4);
    }

    return TextChip(
      text: isExpired ? '過期 ${daysUntilExpiry.abs()} 天' : '有效期還有 $daysUntilExpiry 天',
      backgroundColor: statusColor.withValues(alpha: .2),
      textColor: statusColor,
    );
  }
}
