part of '../view.dart';

class TelephoneDirectoryForm extends ConsumerWidget {
  // final _ViewState state;
  // final _VSController stateController;
  const TelephoneDirectoryForm({
    super.key,
    // required this.state,
    // required this.stateController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateController = ref.read(_vsProvider.notifier);
    final state = ref.watch(_vsProvider);

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
              TelephoneDirectoryHeader(
                onClose: () {
                  // stateController.onPressSubmitClearFormFields();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Person Name *',
                  hintText: 'Enter here...',
                  controller: stateController.personNameController,
                  validator: (value) => (value == null || value.isEmpty
                      ? 'Please enter person name'
                      : null),
                ),
              ),

              KDropdownField<DepartmentItem>(
                value: null,
                fieldHeadingText: 'Department',
                hintText: 'Select Department',

                items:
                    state.departmentCategories.fm
                        ?.map<KDropdownItem<DepartmentItem>>(
                          (opt) => KDropdownItem<DepartmentItem>(
                            value: opt,
                            child: Text(opt.name ?? ''),
                          ),
                        )
                        .toList() ??
                    [],

                // errorText: state.selectedBankName.id != null
                //     ? null
                //     : 'Please select a bank',
                onChanged: (v) {
                  if (v != null) {
                    stateController.onSelectDepartmentItemInForm(v);
                  }
                },
              ),
              KDropdownField<String>(
                value: null,
                fieldHeadingText: 'Position/ Title *',
                hintText: 'Select Position/ Title',

                items:
                    stateController.positionList
                        ?.map<KDropdownItem<String>>(
                          (opt) => KDropdownItem<String>(
                            value: opt,
                            child: Text(opt),
                          ),
                        )
                        .toList() ??
                    [],

                // errorText: state.selectedBankName.id != null
                //     ? null
                //     : 'Please select a bank',
                onChanged: (v) {
                  if (v != null) {
                    stateController.onSelectPosition(v);
                  }
                },
              ),
              KDropdownField<String>(
                value: null,
                fieldHeadingText: 'Diplomatic Title *',
                hintText: 'Select Diplomatic Title',

                items: stateController.diplomaticTitleList
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
                    stateController.onSelectDiplomaticTitle(v);
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Email Adddress',
                  hintText: 'Enter Email Address',
                  controller: stateController.emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Extension Number *',
                  hintText: 'Enter Extension Number',
                  controller: stateController.extensionNmuberController,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Contextual Search *',
                  hintText: 'Ex. FM0123',
                  controller: stateController.contextualSearchController,
                  validator: (value) => (value == null || value.isEmpty
                      ? 'Please enter problem'
                      : null),
                ),
              ),

              KDropdownField<String>(
                value: null,
                fieldHeadingText: 'Mission *',
                hintText: 'Select Embassy',

                items: stateController.diplomaticTitleList
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
                    stateController.onSelectMission(v);
                  }
                },
              ),
              KDropdownField<String>(
                value: null,
                fieldHeadingText: 'Consulate *',
                hintText: 'Select Consulate',

                items: stateController.diplomaticTitleList
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
                    stateController.onSelectMission(v);
                  }
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

class TelephoneDirectoryHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const TelephoneDirectoryHeader({
    super.key,
    this.title = "New Ticket",
    this.subtitle = "Provide details about your Telephone Directory",
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
