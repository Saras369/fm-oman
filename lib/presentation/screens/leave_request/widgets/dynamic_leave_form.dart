// part of '../view.dart';

// class DynamicLeaveForm extends ConsumerWidget {
//   const DynamicLeaveForm({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.read(dynamicLeaveFormControllerProvider.notifier);
//     final state = ref.watch(dynamicLeaveFormControllerProvider);
//     final stateController = ref.read(
//       dynamicLeaveFormControllerProvider.notifier,
//     );

//     List<LeaveField> fields = controller.allFields;
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return Form(
//       key: controller.formKey,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               LeaveRequestHeader(onClose: () => KAppX.router.pop()),
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ...fields.map((field) {
//                       switch (field.type) {
//                         case FieldType.text:
//                           return Padding(
//                             padding: EdgeInsets.only(
//                               bottom: 15.toAutoScaledHeight,
//                             ),
//                             child: KTextField(
//                               fieldHeadingText: field.label,
//                               hintText: field.label,
//                               controller: state.controllers[field.key],
//                               validator: field.required
//                                   ? (val) => val == null || val.isEmpty
//                                         ? 'Please enter ${field.label}'
//                                         : null
//                                   : null,
//                               onChanged: (v) =>
//                                   controller.setValue(field.key, v),
//                               decoration: InputDecoration(
//                                 errorText: state.errors[field.key],
//                               ),
//                             ),
//                           );
//                         case FieldType.date:
//                           return Padding(
//                             padding: EdgeInsets.only(
//                               bottom: 15.toAutoScaledHeight,
//                             ),
//                             child: KTextField(
//                               controller: state.controllers[field.key],
//                               fieldHeadingText: field.label,
//                               hintText: field.label,
//                               readOnly: true,
//                               onTap: () async {
//                                 final pickedDate = await KAppX.extendedRouter
//                                     .showKDatePicker(
//                                       context: context,
//                                       initialDate:
//                                           state
//                                               .controllers[field.key]!
//                                               .text
//                                               .isNotEmpty
//                                           ? DateTime.tryParse(
//                                                   state
//                                                       .controllers[field.key]!
//                                                       .text,
//                                                 ) ??
//                                                 DateTime.now()
//                                           : DateTime.now(),
//                                       firstDate: DateTime(1900),
//                                       lastDate: DateTime(2100),
//                                     );
//                                 if (pickedDate != null) {
//                                   state.controllers[field.key]!.text =
//                                       pickedDate.toIso8601String().split(
//                                         'T',
//                                       )[0];
//                                 }
//                               },
//                               validator: field.required
//                                   ? (value) => (value == null || value.isEmpty)
//                                         ? 'Please select ${field.label}'
//                                         : null
//                                   : null,
//                             ),
//                           );

//                         case FieldType.dropdown:
//                           if (field.optionsProvider != null) {
//                             // Use unique provider per dropdown field
//                             final asyncOptions = ref.watch(
//                               field.optionsProvider!,
//                             );
//                             return asyncOptions.when(
//                               loading: () => const LinearProgressIndicator(),
//                               error: (e, st) => Text(
//                                 AppLocalizations.of(
//                                   context,
//                                 )!.failedToLoadOptions,
//                               ),
//                               data: (options) {
//                                 field.options = options;
//                                 return KDropdownField<dynamic>(
//                                   fieldHeadingText: field.label,
//                                   hintText: field.label,
//                                   value:
//                                       state
//                                               .controllers[field.key]
//                                               ?.text
//                                               .isNotEmpty ==
//                                           true
//                                       ? options.firstWhere(
//                                           (opt) =>
//                                               field.optionLabelBuilder!(opt) ==
//                                               state
//                                                   .controllers[field.key]
//                                                   ?.text,
//                                           orElse: () => null,
//                                         )
//                                       : null,
//                                   decoration: InputDecoration(
//                                     labelText: field.label,
//                                     errorText: state.errors[field.key],
//                                   ),
//                                   items: options
//                                       .map(
//                                         (opt) => KDropdownItem(
//                                           value: opt,
//                                           child: Text(
//                                             field.optionLabelBuilder!(opt),
//                                           ),
//                                         ),
//                                       )
//                                       .toList(),
//                                   onChanged: (v) {
//                                     final txt = field.optionLabelBuilder!(v);
//                                     controller.setValue(field.key, txt);
//                                     state.controllers[field.key]?.text = txt;
//                                   },
//                                 );
//                               },
//                             );
//                           } else {
//                             // Static options
//                             return KDropdownField<dynamic>(
//                               value: field.key == "leaveType"
//                                   ? state.selectedLeaveType
//                                   : state.controllers[field.key]?.text,
//                               fieldHeadingText: field.label,

//                               items:
//                                   field.options
//                                       ?.map<KDropdownItem<dynamic>>(
//                                         (opt) => KDropdownItem<dynamic>(
//                                           value: opt,
//                                           child: Text(
//                                             field.optionLabelBuilder != null
//                                                 ? field.optionLabelBuilder!(opt)
//                                                 : opt.toString(),
//                                           ),
//                                         ),
//                                       )
//                                       .toList() ??
//                                   [],

//                               decoration: InputDecoration(
//                                 labelText: field.label,
//                                 errorText: state.errors[field.key],
//                               ),
//                               onChanged: (v) {
//                                 if (field.key == "leaveType" &&
//                                     v is LeaveType) {
//                                   controller.updateLeaveType(v);
//                                   controller.setValue(field.key, v.displayName);
//                                 } else {
//                                   final txt = field.optionLabelBuilder != null
//                                       ? field.optionLabelBuilder!(v)
//                                       : v.toString();
//                                   controller.setValue(field.key, txt);
//                                   state.controllers[field.key]?.text = txt;
//                                 }
//                               },
//                             );
//                           }
//                       }
//                     }),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 // width: double.infinity,
//                 width: 392.toAutoScaledWidth,
//                 child: KTextActionButton(
//                   text: Text(
//                     AppLocalizations.of(context)!.submit,
//                     style: TextStyle(
//                       color: currentTheme.colors.onPrimary,
//                       fontSize: currentTheme.fontSizes.s16,
//                       fontWeight: currentTheme.fontWeights.wBolder,
//                     ),
//                   ),
//                   onPressed: () {
//                     stateController.onPressSubmitLeaveRequest();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LeaveRequestHeader extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final VoidCallback? onClose;

//   const LeaveRequestHeader({
//     super.key,
//     this.title = "New Leave Request",
//     this.subtitle = "Provide details about your New Request",
//     this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: currentTheme.fontSizes.s16,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close, size: 22),
//                 onPressed: onClose ?? () => Navigator.of(context).maybePop(),
//                 splashRadius: 24,
//                 tooltip: "Close",
//               ),
//             ],
//           ),
//           const SizedBox(height: 9),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: currentTheme.fontSizes.s12,
//               color: Color(0xFFB0B1B6),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           // Decorative line
//           const Padding(
//             padding: EdgeInsets.only(top: 13),
//             child: Divider(height: 2, thickness: 1, color: Color(0xFFE5EAEB)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
// // import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
// // import 'package:code_setup/presentation/screens/leave_request/models/leave_form_model.dart';
// // import 'package:code_setup/utils/app_extensions/app_extension.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class DynamicLeaveForm extends ConsumerStatefulWidget {
// //   final LeaveForm leaveForm;
// //   final Map<String, dynamic>? initialData;
// //   const DynamicLeaveForm({required this.leaveForm, this.initialData, Key? key})
// //     : super(key: key);

// //   @override
// //   ConsumerState<DynamicLeaveForm> createState() => _DynamicLeaveFormState();
// // }

// // class _DynamicLeaveFormState extends ConsumerState<DynamicLeaveForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   late Map<String, TextEditingController> controllers;
// //   late Map<String, dynamic> selectedDropdownItems;

// //   @override
// //   void initState() {
// //     super.initState();
// //     controllers = {
// //       for (var f in widget.leaveForm.fields) f.key: TextEditingController(),
// //     };
// //     selectedDropdownItems = {};
// //     if (widget.initialData != null) {
// //       widget.initialData!.forEach((key, value) {
// //         if (controllers.containsKey(key) && value != null) {
// //           controllers[key]!.text = value.toString();
// //         }
// //         final field = widget.leaveForm.fields.firstWhere(
// //           (f) => f.key == key,
// //           orElse: () => null as LeaveField, // ignore
// //         );
// //         if (field != null &&
// //             field.type == FieldType.dropdown &&
// //             value != null) {
// //           selectedDropdownItems[key] = value;
// //         }
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     controllers.values.forEach((c) => c.dispose());
// //     super.dispose();
// //   }

// //   Widget _buildField(LeaveField field) {
// //     switch (field.type) {
// //       case FieldType.text:
// //         return KTextField(
// //           fieldHeadingText: field.label,
// //           hintText: field.label,
// //           controller: controllers[field.key],
// //           validator: field.required
// //               ? (val) => val == null || val.isEmpty
// //                     ? 'Please enter ${field.label}'
// //                     : null
// //               : null,
// //         );
// //       case FieldType.date:
// //         // DateField(
// //         //   label: field.label,
// //         //   controller: controllers[field.key]!,
// //         //   validator: field.required ? (val) =>
// //         //       val == null || val.isEmpty ? 'Please select ${field.label}' : null
// //         //       : null,
// //         // );

// //         return KTextField(
// //           controller: controllers[field.key],
// //           fieldHeadingText: field.label,
// //           hintText: field.label,
// //           readOnly: true,
// //           onTap: () async {
// //             final pickedDate = await KAppX.extendedRouter.showKDatePicker(
// //               context: context,
// //               initialDate: controllers[field.key]!.text.isNotEmpty
// //                   ? DateTime.tryParse(controllers[field.key]!.text) ??
// //                         DateTime.now()
// //                   : DateTime.now(),
// //               firstDate: DateTime(1900),
// //               lastDate: DateTime(2100),
// //             );
// //             if (pickedDate != null) {
// //               controllers[field.key]!.text = pickedDate.toIso8601String().split(
// //                 'T',
// //               )[0];
// //               setState(() {}); // Update UI
// //             }
// //           },
// //           validator: field.required
// //               ? (value) => (value == null || value.isEmpty)
// //                     ? 'Please select ${field.label}'
// //                     : null
// //               : null,
// //         );

// //       case FieldType.dropdown:
// //         if (field.isDynamic) {
// //           final asyncOptions = ref.watch(relationshipOptionsProvider);
// //           return asyncOptions.when(
// //             loading: () => LinearProgressIndicator(),
// //             error: (e, st) => Text('Failed to load options'),
// //             data: (options) {
// //               field.options = options;
// //               return KDropdownField<dynamic>(
// //                 hintText: field.label,
// //                 fieldHeadingText: field.label,
// //                 decoration: InputDecoration(labelText: field.label),
// //                 value: selectedDropdownItems[field.key],
// //                 items: options
// //                     .map(
// //                       (opt) => KDropdownItem(
// //                         value: opt,
// //                         child: Text(
// //                           field.optionLabelBuilder != null
// //                               ? field.optionLabelBuilder!(opt)
// //                               : opt.toString(),
// //                         ),
// //                       ),
// //                     )
// //                     .toList(),
// //                 onChanged: (dynamic value) {
// //                   setState(() {
// //                     selectedDropdownItems[field.key] = value;
// //                     if (controllers.containsKey(field.key)) {
// //                       controllers[field.key]!.text = value?.toString() ?? '';
// //                     }
// //                   });
// //                 },
// //                 // validator: field.required ? (val) => val == null ? 'Please select ${field.label}' : null : null,
// //               );
// //             },
// //           );
// //         } else {
// //           return KDropdownField<dynamic>(
// //             fieldHeadingText: field.label,
// //             hintText: field.label,
// //             decoration: InputDecoration(
// //               labelText: field.label,
// //               labelStyle: TextStyle(color: Colors.black),
// //             ),
// //             value: selectedDropdownItems[field.key],
// //             items: field.options != null
// //                 ? field.options!
// //                       .map(
// //                         (opt) => KDropdownItem(
// //                           value: opt,
// //                           child: Text(
// //                             field.optionLabelBuilder != null
// //                                 ? field.optionLabelBuilder!(opt)
// //                                 : opt.toString(),
// //                           ),
// //                         ),
// //                       )
// //                       .toList()
// //                 : [],
// //             onChanged: (dynamic value) {
// //               setState(() {
// //                 selectedDropdownItems[field.key] = value;
// //                 controllers[field.key]!.text = value.toString();
// //               });
// //             },
// //             // validator: field.required
// //             //     ? (val) => val == null ? 'Please select ${field.label}' : null
// //             //     : null,
// //           );
// //         }
// //       default:
// //         return SizedBox.shrink();
// //     }
// //   }

// //   void _handleSubmit() {
// //     if (_formKey.currentState!.validate()) {
// //       final Map<String, dynamic> result = {};
// //       controllers.forEach((key, controller) {
// //         result[key] = controller.text;
// //       });
// //       selectedDropdownItems.forEach((key, value) {
// //         result[key] = value;
// //       });
// //       print('Form submitted for ${widget.leaveForm.leaveType}: $result');
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text('Form submitted successfully!')));
// //       // ...Send result to API or process further
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         children: [
// //           ...widget.leaveForm.fields.map(_buildField).toList(),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: _handleSubmit,
// //             child: Text('Submit ${widget.leaveForm.leaveType.displayName}'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // final relationshipOptionsProvider = FutureProvider<List<Map<String, dynamic>>>((
// //   ref,
// // ) async {
// //   return await fetchRelationshipsFromAPI();
// // });

// // // Replace this with your actual API fetch logic.
// // Future<List<Map<String, dynamic>>> fetchRelationshipsFromAPI() async {
// //   await Future.delayed(Duration(seconds: 2));
// //   // Example API result:
// //   return [
// //     {"id": 1, "name": "Parent"},
// //     {"id": 2, "name": "Sibling"},
// //     {"id": 3, "name": "Spouse"},
// //     {"id": 4, "name": "Child"},
// //   ];
// // }
