class BankNameModel {
  final String? status;
  final String? message;
  final List<BankNameItem>? data;

  BankNameModel({this.status, this.message, this.data});

  factory BankNameModel.fromJson(Map<String, dynamic> json) {
    return BankNameModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => BankNameItem.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class BankNameItem {
  final int? id;
  final String? bankName;
  final String? bankCode;
  final String? country;
  final String? bankDescription;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  BankNameItem({
    this.id,
    this.bankName,
    this.bankCode,
    this.country,
    this.bankDescription,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory BankNameItem.fromJson(Map<String, dynamic> json) {
    return BankNameItem(
      id: json['id'] as int?,
      bankName: json['bank_name'] as String?,
      bankCode: json['bank_code'] as String?,
      country: json['country'] as String?,
      bankDescription: json['bank_description'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bank_name': bankName,
      'bank_code': bankCode,
      'country': country,
      'bank_description': bankDescription,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
