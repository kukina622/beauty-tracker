import 'package:flutter/material.dart';

class BrandRankData {
  BrandRankData({
    required this.name,
    required this.count,
    required this.spending,
  });
  final String name;
  final int count;
  final double spending;
}

class BrandRank extends StatelessWidget {
  const BrandRank({
    super.key,
    this.brandRankData = const [],
    this.topCount = 5,
  });

  final List<BrandRankData> brandRankData;
  final int topCount;

  List<BrandRankData> get sortedBrandRankData {
    return List.from(brandRankData)..sort((a, b) => b.spending.compareTo(a.spending));
  }

  @override
  Widget build(BuildContext context) {
    if (sortedBrandRankData.isEmpty) {
      return const Center(
        child: Text(
          '沒有品牌資料',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    final List<BrandRankData> displayData = sortedBrandRankData.take(topCount).toList();

    if (sortedBrandRankData.length > topCount) {
      final otherBrandRankData = sortedBrandRankData.skip(topCount).toList();
      final otherCount = otherBrandRankData.fold(0, (sum, item) => sum + item.count);
      final otherSpending = otherBrandRankData.fold(0.0, (sum, item) => sum + item.spending);
      displayData.add(BrandRankData(name: '其他', count: otherCount, spending: otherSpending));
    }

    return Column(
      children: displayData
          .map((brand) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9A9E).withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          brand.name.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF9A9E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brand.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          Text(
                            '${brand.count} 個產品',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${brand.spending}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        Text(
                          '總支出',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
