part of '../view.dart';

class EmployeeInfo {
  final String requestId;
  final String employeeId;
  final String jobTitle;
  final String email;
  final String department;
  final String contactNumber;
  final String leaveType;

  EmployeeInfo({
    required this.requestId,
    required this.employeeId,
    required this.jobTitle,
    required this.email,
    required this.department,
    required this.contactNumber,
    required this.leaveType,
  });
}
