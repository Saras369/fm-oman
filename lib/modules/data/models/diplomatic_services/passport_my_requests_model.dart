class PassportMyRequestsModel {
  final String status;
  final List<PassportMyRequestItem> data;
  final int totalCount;

  PassportMyRequestsModel({
    required this.status,
    required this.data,
    required this.totalCount,
  });

  factory PassportMyRequestsModel.fromJson(Map<String, dynamic> json) {
    return PassportMyRequestsModel(
      status: json['status'] ?? '',
      totalCount: json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PassportMyRequestItem.fromJson(e))
          .toList(),
    );
  }
}

class PassportMyRequestItem {
  final int id;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String applicationType;
  final String passportType;
  final String assignedTo;
  final String applicantName;
  final String applicationForType;

  PassportMyRequestItem({
    required this.id,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.applicationType,
    required this.passportType,
    required this.assignedTo,
    required this.applicantName,
    required this.applicationForType,
  });

  factory PassportMyRequestItem.fromJson(Map<String, dynamic> json) {
    String calculatedAssignedTo = 'N/A';

    if (json['approval_details'] != null && json['approval_details'] is List) {
      final approvals = json['approval_details'] as List;
      if (approvals.isNotEmpty) {
        var activeStep = approvals.firstWhere(
          (step) => step['approval_status'] == 'In Progress',
          orElse: () => approvals.first,
        );

        final user = activeStep['approver_user'];
        final role = activeStep['approver_role'];

        if (user != null && user['employee_name'] != null) {
          calculatedAssignedTo = user['employee_name'];
        } else if (role != null && role['name'] != null) {
          calculatedAssignedTo = role['name'];
        }
      }
    }

    return PassportMyRequestItem(
      id: json['id'] ?? 0,
      status: json['status'] ?? 'Unknown',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      applicationType: json['application_type'] ?? 'Unknown',
      passportType: json['passport_type'] ?? 'Unknown',
      applicantName: json['applicant_name'] ?? 'Unknown',
      assignedTo: calculatedAssignedTo,
      applicationForType: json['application_for_type'] ?? 'N/A',
    );
  }
}
