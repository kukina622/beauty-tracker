import 'package:flutter/material.dart';

class StatusProgressData {
  StatusProgressData({
    required this.status,
    required this.count,
    required this.color,
  });
  final String status;
  final int count;
  final Color color;
}

class StatusProgressChart extends StatelessWidget {
  const StatusProgressChart({super.key, this.statusData = const []});
  final List<StatusProgressData> statusData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: statusData.map((status) {
        final count = status.count;
        final total = statusData.fold<int>(0, (sum, item) => sum + (item.count));
        final percentage = (count / total * 100).round();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: status.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        status.status,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$count 個 ($percentage%)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: count / total,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(status.color),
                minHeight: 6,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
