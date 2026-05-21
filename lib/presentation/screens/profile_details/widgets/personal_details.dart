// part of '../view.dart';

// class PersonalDetailsWidget extends StatelessWidget {
//   const PersonalDetailsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<LeaveField> profileFields = [
//       LeaveField(
//         key: "name",
//         label: "Name",
//         type: FieldType.dropdown,
//         required: true /* provide options as needed */,
//         options: LeaveType.values, // Pass all enum values here
//         optionLabelBuilder: (dynamic option) => (option as LeaveType)
//             .displayName, // Use displayName property for label
//       ),
//       LeaveField(
//         key: "personalEmail",
//         label: "Personal Email",
//         type: FieldType.text,
//         required: true,
//       ),
//       LeaveField(
//         key: "mobileNumber",
//         label: "Mobile Number",
//         type: FieldType.date,
//         required: true,
//       ),
//       LeaveField(
//         key: "religion",
//         label: "Religion",
//         type: FieldType.date,
//         required: true,
//       ),
//       LeaveField(
//         key: "location",
//         label: "Location",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "country",
//         label: "Country",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "dateOfBirth",
//         label: "Date of Birth",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "Nationality",
//         label: "Nationality",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "bloodGroup",
//         label: "Blood Group₹",
//         type: FieldType.text,
//         required: false,
//       ),

//       LeaveField(
//         key: "maritalStatus",
//         label: "Marital Status₹",
//         type: FieldType.text,
//         required: false,
//       ),

//       LeaveField(
//         key: "address",
//         label: "Address",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "passportNumber",
//         label: "Passport Number",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "civilId",
//         label: "Civil Id",
//         type: FieldType.text,
//         required: false,
//       ),
//       LeaveField(
//         key: "education",
//         label: "Education",
//         type: FieldType.text,
//         required: false,
//       ),
//     ];

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           for (final field in profileFields) ...[
//             KTextField(
//               fieldHeadingText: field.label,
//               hintText: field.label,
//               // controller: state.controllers[field.key],  // Use map keyed by field.key
//               validator: field.required
//                   ? (val) => val == null || val.isEmpty
//                         ? 'Please enter ${field.label}'
//                         : null
//                   : null,
//               // onChanged: (v) => controller.setValue(field.key, v),
//               decoration: InputDecoration(
//                 // errorText: state.errors[field.key],
//               ),
//             ),
//             SizedBox(height: 16), // for spacing
//           ],
//         ],
//       ),
//     );
//   }
// }
