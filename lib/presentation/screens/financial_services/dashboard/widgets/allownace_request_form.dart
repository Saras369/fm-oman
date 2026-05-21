part of '../view.dart';

class AllownaceRequestForm extends ConsumerWidget {
  final _ViewState state;
  final _VSController stateController;
  const AllownaceRequestForm({
    super.key,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final isAllowanceSelected = state.selectedAllowanceType.id == null;
    final isCurrencySelected = state.selectedCurrency.code == null;
    return Column(
      children: [
        KDropdownField<AllowanceTypeItem>(
          value: null,
          fieldHeadingText: 'Allowance Type *',
          hintText: 'Select Purpose',

          items:
              state.allownceTypeList
                  ?.map<KDropdownItem<AllowanceTypeItem>>(
                    (opt) => KDropdownItem<AllowanceTypeItem>(
                      value: opt,
                      child: Text(opt.allowanceName ?? ''),
                    ),
                  )
                  .toList() ??
              [],

          // errorText: state.selectedAllowanceType.id != null
          //     ? null
          //     : 'Please select allowance type',
          onChanged: (v) {
            if (v != null) {
              stateController.onSelectAllowanceType(v);
            }
          },
        ),
        // if (isAllowanceSelected)
        //   Text(
        //     'Please select allowance type',
        //     style: TextStyle(
        //       color: Colors.red,
        //       fontSize: currentTheme.fontSizes.s12,
        //     ),
        //   ),
        10.toVerticalSizedBox,
        KDropdownField<CurrencyItem>(
          value: state.selectedCurrency.code != null
              ? state.selectedCurrency
              : null,
          fieldHeadingText: 'Currency Type *',
          hintText: 'Select currency',

          items:
              state.currencyList
                  ?.map<KDropdownItem<CurrencyItem>>(
                    (opt) => KDropdownItem<CurrencyItem>(
                      value: opt,
                      child: SizedBox(
                        width: 250.toAutoScaledWidth,
                        child: Text(opt.name ?? '', maxLines: 2),
                      ),
                    ),
                  )
                  .toList() ??
              [],

          // errorText: state.selectedCurrency.code == null
          //     ? 'Please select currency type'
          //     : null,
          onChanged: (v) {
            if (v != null) {
              stateController.onSelectCurrency(v);
            }
          },
        ),

        // if (isCurrencySelected)
        //   Text(
        //     'Please select currency type',
        //     style: TextStyle(
        //       color: Colors.red,
        //       fontSize: currentTheme.fontSizes.s12,
        //     ),
        //   ),
        10.toVerticalSizedBox,
        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Allowance Amount *',
            hintText: 'Enter here...',
            controller: stateController.alllownceAmountController,
            validator: (value) =>
                (value == null || value.isEmpty ? 'Please enter amount' : null),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Contact Number *',
            hintText: 'Enter here...',
            controller: stateController.contactNumberController,
            validator: (value) => (value == null || value.isEmpty
                ? 'Please enter contact number'
                : null),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
          child: KTextField(
            fieldHeadingText: 'Comments',
            hintText: 'Enter here...',
            controller: stateController.reasonController,
          ),
        ),
      ],
    );
  }
}
