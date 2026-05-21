part of '../view.dart';

class TransferToMissionRequestForm extends ConsumerWidget {
  final _VSControllerParams params;

  // final _ViewState state;
  // final _VSController stateController;
  const TransferToMissionRequestForm({
    super.key,
    // required this.state,
    // required this.stateController,
    required this.params,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateController = ref.read(_vsProvider(params).notifier);
    final state = ref.watch(_vsProvider(params));

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Padding(
      padding: const EdgeInsets.all(12.0),

      child: SingleChildScrollView(
        child: Form(
          key: stateController.formKey,

          child: Column(
            children: [
              TransferToMissionRequestHeader(
                onClose: () {
                  // stateController.onPressSubmitClearFormFields();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  controller: stateController.requestPrepationDateController,
                  fieldHeadingText: 'Start Date *',
                  hintText: 'DD/MM/YYYY',
                  readOnly: true,
                  onTap: stateController.onPressRequestPreparationDate,
                  validator: (value) => (value == null || value.isEmpty
                      ? 'Please select date'
                      : null),
                ),
              ),

              // KDropdownField<HelpDeskCategoryItem>(
              //   value: null,
              //   fieldHeadingText: 'Category Type *',
              //   hintText: 'Select service Type',

              //   items:
              //       state.categories
              //           ?.map<KDropdownItem<HelpDeskCategoryItem>>(
              //             (opt) => KDropdownItem<HelpDeskCategoryItem>(
              //               value: opt,
              //               child: Text(opt.name ?? ''),
              //             ),
              //           )
              //           .toList() ??
              //       [],

              //   // errorText: state.selectedBankName.id != null
              //   //     ? null
              //   //     : 'Please select a bank',
              //   onChanged: (v) {
              //     if (v != null) {
              //       stateController.onSelectCategory(v);
              //     }
              //   },
              // ),
              KDropdownField<StationeryMaterialItem>(
                value: null,
                fieldHeadingText: 'Material Type *',
                hintText: 'Select service Type',

                items:
                    state.materials
                        ?.map<KDropdownItem<StationeryMaterialItem>>(
                          (opt) => KDropdownItem<StationeryMaterialItem>(
                            value: opt,
                            child: Text(opt.materialName ?? ''),
                          ),
                        )
                        .toList() ??
                    [],

                // errorText: state.selectedBankName.id != null
                //     ? null
                //     : 'Please select a bank',
                onChanged: (v) {
                  if (v != null) {
                    // stateController.onSelectStationeryMaterial(v);
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Material Name',
                  hintText: 'Enter material name',
                  controller: stateController.materialNameController,
                ),
              ),

              KDropdownField<String>(
                value: null,
                fieldHeadingText: 'Priority Type *',
                hintText: 'Select priority Type',

                items: stateController.priorityType
                    .map<KDropdownItem<String>>(
                      (opt) =>
                          KDropdownItem<String>(value: opt, child: Text(opt)),
                    )
                    .toList(),

                // errorText: state.selectedBankName.id != null
                //     ? null
                //     : 'Please select a bank',
                onChanged: (v) {
                  if (v != null) {
                    // stateController.onSelectUnpaidLeaveCategory(v);
                  }
                },
              ),

              FileUploadWidget(
                onUploadSuccess: (url) {
                  // stateController.onUploadFileSuccess(url);
                },
                onDelete: (index) {
                  // stateController.onRemoveFile(index);
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
                    // stateController.onPressSubmitLeaveRequest();
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

class TransferToMissionRequestHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const TransferToMissionRequestHeader({
    super.key,
    this.title = "New Ticket",
    this.subtitle = "Provide details about your New Ticket",
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
