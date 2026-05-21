part of '../view.dart';

class PayslipRequestForm extends ConsumerWidget {
  final String title;
  final _ViewState state;
  final _VSController stateController;
  const PayslipRequestForm({
    super.key,
    required this.title,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Form(
      key: stateController.formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PayslipRequestHeader(
                onClose: () => KAppX.router.pop(),
                title: title,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (title == 'Request for Payslip')
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.toAutoScaledHeight,
                            ),
                            child: KTextField(
                              controller: stateController.monthController,
                              fieldHeadingText: 'Select Month *',
                              hintText: 'Select',
                              readOnly: true,
                              onTap: stateController.onSelectMonth,
                              validator: (value) =>
                                  (value == null || value.isEmpty
                                  ? 'Please select month'
                                  : null),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.toAutoScaledHeight,
                            ),
                            child: KTextField(
                              controller: stateController.yearController,
                              fieldHeadingText: 'Select Year *',
                              hintText: 'Select',
                              readOnly: true,
                              onTap: stateController.onSelectMonth,
                              validator: (value) =>
                                  (value == null || value.isEmpty
                                  ? 'Please select year'
                                  : null),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 15.toAutoScaledHeight,
                            ),
                            child: KTextField(
                              fieldHeadingText: 'Reason for Payslip',
                              hintText: 'Enter here...',
                              controller: stateController.reasonController,
                            ),
                          ),
                        ],
                      ),

                    if (title == 'Request for Salary Certificate')
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                        child: KTextField(
                          fieldHeadingText: 'Reason for certificate *',
                          hintText: 'Enter here...',
                          controller: stateController.reasonController,
                          validator: (value) => (value == null || value.isEmpty
                              ? 'Please enter reason'
                              : null),
                        ),
                      ),
                    if (title == 'Request for Change of Bank Account')
                      ChangeBankAccountRequestForm(
                        state: state,
                        stateController: stateController,
                      ),
                    if (title == 'Request for Allowance')
                      AllownaceRequestForm(
                        state: state,
                        stateController: stateController,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                    stateController.onPressSubmit(title);
                    // final valid = controller.validate();
                    // if (valid) {
                    //   final values = controller.getValues();
                    //   showDialog(
                    //     context: context,
                    //     builder: (_) => AlertDialog(
                    //       title: Text(
                    //         AppLocalizations.of(context)!.submittedValues,
                    //       ),
                    //       content: SingleChildScrollView(
                    //         child: Text(
                    //           values.entries
                    //               .map((e) => "${e.key}: ${e.value}")
                    //               .join('\n'),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }
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

class PayslipRequestHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const PayslipRequestHeader({
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
                icon: const Icon(Icons.close, size: 20),
                onPressed: onClose ?? () => Navigator.of(context).maybePop(),
                splashRadius: 18,
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
