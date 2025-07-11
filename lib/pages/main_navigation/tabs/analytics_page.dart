import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/services/analytics_service/analytics_service.dart';
import 'package:beauty_tracker/util/analytics.dart';
import 'package:beauty_tracker/util/date.dart';
import 'package:beauty_tracker/widgets/analytics/brand_rank.dart';
import 'package:beauty_tracker/widgets/analytics/spending_bar_chart.dart';
import 'package:beauty_tracker/widgets/analytics/status_progress_chart.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/chip/text_chip.dart';
import 'package:beauty_tracker/widgets/common/sub_title_bar.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class AnalyticsPage extends HookWidget {
  const AnalyticsPage({super.key});

  List<BrandRankData> get brandRankList => [
        BrandRankData(name: 'Brand A', count: 10, spending: 500),
        BrandRankData(name: 'Brand B', count: 8, spending: 300),
        BrandRankData(name: 'Brand C', count: 5, spending: 200),
        BrandRankData(name: 'Brand D', count: 3, spending: 100),
        BrandRankData(name: 'Brand E', count: 2, spending: 50),
        BrandRankData(name: 'Brand F', count: 1, spending: 30),
      ];

  @override
  Widget build(BuildContext context) {
    final analyticsService = useDi<AnalyticsService>();

    final statusResult = useServiceData(() => analyticsService.getProductStatusData());
    final monthlyExpensesResult = useServiceData(() => analyticsService.getMonthlyExpenses(
          startMonth: getMonthsAgoFirstDay(5),
          endMonth: DateTime.now(),
        ));

    final statusList = useMemoized(() {
      if (statusResult.hasError || !statusResult.hasData) {
        return <StatusProgressData>[];
      }

      return AnalyticsUtils.convertToStatusList(statusResult.data!);
    }, [statusResult.data]);

    final monthlyExpensesList = useMemoized(() {
      if (monthlyExpensesResult.hasError || !monthlyExpensesResult.hasData) {
        return <SpendingData>[];
      }

      return AnalyticsUtils.convertToSpendingList(monthlyExpensesResult.data!);
    }, [monthlyExpensesResult.data]);

    return PageScrollView(
      header: [AppTitleBar(title: '使用分析')],
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
                      spendingData: monthlyExpensesList,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SubTitleBar(title: '品牌偏好'),
              const SizedBox(height: 16),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: BrandRank(
                  brandRankData: brandRankList,
                  topCount: 4,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }
}
