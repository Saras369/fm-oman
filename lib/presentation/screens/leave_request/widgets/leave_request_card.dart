part of '../view.dart';

class LeaveRequest {
  final String id;
  final String name;
  final String date;
  final String approver;
  final RequestStatus status;

  LeaveRequest({
    required this.id,
    required this.name,
    required this.date,
    required this.approver,
    required this.status,
  });
}

enum RequestStatus { approved, pending, rejected }

class LeaveRequestsCardMobile extends StatefulWidget {
  final List<MyLeaveRequestItem> myRequests;
  final List<MyLeaveRequestItem> actionItems;
  final DynamicLeaveFormParams params;
  final DynamicLeaveFormState state;
  final DynamicLeaveFormController stateController;

  const LeaveRequestsCardMobile({
    super.key,
    required this.myRequests,
    required this.actionItems,
    required this.params,
    required this.state,
    required this.stateController,
  });

  @override
  State<LeaveRequestsCardMobile> createState() =>
      _LeaveRequestsCardMobileState();
}

class _LeaveRequestsCardMobileState extends State<LeaveRequestsCardMobile> {
  int selectedTab = 0; // 0=My Requests, 1=Action Items
  int currentPage = 1;
  // static const int pageSize = 5;

  List<MyLeaveRequestItem> get currentItems {
    final list = selectedTab == 0 ? widget.myRequests : widget.actionItems;
    final pageSize = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;
    int start = (currentPage - 1) * pageSize;
    return list.skip(start).take(pageSize).toList();
  }

  int get totalPages {
    final pageSize = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;

    final count = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;
    return (count / pageSize).ceil();
  }

  void onTabChange(int idx) {
    setState(() {
      selectedTab = idx;
      currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = currentItems;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: EdgeInsets.all(8.toAutoScaledWidth),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 600.toAutoScaledHeight,
          child: Column(
            children: [
              _buildHeader(context, widget.params),
              const SizedBox(height: 12),
              _buildTabs(),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) => _LeaveRequestCardMobileItem(
                    request: items[index],
                    state: widget.state,
                    stateController: widget.stateController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DynamicLeaveFormParams params) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              'Leave Requests',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _IconButton(
              icon: Icons.add,
              onTap: () {
                KAppX.extendedRouter.dialog.showKDialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 20.toAutoScaledWidth,
                  ),

                  builder: (context) {
                    return LeaveFormWidget(
                      params: params,
                      // state: null,
                      // stateController: null,
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 8),
            _IconButton(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
        10.toVerticalSizedBox,
        // _SearchBar(),
        KSearchBar(
          autofocus: false,
          onChanged: (value) {},
          hintText: 'Search by Request Name or Request ID',
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        TabButton(
          label: 'My Requests',
          selected: selectedTab == 0,
          icon: Icons.assignment,
          onTap: () => onTabChange(0),
        ),
        const SizedBox(width: 10),
        TabButton(
          label: 'Action Items',
          selected: selectedTab == 1,
          icon: Icons.task_alt_outlined,
          onTap: () => onTabChange(1),
        ),
      ],
    );
  }
}

class _LeaveRequestCardMobileItem extends StatelessWidget {
  final MyLeaveRequestItem request;
  final DynamicLeaveFormState state;
  final DynamicLeaveFormController stateController;
  const _LeaveRequestCardMobileItem({
    required this.request,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final textTheme = Theme.of(context).textTheme;
    // In your app:
    EmployeeInfo empDetails = EmployeeInfo(
      requestId: "XXXXXXXXX",
      employeeId: "XXXXXXXXX",
      jobTitle: "Senior Developer",
      email: "Husamuddin@company.com",
      department: "Software Engineer",
      contactNumber: "XXXXXXXXXXXX",
      leaveType: "Casual Leave",
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: currentTheme.colors.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Request ID:', '${request.id ?? 0}', textTheme),
            const SizedBox(height: 6),
            _buildRow(
              'Request Name:',
              request.leaveType?.name ?? '',
              textTheme,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _buildRow(
                    'Date:',
                    DateTime.parse(request.updatedAt ?? '').formattedDate,
                    textTheme,
                  ),
                ),
                Expanded(child: _buildRow('Approver:', 'Unknown', textTheme)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                StatusBadgeMobile(
                  status: request.approvalDetails?.isNotEmpty == true
                      ? request.approvalDetails?.first.approvalStatus
                                ?.toString()
                                .toLowerCase() ??
                            ''
                      : '',
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.open_in_new),
                  color: const Color(0xFF23272F),
                  onPressed: () {
                    KAppX.router.push(
                      LeaveRequestDetailsRoute(employeeInfo: empDetails),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, TextTheme theme) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return RichText(
      text: TextSpan(
        style: theme.bodyMedium?.copyWith(
          color: const Color(0xFF23272F),
          fontSize: currentTheme.fontSizes.s14,
          fontWeight: FontWeight.normal,
        ),
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Color(0xFFF4F6F8),
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon, size: 24, color: const Color(0xFFB3BCC5)),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }
}
