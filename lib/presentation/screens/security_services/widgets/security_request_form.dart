part of '../view.dart';

class _SecurityRequestForm extends StatefulWidget {
  final _SecurityController stateController;

  const _SecurityRequestForm({required this.stateController});

  @override
  State<_SecurityRequestForm> createState() => _SecurityRequestFormState();
}

class _SecurityRequestFormState extends State<_SecurityRequestForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController numberController;
  late final TextEditingController jobTitleController;
  late final TextEditingController reasonController;
  late final TextEditingController joiningDateController;
  late final TextEditingController issueDateController;
  late final TextEditingController photoUrlController;
  late final TextEditingController retirementDateController;
  late final TextEditingController requestDateController;
  late final TextEditingController departmentIdController;
  late final TextEditingController serialNumberController;
  late final TextEditingController officeNumberController;
  late final TextEditingController visitingDepartmentController;
  late final TextEditingController personToBeInterviewedController;
  late final TextEditingController vehicleController;
  late final TextEditingController plateController;
  late final TextEditingController purposeController;
  late final TextEditingController fromDateController;
  late final TextEditingController toDateController;
  late final TextEditingController gatePassTypeController;
  late final TextEditingController visitingPersonController;
  late final TextEditingController visitorNameController;
  late final TextEditingController visitorIdController;
  late final TextEditingController nationalityController;
  late final TextEditingController visitorJobTitleController;
  late final TextEditingController representedEntityController;
  late final TextEditingController visitorEmailController;
  late final TextEditingController visitorMobileController;
  late final TextEditingController visitorPhotoUrlController;

  String accessType = 'Normal';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberController = TextEditingController();
    jobTitleController = TextEditingController();
    reasonController = TextEditingController();
    joiningDateController = TextEditingController();
    issueDateController = TextEditingController();
    photoUrlController = TextEditingController();
    retirementDateController = TextEditingController();
    requestDateController = TextEditingController();
    departmentIdController = TextEditingController();
    serialNumberController = TextEditingController();
    officeNumberController = TextEditingController();
    visitingDepartmentController = TextEditingController();
    personToBeInterviewedController = TextEditingController();
    vehicleController = TextEditingController();
    plateController = TextEditingController();
    purposeController = TextEditingController();
    fromDateController = TextEditingController();
    toDateController = TextEditingController();
    gatePassTypeController = TextEditingController(text: 'Short-term');
    visitingPersonController = TextEditingController();
    visitorNameController = TextEditingController();
    visitorIdController = TextEditingController();
    nationalityController = TextEditingController();
    visitorJobTitleController = TextEditingController();
    representedEntityController = TextEditingController();
    visitorEmailController = TextEditingController();
    visitorMobileController = TextEditingController();
    visitorPhotoUrlController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    jobTitleController.dispose();
    reasonController.dispose();
    joiningDateController.dispose();
    issueDateController.dispose();
    photoUrlController.dispose();
    retirementDateController.dispose();
    requestDateController.dispose();
    departmentIdController.dispose();
    serialNumberController.dispose();
    officeNumberController.dispose();
    visitingDepartmentController.dispose();
    personToBeInterviewedController.dispose();
    vehicleController.dispose();
    plateController.dispose();
    purposeController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    gatePassTypeController.dispose();
    visitingPersonController.dispose();
    visitorNameController.dispose();
    visitorIdController.dispose();
    nationalityController.dispose();
    visitorJobTitleController.dispose();
    representedEntityController.dispose();
    visitorEmailController.dispose();
    visitorMobileController.dispose();
    visitorPhotoUrlController.dispose();
    super.dispose();
  }

  _SecurityRequestType get requestType =>
      widget.stateController.selectedRequestType;

  Future<void> _selectDate(TextEditingController controller) async {
    final pickedDate = await KAppX.extendedRouter.showKDatePicker(
      context: KAppX.currentContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $label';
    }
    return null;
  }

  String? _requiredDate(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select $label';
    }
    return null;
  }

  String? _requiredInt(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $label';
    }
    if (int.tryParse(value.trim()) == null) {
      return 'Enter valid $label';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;

    final data = {
      ...widget.stateController.selectedRequestIds,
      ..._requestBody(),
    };

    widget.stateController.createRequest(data);
  }

  Map<String, dynamic> _requestBody() {
    switch (requestType) {
      case _SecurityRequestType.employeeCard:
        return {
          'name': nameController.text.trim(),
          'number': numberController.text.trim(),
          'job_title': jobTitleController.text.trim(),
          'reason_for_request': reasonController.text.trim(),
          'date_of_joining': joiningDateController.text.trim(),
          'date_of_issue': issueDateController.text.trim(),
          'access_type': accessType,
          'photo_url': photoUrlController.text.trim(),
          'attachments': [],
        };
      case _SecurityRequestType.retiredCard:
        return {
          'ex_job_title': jobTitleController.text.trim(),
          'date_of_retirement': retirementDateController.text.trim(),
          'date_of_issue': issueDateController.text.trim(),
          'reason_for_request': reasonController.text.trim(),
          'access_type': accessType,
          'photo_url': photoUrlController.text.trim(),
          'attachments': [],
        };
      case _SecurityRequestType.gatePass:
        return {
          'date': requestDateController.text.trim(),
          'department_id': int.parse(departmentIdController.text.trim()),
          'serial_number': serialNumberController.text.trim(),
          'office_number': officeNumberController.text.trim(),
          'visiting_department': visitingDepartmentController.text.trim(),
          'person_to_be_interviewed': personToBeInterviewedController.text
              .trim(),
          'vehicle_type_and_color': vehicleController.text.trim(),
          'plate_number_and_code': plateController.text.trim(),
          'purpose_of_entry': purposeController.text.trim(),
          'from_date': fromDateController.text.trim(),
          'to_date': toDateController.text.trim(),
          'gate_pass_type': gatePassTypeController.text.trim(),
          'visiting_person_in_department': visitingPersonController.text.trim(),
          'visitors': [
            {
              'visitor_name': visitorNameController.text.trim(),
              'visitor_id_passport_no': visitorIdController.text.trim(),
              'nationality': nationalityController.text.trim(),
              'job_title': visitorJobTitleController.text.trim(),
              'represented_entity': representedEntityController.text.trim(),
              'visitor_email_address': visitorEmailController.text.trim(),
              'visitor_mobile_number': visitorMobileController.text.trim(),
              'visitor_photo_url': visitorPhotoUrlController.text.trim(),
              'visitor_photo_file_name': visitorPhotoUrlController.text
                  .trim()
                  .split('/')
                  .last,
            },
          ],
          'attachments': [],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SecurityFormHeader(
                title: requestType.title,
                onClose: () => KAppX.router.pop(),
              ),
              if (requestType == _SecurityRequestType.employeeCard)
                _employeeCardFields(),
              if (requestType == _SecurityRequestType.retiredCard)
                _retiredCardFields(),
              if (requestType == _SecurityRequestType.gatePass)
                _gatePassFields(),
              const SizedBox(height: 16),
              SizedBox(
                width: 392.toAutoScaledWidth,
                child: KTextActionButton(
                  text: Text(
                    'Submit',
                    style: TextStyle(
                      color: currentTheme.colors.onPrimary,
                      fontSize: currentTheme.fontSizes.s16,
                      fontWeight: currentTheme.fontWeights.wBolder,
                    ),
                  ),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _employeeCardFields() {
    return Column(
      children: [
        _field(nameController, 'Name *', 'Enter name'),
        _field(numberController, 'Employee Number *', 'Enter employee number'),
        _field(jobTitleController, 'Job Title *', 'Enter job title'),
        _dateField(joiningDateController, 'Date of Joining *'),
        _dateField(issueDateController, 'Date of Issue *'),
        _accessTypeField(),
        _field(
          photoUrlController,
          'Photo URL *',
          'Enter photo URL',
          keyboardType: TextInputType.url,
        ),
        _field(
          reasonController,
          'Reason for Request *',
          'Enter reason',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _retiredCardFields() {
    return Column(
      children: [
        _field(jobTitleController, 'Ex Job Title *', 'Enter ex job title'),
        _dateField(retirementDateController, 'Date of Retirement *'),
        _dateField(issueDateController, 'Date of Issue *'),
        _accessTypeField(),
        _field(
          photoUrlController,
          'Photo URL *',
          'Enter photo URL',
          keyboardType: TextInputType.url,
        ),
        _field(
          reasonController,
          'Reason for Request *',
          'Enter reason',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _gatePassFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dateField(requestDateController, 'Date *'),
        _field(
          departmentIdController,
          'Department ID *',
          'Enter department ID',
          keyboardType: TextInputType.number,
          validator: (value) => _requiredInt(value, 'department ID'),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        _field(
          serialNumberController,
          'Serial Number *',
          'Enter serial number',
        ),
        _field(
          officeNumberController,
          'Office Number *',
          'Enter office number',
        ),
        _field(
          visitingDepartmentController,
          'Visiting Department *',
          'Enter visiting department',
        ),
        _field(
          personToBeInterviewedController,
          'Person to be Interviewed *',
          'Enter person name',
        ),
        _field(
          vehicleController,
          'Vehicle Type and Color *',
          'Enter vehicle details',
        ),
        _field(
          plateController,
          'Plate Number and Code *',
          'Enter plate number',
        ),
        _field(
          purposeController,
          'Purpose of Entry *',
          'Enter purpose',
          maxLines: 3,
        ),
        _dateField(fromDateController, 'From Date *'),
        _dateField(toDateController, 'To Date *'),
        _field(gatePassTypeController, 'Gate Pass Type *', 'Enter pass type'),
        _field(
          visitingPersonController,
          'Visiting Person in Department *',
          'Enter visiting person',
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8.toAutoScaledHeight,
            bottom: 12.toAutoScaledHeight,
          ),
          child: Text(
            'Visitor Details',
            style: TextStyle(
              fontSize: 16.toAutoScaledFont,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        _field(visitorNameController, 'Visitor Name *', 'Enter visitor name'),
        _field(
          visitorIdController,
          'Visitor ID/Passport No *',
          'Enter ID or passport number',
        ),
        _field(nationalityController, 'Nationality *', 'Enter nationality'),
        _field(
          visitorJobTitleController,
          'Visitor Job Title *',
          'Enter visitor job title',
        ),
        _field(
          representedEntityController,
          'Represented Entity *',
          'Enter represented entity',
        ),
        _field(
          visitorEmailController,
          'Visitor Email *',
          'Enter visitor email',
          keyboardType: TextInputType.emailAddress,
        ),
        _field(
          visitorMobileController,
          'Visitor Mobile Number *',
          'Enter mobile number',
          keyboardType: TextInputType.phone,
        ),
        _field(
          visitorPhotoUrlController,
          'Visitor Photo URL *',
          'Enter visitor photo URL',
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }

  Widget _accessTypeField() {
    return KRadioGroup<String>(
      title: 'Access Type',
      isRequired: true,
      selectedValue: accessType,
      options: const [
        KRadioOption(value: 'Normal', label: 'Normal'),
        KRadioOption(value: 'Urgent', label: 'Urgent'),
      ],
      onChanged: (value) => setState(() => accessType = value),
    );
  }

  Widget _dateField(TextEditingController controller, String label) {
    return _field(
      controller,
      label,
      'Select date',
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today_outlined),
      onTap: () => _selectDate(controller),
      validator: (value) => _requiredDate(value, label.replaceAll('*', '')),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    String hint, {
    TextInputType? keyboardType,
    bool readOnly = false,
    int maxLines = 1,
    Widget? suffixIcon,
    VoidCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
      child: KTextField(
        controller: controller,
        fieldHeadingText: label,
        hintText: hint,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
        suffixIcon: suffixIcon,
        onTap: onTap,
        inputFormatters: inputFormatters,
        validator:
            validator ??
            (value) => _required(value, label.replaceAll('*', '').trim()),
      ),
    );
  }
}

class _SecurityFormHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const _SecurityFormHeader({required this.title, required this.onClose});

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
                onPressed: onClose,
                splashRadius: 18,
                tooltip: 'Close',
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            'Provide details about your new request',
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s12,
              color: const Color(0xFF8B8D94),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 13),
            child: Divider(height: 2, thickness: 1, color: Color(0xFFE5EAEB)),
          ),
        ],
      ),
    );
  }
}
