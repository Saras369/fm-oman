import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/common_widgets/radio_group.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ReimbursementRequestScreen extends StatefulWidget {
  final int serviceId;
  final int subServiceId;

  const ReimbursementRequestScreen({
    super.key,
    required this.serviceId,
    required this.subServiceId,
  });

  @override
  State<ReimbursementRequestScreen> createState() =>
      _ReimbursementRequestScreenState();
}

class _ReimbursementRequestScreenState
    extends State<ReimbursementRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = _ReimbursementFormController();
  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickPaymentDate() async {
    final now = DateTime.now();
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: context,
      initialDate: _controller.paymentDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      setState(() => _controller.setPaymentDate(pickedDate));
    }
  }

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      _controller.expandInvalidRows();
    });

    if (_formKey.currentState?.validate() != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill required fields')),
      );
      return;
    }

    final payload = _controller.toPayload(
      serviceId: widget.serviceId,
      subServiceId: widget.subServiceId,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payload prepared: ${payload.toString()}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => KAppX.router.pop(),
        ),
        title: Text(
          'Request Form',
          style: TextStyle(
            fontSize: currentTheme.fontSizes.s20,
            fontWeight: currentTheme.fontWeights.wBolder,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.toAutoScaledWidth,
              vertical: 24.toAutoScaledHeight,
            ),
            children: [
              Text(
                'Provide details about your New Request',
                style: TextStyle(
                  color: currentTheme.colors.secondary.shade40,
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: currentTheme.fontWeights.wRegular,
                ),
              ),
              16.toVerticalSizedBox,
              const Divider(color: Color(0xFFDCE9EA), height: 1),
              20.toVerticalSizedBox,
              KRadioGroup<String>(
                title: 'Payment Mode',
                isRequired: true,
                selectedValue: _controller.paymentMode,
                options: const [
                  KRadioOption(value: 'Cash', label: 'Cash'),
                  KRadioOption(value: 'Online', label: 'Online'),
                ],
                onChanged: (value) {
                  setState(() => _controller.paymentMode = value);
                },
              ),
              KTextField(
                controller: _controller.paymentDateController,
                fieldHeadingText: 'Select Payment Date',
                isRequired: true,
                hintText: 'Select date',
                readOnly: true,
                onTap: _pickPaymentDate,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please select payment date'
                    : null,
              ),
              20.toVerticalSizedBox,
              Text(
                'Reimbursement Break Up',
                style: TextStyle(
                  color: currentTheme.colors.secondary,
                  fontSize: currentTheme.fontSizes.s16,
                  fontWeight: currentTheme.fontWeights.wBolder,
                ),
              ),
              14.toVerticalSizedBox,
              _AddTableButton(
                onTap: () {
                  if (!_controller.areRowsValid) {
                    setState(() {
                      _autoValidateMode = AutovalidateMode.onUserInteraction;
                      _controller.expandInvalidRows();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Complete the current reimbursement item first',
                        ),
                      ),
                    );
                    return;
                  }

                  setState(_controller.addRow);
                },
              ),
              12.toVerticalSizedBox,
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Column(
                    children: [
                      for (var i = 0; i < _controller.rows.length; i++) ...[
                        _ReimbursementRowCard(
                          row: _controller.rows[i],
                          canRemove: _controller.rows.length > 1,
                          onChanged: () {
                            setState(() {});
                            if (_autoValidateMode !=
                                AutovalidateMode.disabled) {
                              _formKey.currentState?.validate();
                            }
                          },
                          onRemove: () {
                            setState(() => _controller.removeRowAt(i));
                          },
                          onToggle: () {
                            setState(() {
                              _controller.rows[i].isExpanded =
                                  !_controller.rows[i].isExpanded;
                            });
                          },
                        ),
                        12.toVerticalSizedBox,
                      ],
                      _NetAmountBar(amount: _controller.netAmount),
                    ],
                  );
                },
              ),
              20.toVerticalSizedBox,
              KTextActionButton(
                height: 56.toAutoScaledHeight,
                color: const Color(0xFF0E7A32),
                disableColor: Colors.grey.shade600,
                text: Text(
                  'Submit',
                  style: TextStyle(
                    color: currentTheme.colors.onPrimary,
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: currentTheme.fontWeights.wBold,
                  ),
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReimbursementFormController extends ChangeNotifier {
  final TextEditingController paymentDateController = TextEditingController();
  final List<_ReimbursementRowModel> rows = [];

  String paymentMode = 'Cash';
  DateTime? paymentDate;

  _ReimbursementFormController() {
    addRow();
  }

  double get netAmount => rows.fold(0, (total, row) => total + row.total);

  bool get areRowsValid => rows.every((row) => row.isValid);

  void addRow() {
    for (final row in rows) {
      row.isExpanded = false;
    }
    rows.add(
      _ReimbursementRowModel(
        serialNumber: (rows.length + 1).toString().padLeft(3, '0'),
      ),
    );
    notifyListeners();
  }

  void expandInvalidRows() {
    for (final row in rows) {
      if (!row.isValid) {
        row.isExpanded = true;
      }
    }
    notifyListeners();
  }

  void removeRowAt(int index) {
    if (index < 0 || index >= rows.length) return;
    rows.removeAt(index).dispose();
    for (var i = 0; i < rows.length; i++) {
      rows[i].serialNumber = (i + 1).toString().padLeft(3, '0');
    }
    notifyListeners();
  }

  void setPaymentDate(DateTime date) {
    paymentDate = date;
    paymentDateController.text = DateFormat('dd-MM-yyyy').format(date);
  }

  Map<String, dynamic> toPayload({
    required int serviceId,
    required int subServiceId,
  }) {
    return {
      'service_id': serviceId,
      'sub_service_id': subServiceId,
      'payment_mode': paymentMode,
      'payment_date': paymentDate == null
          ? null
          : DateFormat('yyyy-MM-dd').format(paymentDate!),
      'net_amount': netAmount,
      'items': rows.map((row) => row.toPayload()).toList(),
    };
  }

  @override
  void dispose() {
    paymentDateController.dispose();
    for (final row in rows) {
      row.dispose();
    }
    super.dispose();
  }
}

class _ReimbursementRowModel {
  String serialNumber;
  bool isExpanded;
  final TextEditingController itemController;
  final TextEditingController priceController;
  final TextEditingController quantityController;

  _ReimbursementRowModel({required this.serialNumber})
    : isExpanded = true,
      itemController = TextEditingController(),
      priceController = TextEditingController(),
      quantityController = TextEditingController();

  double get price =>
      double.tryParse(priceController.text.trim().replaceAll(',', '')) ?? 0;

  int get quantity => int.tryParse(quantityController.text.trim()) ?? 0;

  double get total => price * quantity;

  bool get isValid {
    return itemController.text.trim().isNotEmpty && price > 0 && quantity > 0;
  }

  Map<String, dynamic> toPayload() {
    return {
      'item_description': itemController.text.trim(),
      'price': price,
      'qty': quantity,
      'amount': total,
    };
  }

  void dispose() {
    itemController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
}

class _AddTableButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddTableButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFDADADA)),
          ),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Add Table',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Icon(Icons.add_circle_outline, color: Color(0xFF0E7A32)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReimbursementRowCard extends StatelessWidget {
  final _ReimbursementRowModel row;
  final bool canRemove;
  final VoidCallback onChanged;
  final VoidCallback onRemove;
  final VoidCallback onToggle;

  const _ReimbursementRowCard({
    required this.row,
    required this.canRemove,
    required this.onChanged,
    required this.onRemove,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFDADADA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  row.serialNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
                onPressed: canRemove ? onRemove : null,
              ),
              IconButton(
                icon: Icon(
                  row.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
          if (row.isExpanded) ...[
            const Divider(color: Color(0xFFDCE9EA)),
            _DashedTextField(
              label: 'Item',
              controller: row.itemController,
              onChanged: (_) => onChanged(),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Please enter item'
                  : null,
            ),
            12.toVerticalSizedBox,
            _DashedTextField(
              label: 'Price',
              controller: row.priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onChanged: (_) => onChanged(),
              validator: (value) {
                final parsed = double.tryParse(value?.trim() ?? '');
                if (parsed == null || parsed <= 0) return 'Enter valid price';
                return null;
              },
            ),
            12.toVerticalSizedBox,
            _DashedTextField(
              label: 'Quantity',
              controller: row.quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => onChanged(),
              validator: (value) {
                final parsed = int.tryParse(value?.trim() ?? '');
                if (parsed == null || parsed <= 0) {
                  return 'Enter valid quantity';
                }
                return null;
              },
            ),
            const Divider(color: Color(0xFFDCE9EA)),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total Amount',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  _formatAmount(row.total),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _DashedTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const _DashedTextField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return KTextField(
      controller: controller,
      fieldHeadingText: label,
      isRequired: true,
      hintText: 'Add',
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      borderColor: const Color(0xFFC7D3DF),
      focusedBorderColor: const Color(0xFF7C9AB8),
    );
  }
}

class _NetAmountBar extends StatelessWidget {
  final double amount;

  const _NetAmountBar({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFDADADA)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Net Amount',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          24.toHorizontalSizedBox,
          Text(
            _formatAmount(amount),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

String _formatAmount(double value) {
  final format = NumberFormat.currency(symbol: '', decimalDigits: 2);
  return format.format(value).trim();
}
