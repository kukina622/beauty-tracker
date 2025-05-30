import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/analytics/spending_bar_chart.dart';
import 'package:beauty_tracker/widgets/analytics/status_progress_chart.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/chip/text_chip.dart';
import 'package:beauty_tracker/widgets/common/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/tabs/tab_page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  List<StatusProgressData> get statusList => [
        StatusProgressData(
          status: '正常使用',
          count: 18,
          color: const Color(0xFF5ECCC4),
        ),
        StatusProgressData(
          status: '即將過期',
          count: 3,
          color: const Color(0xFFFF9F1C),
        ),
        StatusProgressData(
          status: '已過期',
          count: 1,
          color: const Color(0xFFFF6B6B),
        ),
        StatusProgressData(
          status: '已用完',
          count: 2,
          color: const Color(0xFFBDBDBD),
        ),
      ];

  List<SpendingData> get spendingList => [
        SpendingData(DateTime(2023, 1), 120),
        SpendingData(DateTime(2023, 2), 150),
        SpendingData(DateTime(2023, 3), 90),
        SpendingData(DateTime(2023, 4), 200),
        SpendingData(DateTime(2023, 5), 180),
        SpendingData(DateTime(2023, 6), 220),
      ];

  @override
  Widget build(BuildContext context) {
    return TabPageScrollView(
      header: [AppTitleBar(title: 'Analytics')],
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SubTitleBar(title: '產品狀態'),
              const SizedBox(height: 16),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: StatusProgressChart(
                  statusData: statusList,
                ),
              ),
              const SizedBox(height: 32),
              SubTitleBar(title: '每月支出趨勢'),
              const SizedBox(height: 16),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextChip(
                      text: '過去6個月',
                      backgroundColor: Color(0xFF5ECCC4).withValues(alpha: .2),
                      textColor: Color(0xFF5ECCC4),
                    ),
                    SpendingBarChart(
                      spendingData: spendingList,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),
      ],
    );
  }
}
