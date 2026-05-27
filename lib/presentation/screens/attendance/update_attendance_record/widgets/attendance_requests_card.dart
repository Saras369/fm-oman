part of '../view.dart';

class AttendanceRequestsCard extends ConsumerStatefulWidget {
  final List<AttendanceRequestItem> myRequests;
  final List<AttendanceRequestItem> actionItems;
  final _ViewState state;
  final _VSController stateController;

  const AttendanceRequestsCard({
    super.key,
    required this.myRequests,
    required this.actionItems,
    required this.state,
    required this.stateController,
  });

  @override
  ConsumerState<AttendanceRequestsCard> createState() =>
      _AttendanceRequestsCardState();
}

class _AttendanceRequestsCardState
    extends ConsumerState<AttendanceRequestsCard> {
  int currentPage = 1;

  int get selectedTab => widget.state.requestListTabIndex;

  @override
  void didUpdateWidget(covariant AttendanceRequestsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.requestListTabIndex != widget.state.requestListTabIndex) {
      currentPage = 1;
    }
  }

  List<AttendanceRequestItem> get currentItems {
    int pageSize = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;

    final list = selectedTab == 0 ? widget.myRequests : widget.actionItems;
    if (pageSize == 0) return [];
    int start = (currentPage - 1) * pageSize;
    return list.skip(start).take(pageSize).toList();
  }

  int get totalPages {
    int pageSize = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;

    final count = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;
    if (pageSize == 0) return 1;
    return (count / pageSize).ceil();
  }

  void onTabChange(int idx) {
    setState(() {
      currentPage = 1;
    });
    widget.stateController.setRequestListTab(idx);
  }

  @override
  Widget build(BuildContext context) {
    final items = currentItems;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return SingleChildScrollView(
      child: Card(
        color: currentTheme.colors.onPrimary,
        margin: EdgeInsets.all(8.toAutoScaledWidth),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 600.toAutoScaledHeight,
            child: Column(
              children: [
                _buildHeader(context, widget.stateController, widget.state),
                const SizedBox(height: 12),
                _buildTabs(),
                const SizedBox(height: 16),
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Text(
                            selectedTab == 0
                                ? 'No requests found'
                                : 'No action items found',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: currentTheme.fontSizes.s14,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (_, index) => _AttendanceRequestCardItem(
                            request: items[index],
                            stateController: widget.stateController,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    _VSController stateController,
    _ViewState state,
  ) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              'Attendance Requests',
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
                    return UpdateAttendanceRequestForm();
                  },
                );
              },
            ),
            const SizedBox(width: 8),
            _IconButton(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
        10.toVerticalSizedBox,
        KSearchBar(
          autofocus: false,
          onChanged: stateController.onSearchChanged,
          hintText: 'Search by Approver or Request ID',
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

class _AttendanceRequestCardItem extends StatelessWidget {
  final AttendanceRequestItem request;
  final _VSController stateController;

  const _AttendanceRequestCardItem({
    required this.request,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final textTheme = Theme.of(context).textTheme;
    final requestName =
        request.subService?.subServiceName ??
        request.reason ??
        'Update Attendance Request';
    final requestDate = request.createdAt?.formattedDate ?? '';
    final approverName = attendanceApproverDisplayName(request);
    final rawStatus = request.status ??
        request.approvalDetails?.lastOrNull?.approvalStatus ??
        '';
    final status = rawStatus.trim().toLowerCase();

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
            _buildRow('Request Name:', requestName, textTheme),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _buildRow('Date:', requestDate, textTheme),
                ),
                Expanded(
                  child: _buildRow('Approver:', approverName, textTheme),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                StatusBadgeMobile(status: status),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  color: const Color(0xFF23272F),
                  onPressed: () {
                    stateController.onPressRequestDetails(request.id ?? 0);
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
            style: const TextStyle(fontWeight: FontWeight.w600),
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
