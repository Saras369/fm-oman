int? _readTrendInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class FinancialServicesTrendBreakdownModel {
  final String? status;
  final String? message;
  final FinancialServicesTrendBreakdownData? data;

  FinancialServicesTrendBreakdownModel({this.status, this.message, this.data});

  factory FinancialServicesTrendBreakdownModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinancialServicesTrendBreakdownModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? FinancialServicesTrendBreakdownData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class FinancialServicesTrendBreakdownData {
  final List<FinancialServicesTrendBreakdownItem>? monthlyTrend;

  FinancialServicesTrendBreakdownData({this.monthlyTrend});

  factory FinancialServicesTrendBreakdownData.fromJson(
    Map<String, dynamic> json,
  ) {
    final listData = json['monthlyTrend'] ?? json['trend_data'];
    return FinancialServicesTrendBreakdownData(
      monthlyTrend: listData != null
          ? (listData as List)
                .map(
                  (e) => FinancialServicesTrendBreakdownItem.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'monthlyTrend': monthlyTrend?.map((e) => e.toJson()).toList(),
  };
}

class FinancialServicesTrendBreakdownItem {
  final String? month;
  final int? total;

  FinancialServicesTrendBreakdownItem({this.month, this.total});

  factory FinancialServicesTrendBreakdownItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinancialServicesTrendBreakdownItem(
      month: json['month'] as String?,
      total: _readTrendInt(json['total'] ?? json['count']),
    );
  }

  Map<String, dynamic> toJson() => {'month': month, 'total': total};
}
