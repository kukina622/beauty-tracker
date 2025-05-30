import 'package:flutter/material.dart';

class SpendingData {
  SpendingData({required this.month, required this.amount});
  final DateTime month;
  final int amount;
}

class SpendingBarChart extends StatelessWidget {
  const SpendingBarChart({
    super.key,
    this.spendingData = const [],
    this.height = 200,
  });
  final List<SpendingData> spendingData;
  final double height;

  int get maxAmount {
    if (spendingData.isEmpty) {
      return 0;
    }
    return spendingData.map((data) => data.amount).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: spendingData.map((data) {
          final amount = data.amount;
          final barHeight = (amount / maxAmount) * (height * 0.7);

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\$$amount',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 30,
                height: barHeight,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${data.month.month}月',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
