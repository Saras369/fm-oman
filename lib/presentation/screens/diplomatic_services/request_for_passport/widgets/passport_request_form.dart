part of '../view.dart';

class PassportRequestForm extends ConsumerWidget {
  final _VSControllerParams params;

  // final _ViewState state;
  // final _VSController stateController;
  const PassportRequestForm({
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
              PassportRequestHeader(
                onClose: () {
                  // stateController.onPressSubmitClearFormFields();
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Request Number for Official Use *',
                  hintText: 'Enter Request Number for Official Use',
                  controller: stateController.officialUseNumberController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Passport Type *',
                  hintText: 'Enter Passport Type',
                  controller: stateController.passportTypeController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Applicant Civil ID *',
                  hintText: 'Enter Applicant Civil ID',
                  controller: stateController.applicantCivilIdController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Applicant Name *',
                  hintText: 'Enter Applicant Name',
                  controller: stateController.applicantNameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Applicant Passport Number *',
                  hintText: 'Enter Applicant Passport Number',
                  controller: stateController.applicantPassportNumberController,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Application For *',
                  hintText: 'Application For',
                  controller: stateController.applicantCivilIdController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Application Type *',
                  hintText: 'Enter Application Type',
                  controller: stateController.applicantTypeController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Application Job / Occupation *',
                  hintText: 'Enter',
                  controller: stateController.occupationController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Purpose of Application *',
                  hintText: 'Enter',
                  controller: stateController.purposeOfApplicationController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
                child: KTextField(
                  fieldHeadingText: 'Approved Mission Travel ID *',
                  hintText: 'Enter Approved Mission Travel ID',
                  controller:
                      stateController.approvedMissionTravellerIDController,
                ),
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

class PassportRequestHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const PassportRequestHeader({
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
