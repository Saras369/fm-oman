class CurrencyModel {
  final String? status;
  final int? total;
  final List<CurrencyItem>? data;

  CurrencyModel({this.status, this.total, this.data});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      status: json['status'] as String?,
      total: json['total'] as int?,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => CurrencyItem.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total': total,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CurrencyItem {
  final String? code;
  final String? name;
  final List<String>? countries;

  CurrencyItem({this.code, this.name, this.countries});

  factory CurrencyItem.fromJson(Map<String, dynamic> json) {
    return CurrencyItem(
      code: json['code'] as String?,
      name: json['name'] as String?,
      countries: json['countries'] != null
          ? List<String>.from(json['countries'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'countries': countries};
  }
}
