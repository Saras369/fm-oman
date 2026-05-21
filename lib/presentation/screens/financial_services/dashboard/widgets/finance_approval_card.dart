part of '../view.dart';

class FinanceApprovalCard extends ConsumerStatefulWidget {
  final List<FinancialServiceRequestItem> myRequests;
  final List<FinancialServiceRequestItem> actionItems;
  final _ViewState state;
  final _VSController stateController;

  const FinanceApprovalCard({
    super.key,
    required this.myRequests,
    required this.actionItems,
    required this.state,
    required this.stateController,
  });

  @override
  ConsumerState<FinanceApprovalCard> createState() =>
      _FinanceApprovalCardState();
}

class _FinanceApprovalCardState extends ConsumerState<FinanceApprovalCard> {
  int selectedTab = 0; // 0=My Requests, 1=Action Items
  int currentPage = 1;

  List<FinancialServiceRequestItem> get currentItems {
    int pageSize = selectedTab == 0
        ? widget.myRequests.length
        : widget.actionItems.length;

    final list = selectedTab == 0 ? widget.myRequests : widget.actionItems;
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
    return (count / pageSize).ceil();
  }

  void onTabChange(int idx) {
    setState(() {
      selectedTab = idx;
      currentPage = 1;
    });
    widget.stateController.toggleViewMode(idx == 1);
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
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) => _FinaceRequestCardItem(
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              l10n.approvalsSectionTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _IconButton(
              icon: Icons.add,
              onTap: () {
                stateController.onPressCurrentSubServiceRequest(state);
              },
            ),
            const SizedBox(width: 8),
            _IconButton(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
        10.toVerticalSizedBox,
        KSearchBar(
          autofocus: false,
          onChanged: (value) {},
          hintText: l10n.searchFinancialRequestsHint,
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        TabButton(
          label: l10n.tabMyRequests,
          selected: selectedTab == 0,
          icon: Icons.assignment,
          onTap: () => onTabChange(0),
        ),
        const SizedBox(width: 10),
        TabButton(
          label: l10n.tabActionItems,
          selected: selectedTab == 1,
          icon: Icons.task_alt_outlined,
          onTap: () => onTabChange(1),
        ),
      ],
    );
  }
}

class _FinaceRequestCardItem extends StatelessWidget {
  final FinancialServiceRequestItem request;
  final _VSController stateController;

  const _FinaceRequestCardItem({
    required this.request,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final localeTag = Localizations.localeOf(context).toString();
    final dateStr = () {
      final raw = request.requestDate;
      if (raw == null || raw.isEmpty) return '';
      final dt = DateTime.tryParse(raw);
      if (dt == null) return '';
      return DateFormat.yMMMd(localeTag).format(dt);
    }();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: currentTheme.colors.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRow(
              l10n.labelRequestId,
              '${request.id ?? 0}',
              textTheme,
              context,
            ),
            const SizedBox(height: 6),
            _buildRow(
              l10n.labelRequestName,
              request.subServiceId?.subServiceName ?? '',
              textTheme,
              context,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _buildRow(l10n.labelDate, dateStr, textTheme, context),
                ),
                Expanded(
                  child: _buildRow(
                    l10n.labelApprover,
                    request.subServiceId?.subServiceName ?? '',
                    textTheme,
                    context,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                StatusBadgeMobile(
                  status: request.requestStatus?.toLowerCase() ?? '',
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.open_in_new),
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

  Widget _buildRow(
    String label,
    String value,
    TextTheme theme,
    BuildContext context,
  ) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return RichText(
      textDirection: Directionality.of(context),
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
