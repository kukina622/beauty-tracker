import 'package:beauty_tracker/widgets/common/chip/icon_chip.dart';
import 'package:flutter/material.dart';

class ExpiringSoonTile extends StatelessWidget {
  const ExpiringSoonTile({
    super.key,
    required this.expiringCount,
    this.onTap,
  });
  final int expiringCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconChip(
            size: 48,
            icon: Icons.access_time,
            backgroundColor: const Color(0xFFFF9A9E).withValues(alpha: .2),
            iconColor: Color(0xFFFF9A9E),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expiring Soon',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                      ),
                ),
                SizedBox(height: 4),
                Text(
                  '有$expiringCount件產品即將過期！',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9A9E).withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF9A9E),
              ),
            ),
          )
        ],
      ),
    );
  }
}
