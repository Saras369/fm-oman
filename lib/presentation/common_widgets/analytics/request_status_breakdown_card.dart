part of '../../screens/leave_request/view.dart';

String _localizedTimePeriod(BuildContext context, String value) {
  final l10n = AppLocalizations.of(context);
  if (l10n == null) return value;
  switch (value) {
    case 'Weekly':
      return l10n.filterWeekly;
    case 'Monthly':
      return l10n.filterMonthly;
    case 'Quarterly':
      return l10n.filterQuarterly;
    case 'Yearly':
      return l10n.filterYearly;
    default:
      return value;
  }
}

class RequestStatusBreakdownCard extends StatelessWidget {
  final Map<String, ChartData> data;
  final List<String> filterLabel;
  final String? title;
  final String filterLabelSelected;
  final IconData? icon;
  final VoidCallback? onFilterTap;
  final Function(String?) onChanged;

  const RequestStatusBreakdownCard({
    super.key,
    required this.data,
    this.title,
    this.filterLabel = const ['Weekly', 'Monthly', 'Quarterly', 'Yearly'],
    this.icon = Icons.pie_chart_outline,
    this.onFilterTap,
    required this.onChanged,
    this.filterLabelSelected = 'Yearly',
  });

  int get totalValue => data.values.fold(0, (prev, e) => prev + e.value);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chartSections = data.values.toList();
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, l10n),
            const SizedBox(height: 20),
            _buildContent(context, chartSections, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final headline =
        title ?? l10n?.requestsStatusBreakdown ?? 'Requests Status Breakdown';
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 20, color: const Color(0xFF374151)),
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Text(
            headline,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
              fontSize: currentTheme.fontSizes.s16,
            ),
          ),
        ),
        IntrinsicWidth(
          child: KDropdownField<dynamic>(
            value: filterLabelSelected,
            hintText: l10n?.selectOption ?? 'Select',
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsetsDirectional.only(
                start: 10,
                end: 6,
                top: 8,
                bottom: 8,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC1C7D0)),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC1C7D0)),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            items: filterLabel
                .map<KDropdownItem<dynamic>>(
                  (opt) => KDropdownItem<dynamic>(
                    value: opt,
                    child: Text(_localizedTimePeriod(context, opt)),
                  ),
                )
                .toList(),
            onChanged: (dynamic v) => onChanged(v as String?),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<ChartData> chartSections,
    AppLocalizations? l10n,
  ) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 45,
                  sections: chartSections.map((section) {
                    return PieChartSectionData(
                      color: section.color,
                      value: section.value.toDouble(),
                      title: '',
                      radius: 22,
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    );
                  }).toList(),
                ),
                swapAnimationDuration: const Duration(milliseconds: 800),
                swapAnimationCurve: Curves.easeInOut,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$totalValue',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      fontSize: currentTheme.fontSizes.s24,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n?.chartCenterTotalRequests ?? 'Total Requests',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7280),
                      fontSize: currentTheme.fontSizes.s11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _BreakdownLegend(
            totalValue: totalValue,
            sections: chartSections,
            l10n: l10n,
          ),
        ),
      ],
    );
  }
}

class _BreakdownLegend extends StatelessWidget {
  final int totalValue;
  final List<ChartData> sections;
  final AppLocalizations? l10n;

  const _BreakdownLegend({
    required this.totalValue,
    required this.sections,
    this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n?.breakdownSectionTitle ?? 'Breakdown',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: currentTheme.fontSizes.s14,
          ),
        ),
        const SizedBox(height: 16),
        _LegendItem(
          color: const Color(0xFFE5E7EB),
          label: l10n?.chartLegendTotalTickets ?? 'Total Tickets',
          value: totalValue,
        ),
        const SizedBox(height: 8),
        ...sections.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LegendItem(
              color: section.color,
              label: section.label,
              value: section.value,
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
              fontSize: currentTheme.fontSizes.s12,
            ),
          ),
        ),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: currentTheme.fontSizes.s12,
          ),
        ),
      ],
    );
  }
}
