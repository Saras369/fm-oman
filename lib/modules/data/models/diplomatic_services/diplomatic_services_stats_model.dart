class DiplomaticServicesStatsModel {
  final bool? success;
  final String? message;
  final DiplomaticServicesStatsData? data;

  DiplomaticServicesStatsModel({this.success, this.message, this.data});

  factory DiplomaticServicesStatsModel.fromJson(Map<String, dynamic> json) {
    return DiplomaticServicesStatsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DiplomaticServicesStatsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class DiplomaticServicesStatsData {
  final int? total;
  final int? pending;
  final int? rejected;
  final int? completed;

  DiplomaticServicesStatsData({
    this.total,
    this.pending,
    this.rejected,
    this.completed,
  });

  factory DiplomaticServicesStatsData.fromJson(Map<String, dynamic> json) {
    return DiplomaticServicesStatsData(
      total: json['total_requests'] as int?,
      pending: json['pending'] as int?,
      rejected: json['rejected'] as int?,
      completed: json['approved'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_requests': total,
    'pending': pending,
    'rejected': rejected,
    'approved': completed,
  };
}
