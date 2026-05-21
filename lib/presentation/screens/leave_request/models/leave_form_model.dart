// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum FieldType { text, date, dropdown }

// // enum LeaveType {
// //   annualLeaveRequest("Annual Leave Request"),
// //   sickLeaveRequest("Sick Leave Request"),
// //   accompanyLeavePatient("Accompany Leave Request - Patient Accompany"),
// //   emergencyLeaveRequest("Emergency Leave Request"),
// //   examinationLeaveRequest("Examination Leave Request"),
// //   maternityLeaveRequest("Maternity Leave Request"),
// //   iddahLeaveRequest("Iddah Leave Request"),
// //   hajjLeaveRequest("Hajj Leave Request"),
// //   representSultanateLeaveRequest(
// //     "Request for Leave to Represent the Sultanate",
// //   ),
// //   studyLeaveRequest("Study Leave Request"),
// //   unpaidLeave("Unpaid Leave"),
// //   mourningLeave("Mourning Leave"),
// //   returnNotification("Return Notification"),
// //   extensionRequest("Extension Request"),
// //   cancellation("Cancellation");

// //   final String displayName;
// //   const LeaveType(this.displayName);
// // }

// class LeaveField {
//   final String key;
//   final String label;
//   final FieldType type;
//   final bool required;
//   List<dynamic>? options; // Populated later for API dropdowns
//   final String Function(dynamic)? optionLabelBuilder;
//   final bool isDynamic; // true if should fetch from API
//   final FutureProvider<List<dynamic>>? optionsProvider; // For API dropdowns

//   LeaveField({
//     required this.key,
//     required this.label,
//     required this.type,
//     this.required = false,
//     this.options,
//     this.optionLabelBuilder,
//     this.isDynamic = false,
//     this.optionsProvider,
//   });
// }

// class LeaveForm {
//   final LeaveType leaveType;
//   final List<LeaveField> fields; // Do NOT include common fields here

//   LeaveForm({required this.leaveType, required this.fields});
// }
