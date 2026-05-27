int? _readBalanceInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class LeaveUserBalanceModel {
  final String? status;
  final String? message;
  final List<LeaveUserBalanceItem>? data;

  LeaveUserBalanceModel({this.status, this.message, this.data});

  factory LeaveUserBalanceModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<LeaveUserBalanceItem>? items;

    if (rawData is List) {
      items = rawData
          .map((e) => LeaveUserBalanceItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      final nested = rawData['balances'] ?? rawData['leave_balances'];
      if (nested is List) {
        items = nested
            .map(
              (e) => LeaveUserBalanceItem.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
    }

    return LeaveUserBalanceModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: items,
    );
  }
}

class LeaveUserBalanceItem {
  final String? leaveTypeName;
  final int? used;
  final int? total;

  LeaveUserBalanceItem({this.leaveTypeName, this.used, this.total});

  factory LeaveUserBalanceItem.fromJson(Map<String, dynamic> json) {
    final leaveType = json['leave_type'];
    String? typeName;
    if (leaveType is Map<String, dynamic>) {
      typeName = leaveType['name'] as String?;
    }

    return LeaveUserBalanceItem(
      leaveTypeName:
          json['leave_type_name'] as String? ??
          json['name'] as String? ??
          typeName ??
          json['title'] as String?,
      used: _readBalanceInt(
        json['used'] ?? json['used_days'] ?? json['consumed'] ?? json['taken'],
      ),
      total: _readBalanceInt(
        json['total'] ??
            json['total_days'] ??
            json['allocated'] ??
            json['annual_leave'] ??
            json['entitled'],
      ),
    );
  }
}
