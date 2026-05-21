class TelephoneEmbassyModel {
  final bool? status;
  final List<TelephoneEmbassyItem>? data;
  final int? totalCount;

  TelephoneEmbassyModel({this.status, this.data, this.totalCount});

  factory TelephoneEmbassyModel.fromJson(Map<String, dynamic> json) {
    return TelephoneEmbassyModel(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TelephoneEmbassyItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total_count': totalCount,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TelephoneEmbassyItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final String? nameInArabic;
  final String? region;
  final String? country;
  final String? location;
  final String? createdAt;
  final String? updatedAt;

  TelephoneEmbassyItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.nameInArabic,
    this.region,
    this.country,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory TelephoneEmbassyItem.fromJson(Map<String, dynamic> json) {
    return TelephoneEmbassyItem(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      name: json['name'],
      nameInArabic: json['name_in_arabic'],
      region: json['region'],
      country: json['country'],
      location: json['location'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'name': name,
      'name_in_arabic': nameInArabic,
      'region': region,
      'country': country,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
