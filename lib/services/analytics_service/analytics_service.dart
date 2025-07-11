import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/requests/analytics_requests/product_status_analytics_request.dart';

abstract class AnalyticsService {
  Future<Result<List<ProductStatusAnalyticsRequest>>> getProductStatusData();
}
