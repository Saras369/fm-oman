int? _readStatsInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class FinancialServicesStatsModel {
  final bool? success;
  final String? message;
  final FinancialServicesStatsData? data;

  FinancialServicesStatsModel({this.success, this.message, this.data});

  factory FinancialServicesStatsModel.fromJson(Map<String, dynamic> json) {
    return FinancialServicesStatsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? FinancialServicesStatsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class FinancialServicesStatsData {
  final int? total;
  final int? pending;
  final int? rejected;
  final int? completed;

  FinancialServicesStatsData({
    this.total,
    this.pending,
    this.rejected,
    this.completed,
  });

  factory FinancialServicesStatsData.fromJson(Map<String, dynamic> json) {
    return FinancialServicesStatsData(
      total: _readStatsInt(
        json['total'] ??
            json['total_requests'] ??
            json['total_assigned_to_me'] ??
            json['total_approvals'],
      ),
      pending: _readStatsInt(json['pending'] ?? json['pending_my_approval']),
      rejected: _readStatsInt(json['rejected'] ?? json['rejected_by_me']),
      completed: _readStatsInt(
        json['completed'] ?? json['approved'] ?? json['approved_by_me'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'pending': pending,
    'rejected': rejected,
    'completed': completed,
  };
}
