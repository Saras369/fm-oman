class HelpDeskIssueTypeModel {
  final bool? success;
  final String? message;
  final List<HelpDeskIssueTypeItem>? data;

  HelpDeskIssueTypeModel({this.success, this.message, this.data});

  factory HelpDeskIssueTypeModel.fromJson(Map<String, dynamic> json) {
    return HelpDeskIssueTypeModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map(
            (e) => HelpDeskIssueTypeItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class HelpDeskIssueTypeItem {
  final int? id;
  final String? name;
  final String? description;
  final int? priority;
  final bool? isActive;

  HelpDeskIssueTypeItem({
    this.id,
    this.name,
    this.description,
    this.priority,
    this.isActive,
  });

  factory HelpDeskIssueTypeItem.fromJson(Map<String, dynamic> json) {
    return HelpDeskIssueTypeItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
      isActive: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority,
      'is_active': isActive,
    };
  }
}
