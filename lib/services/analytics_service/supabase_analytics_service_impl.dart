import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/requests/analytics_requests/brand_rank_analytics_request.dart';
import 'package:beauty_tracker/requests/analytics_requests/monthly_expenses_analytics_request.dart';
import 'package:beauty_tracker/requests/analytics_requests/product_status_analytics_request.dart';
import 'package:beauty_tracker/services/analytics_service/analytics_service.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAnalyticsServiceImpl implements AnalyticsService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<List<ProductStatusAnalyticsRequest>>> getProductStatusData() {
    return resultGuard(() async {
      final productStatusAnalyticsData = await supabase.rpc<List<Map<String, dynamic>>>(
          'get_product_status_stats',
          params: {'user_id': supabase.auth.currentUser?.id});

      return productStatusAnalyticsData
          .map((e) => ProductStatusAnalyticsRequest.fromJson(e))
          .toList();
    });
  }

  @override
  Future<Result<List<MonthlyExpensesAnalyticsRequest>>> getMonthlyExpenses(
      {DateTime? startMonth, DateTime? endMonth}) {
    return resultGuard(() async {
      final monthlyExpensesData = await supabase.rpc<List<Map<String, dynamic>>>(
        'get_monthly_expenses',
        params: {
          'user_id': supabase.auth.currentUser?.id,
          'start_year': startMonth?.year ?? DateTime.now().year,
          'start_month': startMonth?.month ?? DateTime.now().month,
          'end_year': endMonth?.year ?? DateTime.now().year,
          'end_month': endMonth?.month ?? DateTime.now().month,
        },
      );
      return monthlyExpensesData.map((e) => MonthlyExpensesAnalyticsRequest.fromJson(e)).toList();
    });
  }

  @override
  Future<Result<List<BrandRankAnalyticsRequest>>> getBrandRankList(
      {DateTime? startMonth, DateTime? endMonth}) async {
    return resultGuard(() async {
      final dateFormat = DateFormat('yyyy-MM-dd');

      final startDate = startMonth != null
          ? DateTime(startMonth.year, startMonth.month, 1)
          : DateTime(2000, 1, 1);

      final endDate = endMonth != null
          ? DateTime(endMonth.year, endMonth.month + 1, 0)
          : DateTime(2600, 12, 31);

      final brandRankData = await supabase.rpc<List<Map<String, dynamic>>>(
        'get_brand_stats',
        params: {
          'user_id': supabase.auth.currentUser?.id,
          'start_date': dateFormat.format(startDate),
          'end_date': dateFormat.format(endDate),
        },
      );
      return brandRankData.map((e) => BrandRankAnalyticsRequest.fromJson(e)).toList();
    });
  }
}
