// part of '../view.dart';

// // Define common fields
// final List<LeaveField> commonFields = [
//   LeaveField(
//     key: "leaveType",
//     label: "Leave Type",
//     type: FieldType.dropdown,
//     required: true /* provide options as needed */,
//     options: LeaveType.values, // Pass all enum values here
//     optionLabelBuilder: (dynamic option) =>
//         (option as LeaveType).displayName, // Use displayName property for label
//   ),
//   // LeaveField(
//   //   key: "leaveDuration",
//   //   label: "Leave Duration",
//   //   type: FieldType.text,
//   //   required: true,
//   // ),
//   LeaveField(
//     key: "startDate",
//     label: "Start Date",
//     type: FieldType.date,
//     required: true,
//   ),
//   LeaveField(
//     key: "endDate",
//     label: "End Date",
//     type: FieldType.date,
//     required: true,
//   ),
//   LeaveField(
//     key: "delegatedTo",
//     label: "Delegated To",
//     type: FieldType.text,
//     required: false,
//   ),
//   LeaveField(
//     key: "notes",
//     label: "Notes",
//     type: FieldType.text,
//     required: false,
//   ),
// ];

// final Map<LeaveType, List<LeaveField>> leaveTypeAdditionalFields = {
//   LeaveType.annualLeaveRequest: [
//     LeaveField(
//       key: "contactNumberDuringLeave",
//       label: "Contact Number During Leave",
//       type: FieldType.text,
//       required: true,
//     ),
//     LeaveField(
//       key: 'addressDuringLeave',
//       label: 'Address During Leave',
//       type: FieldType.text,
//     ),
//   ],

//   LeaveType.sickLeaveRequest: [],
//   LeaveType.accompanyLeavePatient: [
//     LeaveField(
//       key: 'escortInstancesPerYear',
//       label: 'Escort Instances Per Year',
//       type: FieldType.text,
//     ),
//     LeaveField(
//       key: 'accompanyingThePatient',
//       label: 'Accompanying the Patient',
//       type: FieldType.text,
//     ),
//     LeaveField(
//       key: 'treatmentPlace',
//       label: 'Treatment Place',
//       type: FieldType.text,
//     ),
//   ],

//   LeaveType.emergencyLeaveRequest: [
//     LeaveField(
//       key: 'emergencyLeavesAvailable',
//       label: 'Emergency Leaves Available',
//       type: FieldType.text,
//       required: true,
//     ),
//   ],

//   LeaveType.examinationLeaveRequest: [],
//   LeaveType.maternityLeaveRequest: [],
//   LeaveType.iddahLeaveRequest: [],
//   LeaveType.hajjLeaveRequest: [],

//   LeaveType.representSultanateLeaveRequest: [
//     LeaveField(
//       key: 'countryStateBeingVisited',
//       label: 'Country / State  being Visited',
//       type: FieldType.text,
//       required: true,
//     ),
//     LeaveField(
//       key: 'leaveBalanceSummary',
//       label: 'Leave Balance Summary',
//       type: FieldType.text,
//       required: true,
//     ),
//     LeaveField(
//       key: 'representation',
//       label: 'Representation',
//       type: FieldType.text,
//       required: true,
//     ),
//     LeaveField(
//       key: 'activityTitle',
//       label: 'Activity Title',
//       type: FieldType.text,
//       required: true,
//     ),
//   ],

//   LeaveType.studyLeaveRequest: [],

//   LeaveType.unpaidLeave: [
//     LeaveField(
//       key: 'unpaidLeaveType',
//       label: 'Unpaid Leave Type',
//       type: FieldType.text,
//       required: true,
//     ),
//     LeaveField(
//       key: 'remainingLeaveBalance',
//       label: 'Remaining Leave Balance',
//       type: FieldType.text,
//       required: true,
//     ),
//   ],

//   LeaveType.mourningLeave: [],

//   LeaveType.returnNotification: [],

//   LeaveType.extensionRequest: [],

//   LeaveType.cancellation: [],
// };
