part of '../view.dart';

class LeaveFormWidget extends ConsumerWidget {
  final DynamicLeaveFormParams params;

  // final _ViewState state;
  // final _VSController stateController;
  const LeaveFormWidget({
    super.key,
    // required this.state,
    // required this.stateController,
    required this.params,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateController = ref.read(
      dynamicLeaveFormControllerProvider(params).notifier,
    );
    final state = ref.watch(dynamicLeaveFormControllerProvider(params));

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final isCancellation = stateController.isCancellationLeaveType(
      state.selectedLeaveType,
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),

      child: SingleChildScrollView(
        child: Form(
          key: stateController.formKey,

          child: Column(
            children: [
              LeaveRequestHeader(
                onClose: () {
                  stateController.onPressSubmitClearFormFields();
                },
              ),
              KDropdownField<LeaveTypeItem>(
                value: null,
                fieldHeadingText: 'Leave Type *',
                hintText: 'Select Leave Type',

                items:
                    state.leaveTypeList
                        .map<KDropdownItem<LeaveTypeItem>>(
                          (opt) => KDropdownItem<LeaveTypeItem>(
                            value: opt,
                            child: Text(opt.name ?? ''),
                          ),
                        )
                        .toList(),

                // errorText: state.selectedBankName.id != null
                //     ? null
                //     : 'Please select a bank',
                onChanged: (v) {
                  if (v != null) {
                    stateController.onSelectLeaveType(v);
                  }
                },
              ),
              if (isCancellation)
                KDropdownField<MyLeaveRequestItem>(
                  value: state.selectedApprovedLeave.id != null
                      ? state.selectedApprovedLeave
                      : null,
                  fieldHeadingText: 'Approved Leave Type *',
                  hintText: 'Select Approved Leave Type',
                  items: stateController.approvedLeavesForCancellation
                      .map<KDropdownItem<MyLeaveRequestItem>>(
                        (opt) => KDropdownItem<MyLeaveRequestItem>(
                          value: opt,
                          child: Text(
                            stateController.approvedLeaveDropdownLabel(opt),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      stateController.onSelectApprovedLeave(v);
                    }
                  },
                ),
              if (state.selectedLeaveType.id == 11 && !isCancellation)
                KDropdownField<UnpaidLeaveCategoryItem>(
                  value: null,
                  fieldHeadingText: 'Unpaid Leave Type *',
                  hintText: 'Select Unpaid Leave Type',

                  items:
                      state.unpaidLeaveCategories
                          .map<KDropdownItem<UnpaidLeaveCategoryItem>>(
                            (opt) => KDropdownItem<UnpaidLeaveCategoryItem>(
                              value: opt,
                              child: Text(opt.unpaidLeaveCategory ?? ''),
                            ),
                          )
                          .toList(),

                  // errorText: state.selectedBankName.id != null
                  //     ? null
                  //     : 'Please select a bank',
                  onChanged: (v) {
                    if (v != null) {
                      stateController.onSelectUnpaidLeaveCategory(v);
                    }
                  },
                ),
              if (state.selectedLeaveType.id == 12 && !isCancellation)
                KDropdownField<MourningLeaveRelationItem>(
                  value: null,
                  fieldHeadingText: 'RelationShip *',
                  hintText: 'Select relationship',

                  items:
                      state.mourningLeaveRelations
                          .map<KDropdownItem<MourningLeaveRelationItem>>(
                            (opt) => KDropdownItem<MourningLeaveRelationItem>(
                              value: opt,
                              child: Text(opt.mourningLeaveRelation ?? ''),
                            ),
                          )
                          .toList(),

                  // errorText: state.selectedBankName.id != null
                  //     ? null
                  //     : 'Please select a bank',
                  onChanged: (v) {
                    if (v != null) {
                      stateController.onSelectMourningLeaveRelation(v);
                    }
                  },
                ),
              if (!isCancellation &&
                  (state.selectedLeaveType.id == 2 ||
                      state.selectedLeaveType.id == 7))
                KRadioGroup<String>(
                  title: 'Leave For',
                  isRequired: true,
                  options: const [
                    KRadioOption(value: 'Self', label: 'Self'),
                    KRadioOption(value: 'Behalf of', label: 'Behalf of'),
                  ],
                  selectedValue: state.leaveFor,
                  onChanged: (val) => stateController.onSelectLeaveFor(val),
                ),

              if (state.leaveFor == 'Behalf of')
                KDropdownField<BehalfOfUserItem>(
                  value: null,
                  fieldHeadingText: 'Select User *',
                  hintText: 'Select User',

                  items:
                      state.behalfOfUsers
                          .map<KDropdownItem<BehalfOfUserItem>>(
                            (opt) => KDropdownItem<BehalfOfUserItem>(
                              value: opt,
                              child: Text(opt.employeeName ?? ''),
                            ),
                          )
                          .toList(),

                  // errorText: state.selectedBankName.id != null
                  //     ? null
                  //     : 'Please select a bank',
                  onChanged: (v) {
                    if (v != null) {
                      stateController.onSelectBehalfOfUser(v);
                    }
                  },
                ),

              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  controller: stateController.startDateController,
                  fieldHeadingText: 'Start Date *',
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  onTap: isCancellation
                      ? null
                      : stateController.onPressSelectStartDate,
                  validator: (value) => (value == null || value.isEmpty
                      ? 'Please select date'
                      : null),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  controller: stateController.endDateController,
                  fieldHeadingText: 'End Date *',
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  onTap: isCancellation
                      ? null
                      : stateController.onPressSelectEndDate,
                  validator: (value) => (value == null || value.isEmpty
                      ? 'Please select date'
                      : null),
                ),
              ),
              if (isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Select Duration *',
                    hintText: '0',
                    controller: stateController.selectDurationController,
                    readOnly: true,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please select an approved leave'
                        : null),
                  ),
                ),
              if (isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Employee Name *',
                    controller: stateController.employeeNameController,
                    readOnly: true,
                  ),
                ),
              if (isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'department *',
                    controller: stateController.departmentController,
                    readOnly: true,
                  ),
                ),
              if (isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Reason for Cancellation *',
                    hintText: 'Enter reason for cancellation',
                    controller: stateController.reasonForCancellationController,
                    maxLines: 4,
                    validator: (value) => (value == null || value.trim().isEmpty
                        ? 'Please enter reason for cancellation'
                        : null),
                  ),
                ),
              if (!isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Leave Balances *',
                    initialValue: '${state.availableLeaveBalance} Days',
                    readOnly: true,
                    hintText: '0 Days',
                  ),
                ),

              if (!isCancellation && state.selectedLeaveType.id == 9)
                KRadioGroup<String>(
                  title: 'Representation',
                  isRequired: true,
                  options: const [
                    KRadioOption(value: 'Inside', label: 'Inside'),
                    KRadioOption(value: 'Outside', label: 'Outside'),
                  ],
                  selectedValue: state.leaveFor,
                  onChanged: (val) => stateController.onSelectLeaveFor(val),
                ),

              if (!isCancellation && state.selectedLeaveType.id == 9)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Activity Title *',
                    hintText: 'Enter here...',
                    controller:
                        stateController.contactNumberDuringLeaveController,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please enter activity title'
                        : null),
                  ),
                ),

              // add country dropdown
              if (!isCancellation && state.selectedLeaveType.id == 9)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Country or State being visited *',
                    hintText: 'Enter here...',
                    controller:
                        stateController.contactNumberDuringLeaveController,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please enter country or state name'
                        : null),
                  ),
                ),

              if (!isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Contact Number During Leave *',
                    hintText: 'Enter here...',
                    controller:
                        stateController.contactNumberDuringLeaveController,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please enter contact number during leave'
                        : null),
                  ),
                ),
              if (!isCancellation && state.selectedLeaveType.id == 3)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Treatment Place *',
                    hintText: 'Enter here...',
                    controller: stateController.addressDuringLeaveController,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please enter treatment place'
                        : null),
                  ),
                ),

              if (!isCancellation)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                  child: KTextField(
                    fieldHeadingText: 'Address During Leave *',
                    hintText: 'Enter here...',
                    controller: stateController.addressDuringLeaveController,
                    validator: (value) => (value == null || value.isEmpty
                        ? 'Please enter address during leave'
                        : null),
                  ),
                ),

              if (isCancellation)
                FileUploadWidget(
                  onUploadSuccess: (url) {
                    stateController.onUploadFileSuccess(url);
                  },
                  onDelete: (index) {
                    stateController.onRemoveFile(index);
                  },
                ),

              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: isCancellation
                      ? 'Comments(Optional)'
                      : 'Comments',
                  hintText: isCancellation
                      ? 'Enter Comments...'
                      : 'Enter here...',
                  controller: stateController.notesController,
                  validator: isCancellation
                      ? null
                      : (value) => (value == null || value.isEmpty
                          ? 'Please enter note'
                          : null),
                ),
              ),

              if (!isCancellation)
                FileUploadWidget(
                  onUploadSuccess: (url) {
                    stateController.onUploadFileSuccess(url);
                  },
                  onDelete: (index) {
                    stateController.onRemoveFile(index);
                  },
                ),

              20.toVerticalSizedBox,

              SizedBox(
                // width: double.infinity,
                width: 392.toAutoScaledWidth,
                child: KTextActionButton(
                  text: Text(
                    AppLocalizations.of(context)!.submit,
                    style: TextStyle(
                      color: currentTheme.colors.onPrimary,
                      fontSize: currentTheme.fontSizes.s16,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                  onPressed: () {
                    stateController.onPressSubmitLeaveRequest();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveRequestHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const LeaveRequestHeader({
    super.key,
    this.title = "New Leave Request",
    this.subtitle = "Provide details about your New Request",
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: currentTheme.fontSizes.s16,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 22),
                onPressed: onClose ?? () => Navigator.of(context).maybePop(),
                splashRadius: 24,
                tooltip: "Close",
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s12,
              color: Color(0xFFB0B1B6),
              fontWeight: FontWeight.w500,
            ),
          ),
          // Decorative line
          const Padding(
            padding: EdgeInsets.only(top: 13),
            child: Divider(height: 2, thickness: 1, color: Color(0xFFE5EAEB)),
          ),
        ],
      ),
    );
  }
}
