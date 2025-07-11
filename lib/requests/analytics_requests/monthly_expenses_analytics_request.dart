class MonthlyExpensesAnalyticsRequest {
  MonthlyExpensesAnalyticsRequest({
    required this.year,
    required this.month,
    required this.amount,
    required this.productCount,
  });

  factory MonthlyExpensesAnalyticsRequest.fromJson(Map<String, dynamic> json) {
    return MonthlyExpensesAnalyticsRequest(
      year: json['year'] as int,
      month: json['month'] as int,
      amount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      productCount: json['product_count'] as int? ?? 0,
    );
  }

  final int year;
  final int month;
  final double amount;
  final int productCount;
}
