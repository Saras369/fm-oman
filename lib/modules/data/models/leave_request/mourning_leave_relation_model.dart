class MourningLeaveRelationModel {
  final String? status;
  final List<MourningLeaveRelationItem>? data;

  MourningLeaveRelationModel({this.status, this.data});

  factory MourningLeaveRelationModel.fromJson(Map<String, dynamic> json) {
    return MourningLeaveRelationModel(
      status: json['status'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) =>
                MourningLeaveRelationItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class MourningLeaveRelationItem {
  final String? createdBy;
  final String? updatedBy;
  final int? id;
  final String? mourningLeaveRelation;
  final String? createdAt;
  final String? updatedAt;

  MourningLeaveRelationItem({
    this.createdBy,
    this.updatedBy,
    this.id,
    this.mourningLeaveRelation,
    this.createdAt,
    this.updatedAt,
  });

  factory MourningLeaveRelationItem.fromJson(Map<String, dynamic> json) {
    return MourningLeaveRelationItem(
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      id: json['id'] as int?,
      mourningLeaveRelation: json['mounring_leave_relation'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'updated_by': updatedBy,
      'id': id,
      'mounring_leave_relation': mourningLeaveRelation,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
