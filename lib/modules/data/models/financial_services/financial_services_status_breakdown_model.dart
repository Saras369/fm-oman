int? _readStatusInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class FinancialStatusBreakdownModel {
  final String? status;
  final String? message;
  final FinancialStatusBreakdownData? data;

  FinancialStatusBreakdownModel({this.status, this.message, this.data});

  factory FinancialStatusBreakdownModel.fromJson(Map<String, dynamic> json) {
    return FinancialStatusBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] is List
                ? ((json['data'] as List).isNotEmpty
                      ? FinancialStatusBreakdownData.fromJson(
                          (json['data'] as List).first,
                        )
                      : null)
                : FinancialStatusBreakdownData.fromJson(json['data']))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class FinancialStatusBreakdownData {
  final String? timePeriod;
  final int? totalRequests;
  final int? pending;
  final int? rejected;
  final int? completed;

  FinancialStatusBreakdownData({
    this.timePeriod,
    this.totalRequests,
    this.pending,
    this.rejected,
    this.completed,
  });

  factory FinancialStatusBreakdownData.fromJson(Map<String, dynamic> json) {
    return FinancialStatusBreakdownData(
      timePeriod: json['time_period'] as String?,
      totalRequests: _readStatusInt(json['total_requests'] ?? json['total']),
      pending: _readStatusInt(json['pending']),
      rejected: _readStatusInt(json['rejected']),
      completed: _readStatusInt(json['approved'] ?? json['completed']),
    );
  }

  Map<String, dynamic> toJson() => {
    'time_period': timePeriod,
    'total_requests': totalRequests,
    'pending': pending,
    'rejected': rejected,
    'approved': completed,
  };
}
