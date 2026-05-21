part of '../view.dart';

class _SecurityRequestCard extends ConsumerStatefulWidget {
  final List<SecurityRequestItem> myRequests;
  final List<SecurityRequestItem> actionItems;
  final _SecurityViewState state;
  final _SecurityController stateController;

  const _SecurityRequestCard({
    super.key,
    required this.myRequests,
    required this.actionItems,
    required this.state,
    required this.stateController,
  });

  @override
  ConsumerState<_SecurityRequestCard> createState() =>
      _SecurityRequestCardState();
}

class _SecurityRequestCardState extends ConsumerState<_SecurityRequestCard> {
  int selectedTab = 0;

  void onTabChange(int index) {
    setState(() => selectedTab = index);
    widget.stateController.toggleViewMode(index == 1);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final items = selectedTab == 0 ? widget.myRequests : widget.actionItems;

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
              _buildHeader(context),
              const SizedBox(height: 12),
              Row(
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
              ),
              const SizedBox(height: 16),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          selectedTab == 0
                              ? 'No requests found'
                              : 'No action items found',
                          style: TextStyle(
                            color: currentTheme.colors.secondary.shade40,
                            fontWeight: currentTheme.fontWeights.wBold,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, index) => _SecurityRequestCardItem(
                          request: items[index],
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt_outlined, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              'Approvals',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            _SecurityIconButton(
              icon: Icons.add,
              onTap: widget.stateController.openCreateRequestForm,
            ),
            const SizedBox(width: 8),
            _SecurityIconButton(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
        10.toVerticalSizedBox,
        KSearchBar(
          autofocus: false,
          onChanged: (value) {},
          hintText: 'Search by Request Name or Request ID',
        ),
      ],
    );
  }
}

class _SecurityRequestCardItem extends StatelessWidget {
  final SecurityRequestItem request;
  final _SecurityController stateController;

  const _SecurityRequestCardItem({
    required this.request,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final textTheme = Theme.of(context).textTheme;
    final dateStr = _formattedRequestDate(context, request.requestDate);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: currentTheme.colors.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRow('Request ID:', '${request.id ?? 0}', textTheme),
            const SizedBox(height: 6),
            _buildRow(
              'Request Name:',
              request.requestName ??
                  request.subServiceName ??
                  stateController.selectedSubServiceTitle,
              textTheme,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _buildRow('Date:', dateStr, textTheme)),
                Expanded(
                  child: _buildRow(
                    'Assigned To:',
                    request.assignedTo ??
                        request.subServiceName ??
                        stateController.selectedSubServiceTitle,
                    textTheme,
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
                  icon: const Icon(Icons.open_in_new),
                  color: const Color(0xFF23272F),
                  onPressed: () =>
                      stateController.onPressRequestDetails(request),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formattedRequestDate(BuildContext context, String? raw) {
    if (raw == null || raw.isEmpty) return '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(parsed);
  }

  Widget _buildRow(String label, String value, TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF23272F),
          fontSize: 14,
        ),
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

class _SecurityIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SecurityIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(34),
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF9CA3AF), size: 26),
      ),
    );
  }
}
