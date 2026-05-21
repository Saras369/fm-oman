class TelephoneDesignationsModel {
  final bool? status;
  final List<TelephoneDesignationItem>? data;
  final int? totalCount;

  TelephoneDesignationsModel({this.status, this.data, this.totalCount});

  factory TelephoneDesignationsModel.fromJson(Map<String, dynamic> json) {
    return TelephoneDesignationsModel(
      status: json['status'],
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TelephoneDesignationItem.fromJson(e))
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

class TelephoneDesignationItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  TelephoneDesignationItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory TelephoneDesignationItem.fromJson(Map<String, dynamic> json) {
    return TelephoneDesignationItem(
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      id: json['id'],
      name: json['name'],
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
