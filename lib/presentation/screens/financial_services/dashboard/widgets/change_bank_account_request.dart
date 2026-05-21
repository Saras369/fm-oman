part of '../view.dart';

class ChangeBankAccountRequestForm extends ConsumerWidget {
  final _ViewState state;
  final _VSController stateController;
  const ChangeBankAccountRequestForm({
    super.key,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Existing Bank Account Number *',
            hintText: 'Enter here...',
            controller: stateController.existingAccountNumController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter bank account number'
                : null),
          ),
        ),

        KDropdownField<dynamic>(
          value: null,
          fieldHeadingText: 'Existing Bank Name *',
          hintText: 'Select a bank',

          items:
              state.bankNames
                  ?.map<KDropdownItem<dynamic>>(
                    (opt) => KDropdownItem<dynamic>(
                      value: opt,
                      child: Text(opt.bankName ?? ''),
                    ),
                  )
                  .toList() ??
              [],

          // errorText: state.selectedBankName.id != null
          //     ? null
          //     : 'Please select a bank',
          onChanged: (v) {
            if (v != null) {
              stateController.onSelctExistingBankName(v);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'New Bank Account Number *',
            hintText: 'Enter here...',
            controller: stateController.newAccountNumController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter bank account number'
                : null),
          ),
        ),

        KDropdownField<dynamic>(
          value: null,
          fieldHeadingText: 'New Bank Name *',
          hintText: 'Select a bank',

          items:
              state.bankNames
                  ?.map<KDropdownItem<dynamic>>(
                    (opt) => KDropdownItem<dynamic>(
                      value: opt,
                      child: Text(opt.bankName ?? ''),
                    ),
                  )
                  .toList() ??
              [],

          onChanged: (v) {
            if (v != null) {
              stateController.onSelectNewBankName(v);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Branch IFSC Code *',
            hintText: 'Enter here...',
            controller: stateController.ifscController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter IFSC code'
                : null),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Account Name *',
            hintText: 'Enter here...',
            controller: stateController.accountNameController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter account name'
                : null),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            controller: stateController.effectiveFromController,
            fieldHeadingText: 'Effective From *',
            hintText: 'Select',
            readOnly: true,
            onTap: stateController.onSelectEffectiveFrom,
            validator: (value) =>
                (value == null || value.isEmpty ? 'Please select date' : null),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Comments *',
            hintText: 'Enter here...',
            controller: stateController.reasonController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter comments'
                : null),
          ),
        ),
      ],
    );
  }
}
