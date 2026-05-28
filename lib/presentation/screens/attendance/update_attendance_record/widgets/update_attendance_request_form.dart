part of '../view.dart';

class UpdateAttendanceRequestForm extends ConsumerWidget {
  const UpdateAttendanceRequestForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final stateController = ref.read(_vsProvider.notifier);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(10.toAutoScaledWidth),
      child: Form(
        key: stateController.formKey,
        child: Column(
          children: [
            LeaveRequestHeader(
              title: 'Update Request',
              subtitle: 'Provide details about your Update Request',
              onClose: () {
                stateController.onPressSubmitClearFormFields();
              },
            ),

            20.toVerticalSizedBox,
            KTextField(
              onTap: () {
                stateController.onPressFromDate(true);
              },
              controller: stateController.fromDateController,
              fieldHeadingText: '${l10n?.fromDate ?? ''} *',
              hintText: l10n?.fromDate ?? '',
              readOnly: true,
              validator: (value) => (value == null || value.isEmpty
                  ? 'Please select date'
                  : null),
            ),
            10.toVerticalSizedBox,
            KTextField(
              onTap: () {
                stateController.onPressFromDate(false);
              },
              controller: stateController.toDateController,
              fieldHeadingText: l10n?.toDate ?? '',
              hintText: l10n?.toDate ?? '',
              readOnly: true,
              validator: (value) => (value == null || value.isEmpty
                  ? 'Please select date'
                  : null),
            ),
            10.toVerticalSizedBox,
            KTextField(
              onTap: () {
                stateController.onPressTime(true);
              },
              controller: stateController.fromTimeController,
              readOnly: true,
              fieldHeadingText: '${l10n?.fromTime ?? ''} *',
              hintText: l10n?.fromTime ?? '',
              validator: (value) => (value == null || value.isEmpty
                  ? 'Please select time'
                  : null),
            ),
            10.toVerticalSizedBox,
            KTextField(
              onTap: () {
                stateController.onPressTime(false);
              },
              controller: stateController.toTimeController,
              readOnly: true,

              fieldHeadingText: '${l10n?.toTime ?? ''} *',
              hintText: l10n?.toTime ?? '',
              validator: (value) => (value == null || value.isEmpty
                  ? 'Please select time'
                  : null),
            ),
            10.toVerticalSizedBox,
            KTextField(
              controller: stateController.commentsController,
              fieldHeadingText: 'Comments *',
              hintText: 'Enter comments',
              maxLines: 2,
              validator: (value) => (value == null || value.trim().isEmpty
                  ? 'Please enter comments'
                  : null),
            ),
            10.toVerticalSizedBox,
            KRadioGroup<String>(
              title: '${l10n?.reason ?? 'Reason'} *',
              isRequired: true,
              options: const [
                KRadioOption(value: 'Meeting', label: 'Meeting'),
                KRadioOption(value: 'Early Checkout', label: 'Early Checkout'),
                KRadioOption(value: 'Special Reason', label: 'Special Reason'),
              ],
              selectedValue: state.selectedReason,
              onChanged: stateController.onSelectReason,
            ),
            50.toVerticalSizedBox,
            SizedBox(
              // width: double.infinity,
              width: 392.toAutoScaledWidth,
              child: KTextActionButton(
                text: Text(
                  AppLocalizations.of(context)!.update,
                  style: TextStyle(
                    color: currentTheme.colors.onPrimary,
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: currentTheme.fontWeights.wBolder,
                  ),
                ),
                onPressed: () {
                  stateController.onPressUpdateCreateAttendanceRequest();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
