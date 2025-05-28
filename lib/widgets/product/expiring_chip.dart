import 'package:flutter/material.dart';

class ExpiringChip extends StatelessWidget {
  const ExpiringChip({super.key, required this.expiryDate});
  final DateTime expiryDate;

  @override
  Widget build(BuildContext context) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    final isExpired = daysUntilExpiry < 0;
    final isExpiringSoon = daysUntilExpiry >= 0 && daysUntilExpiry <= 30;

    Color statusColor;

    if (isExpired) {
      statusColor = const Color(0xFFFF6B6B);
    } else if (isExpiringSoon) {
      statusColor = const Color(0xFFFF9F1C);
    } else {
      statusColor = const Color(0xFF5ECCC4);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isExpired ? '過期 ${daysUntilExpiry.abs()} 天' : '有效期還有 $daysUntilExpiry 天',
        style: TextStyle(
          fontSize: 12,
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
