import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/hr_services/stay_after_hours_request_model.dart';
import 'package:code_setup/presentation/common_widgets/status_badge_mobile.dart';
import 'package:code_setup/presentation/common_widgets/tab_button.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/leave_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

@RoutePage()
class StayAfterWorkingHoursScreen extends ConsumerStatefulWidget {
  final int serviceId;
  final List<SubServices> subServicesList;

  const StayAfterWorkingHoursScreen({
    super.key,
    required this.serviceId,
    required this.subServicesList,
  });

  @override
  ConsumerState<StayAfterWorkingHoursScreen> createState() =>
      _StayAfterWorkingHoursScreenState();
}

class _StayAfterWorkingHoursScreenState
    extends ConsumerState<StayAfterWorkingHoursScreen> {
  int selectedTab = 0;
  bool isLoading = false;
  List<StayAfterHoursRequestItem> myRequests = [];
  List<StayAfterHoursRequestItem> actionItems = [];

  final repo = LeaveRepo();

  SubServices? get selectedSubService {
    for (final subService in widget.subServicesList) {
      final name = subService.subServiceName?.toLowerCase() ?? '';
      if (name.contains('stay') ||
          name.contains('working hours') ||
          name.contains('after hours')) {
        return subService;
      }
    }
    return null;
  }

  int get selectedServiceId =>
      selectedSubService?.serviceId ?? widget.serviceId;
  int get selectedSubServiceId => selectedSubService?.id ?? 0;
  bool get hasSelectedService =>
      selectedServiceId > 0 && selectedSubServiceId > 0;

  Map<String, dynamic> get selectedListParams => {
    'offset': 1,
    'limit': 10,
    'service_id': selectedServiceId,
    'sub_service_id': selectedSubServiceId,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMyRequests());
  }

  Future<void> _loadMyRequests() async {
    if (!hasSelectedService) return;
    setState(() => isLoading = true);
    try {
      final requests = await repo.fetchStayAfterHoursRequests(
        selectedListParams,
      );
      if (mounted) setState(() => myRequests = requests ?? []);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching stay after hours requests $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _loadActionItems() async {
    if (!hasSelectedService) return;
    setState(() => isLoading = true);
    try {
      final requests = await repo.fetchStayAfterHoursRequests(
        selectedListParams,
        isApprover: true,
      );
      if (mounted) setState(() => actionItems = requests ?? []);
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error fetching stay after hours action items $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _onTabChanged(int index) {
    setState(() => selectedTab = index);
    if (index == 0) {
      _loadMyRequests();
    } else {
      _loadActionItems();
    }
  }

  void _openCreateRequestForm() {
    if (!hasSelectedService) {
      Fluttertoast.showToast(
        msg: 'Stay after working hours sub-service missing',
      );
      return;
    }
    KAppX.extendedRouter.dialog.showKDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),
      builder: (_) => _StayAfterHoursForm(
        serviceId: selectedServiceId,
        subServiceId: selectedSubServiceId,
        onSubmitted: _loadMyRequests,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final items = selectedTab == 0 ? myRequests : actionItems;

    return KScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.toAutoScaledWidth),
        child: Card(
          color: currentTheme.colors.onPrimary,
          child: Padding(
            padding: EdgeInsets.all(16.toAutoScaledWidth),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.nightlight_round),
                    12.toHorizontalSizedBox,
                    Expanded(
                      child: Text(
                        'Request for stay after working hours',
                        style: TextStyle(
                          fontSize: currentTheme.fontSizes.s16,
                          fontWeight: currentTheme.fontWeights.wBold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _openCreateRequestForm,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                12.toVerticalSizedBox,
                KSearchBar(
                  autofocus: false,
                  onChanged: (_) {},
                  hintText: 'Search by Request Name or Request ID',
                ),
                12.toVerticalSizedBox,
                Row(
                  children: [
                    TabButton(
                      label: 'My Requests',
                      selected: selectedTab == 0,
                      icon: Icons.assignment,
                      onTap: () => _onTabChanged(0),
                    ),
                    10.toHorizontalSizedBox,
                    TabButton(
                      label: 'Action Items',
                      selected: selectedTab == 1,
                      icon: Icons.task_alt_outlined,
                      onTap: () => _onTabChanged(1),
                    ),
                  ],
                ),
                12.toVerticalSizedBox,
                if (isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => 12.toVerticalSizedBox,
                      itemBuilder: (_, index) =>
                          _StayAfterHoursCard(request: items[index]),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StayAfterHoursCard extends StatelessWidget {
  final StayAfterHoursRequestItem request;

  const _StayAfterHoursCard({required this.request});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      elevation: 1,
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(14.toAutoScaledWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('Request ID:', '${request.id ?? 0}', context),
            6.toVerticalSizedBox,
            _row('Request Name:', request.requestName ?? '', context),
            6.toVerticalSizedBox,
            _row('Date:', request.requestDate ?? '', context),
            6.toVerticalSizedBox,
            _row('Assigned To:', request.assignedTo ?? 'N/A', context),
            10.toVerticalSizedBox,
            StatusBadgeMobile(
              status: (request.requestStatus ?? '').toLowerCase(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF303236)),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _StayAfterHoursForm extends ConsumerStatefulWidget {
  final int serviceId;
  final int subServiceId;
  final Future<void> Function() onSubmitted;

  const _StayAfterHoursForm({
    required this.serviceId,
    required this.subServiceId,
    required this.onSubmitted,
  });

  @override
  ConsumerState<_StayAfterHoursForm> createState() =>
      _StayAfterHoursFormState();
}

class _StayAfterHoursFormState extends ConsumerState<_StayAfterHoursForm> {
  final formKey = GlobalKey<FormState>();
  final permitController = TextEditingController();
  final jobController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final fromTimeController = TextEditingController();
  final toTimeController = TextEditingController();
  final workController = TextEditingController();
  final officeController = TextEditingController();
  final departmentController = TextEditingController();
  final commentsController = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    permitController.dispose();
    jobController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    workController.dispose();
    officeController.dispose();
    departmentController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> _submit() async {
    if (formKey.currentState?.validate() != true) return;
    final user = KAppX.globalProvider.read(userProvider);
    setState(() => isSubmitting = true);
    try {
      await LeaveRepo().createStayAfterHoursRequest({
        'req_user_department_id': user?.department,
        'req_user_section_id': user?.section,
        'service_id': widget.serviceId,
        'sub_service_id': widget.subServiceId,
        'permit_number': permitController.text.trim(),
        'job_number': jobController.text.trim(),
        'date_from': fromDateController.text.trim(),
        'date_to': toDateController.text.trim(),
        'duration_from': fromTimeController.text.trim(),
        'duration_to': toTimeController.text.trim(),
        'nature_of_assigned_work': workController.text.trim(),
        'office_numbers_to_enter': officeController.text.trim(),
        'department': int.tryParse(departmentController.text.trim()),
        'comments': commentsController.text.trim(),
      });
      KAppX.router.pop();
      await widget.onSubmitted();
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
    } catch (e) {
      log('error creating stay after hours request $e');
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(12.toAutoScaledWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Request Form',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              16.toVerticalSizedBox,
              _field(permitController, 'Permit Number *'),
              _field(jobController, 'Job Number *'),
              _field(
                fromDateController,
                'Date From *',
                readOnly: true,
                onTap: () => _pickDate(fromDateController),
              ),
              _field(
                toDateController,
                'Date To *',
                readOnly: true,
                onTap: () => _pickDate(toDateController),
              ),
              _field(fromTimeController, 'Duration From *', hint: '18:00:00'),
              _field(toTimeController, 'Duration To *', hint: '21:30:00'),
              _field(workController, 'Nature of Assigned Work *', maxLines: 3),
              _field(officeController, 'Office Numbers To Enter *'),
              _field(departmentController, 'Department ID *'),
              _field(
                commentsController,
                'Comments',
                required: false,
                maxLines: 3,
              ),
              KTextActionButton(
                onPressed: _submit,
                isDisabled: isSubmitting,
                text: Text(isSubmitting ? 'Submitting...' : 'Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    String? hint,
    bool readOnly = false,
    bool required = true,
    int maxLines = 1,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.toAutoScaledHeight),
      child: KTextField(
        controller: controller,
        fieldHeadingText: label,
        hintText: hint ?? label.replaceAll('*', '').trim(),
        readOnly: readOnly,
        maxLines: maxLines,
        onTap: onTap,
        validator: required
            ? (value) =>
                  (value == null || value.trim().isEmpty) ? 'Required' : null
            : null,
      ),
    );
  }
}
