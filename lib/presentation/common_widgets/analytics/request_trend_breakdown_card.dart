part of '../../screens/leave_request/view.dart';

List<String> _shortMonthLabels(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;
  return List.generate(
    12,
    (i) => DateFormat.MMM(code).format(DateTime(2024, i + 1)),
  );
}

class RequestTrendBreakdownCard extends StatelessWidget {
  final List<int> monthlyData;
  final List<String>? monthLabels;
  final int? selectedYear;
  final String? title;
  final String? metric;
  final Color barColor;
  final void Function()? onYearTap;
  final List<int>? yearOptions;
  final ValueChanged<int?> onYearChanged;

  RequestTrendBreakdownCard({
    super.key,
    required this.monthlyData,
    this.monthLabels,
    this.title,
    this.metric,
    this.selectedYear,
    this.barColor = const Color(0xFFBD8A52),
    this.onYearTap,
    this.yearOptions,
    required this.onYearChanged,
  }) : assert(monthlyData.length == 12);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final int currentSelectedYear = selectedYear ?? DateTime.now().year;
    final labels = monthLabels ?? _shortMonthLabels(context);
    final headerTitle =
        title ?? l10n?.requestTrendBreakdown ?? 'Request Trend Breakdown';
    final metricLabel =
        metric ?? l10n?.chartMetricTotalTickets ?? 'Total Tickets';

    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE7F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.insert_chart_outlined,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    headerTitle,
                    textAlign: TextAlign.start,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: currentTheme.fontSizes.s16,
                    ),
                  ),
                ),
                if (yearOptions != null)
                  IntrinsicWidth(
                    child: KDropdownField<int>(
                      value: currentSelectedYear,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsetsDirectional.only(
                          start: 10,
                          end: 6,
                          top: 8,
                          bottom: 8,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC1C7D0)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFC1C7D0)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Colors.black54,
                      ),
                      items: yearOptions!
                          .map<KDropdownItem<int>>(
                            (opt) => KDropdownItem<int>(
                              value: opt,
                              child: Text(opt.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: onYearChanged,
                    ),
                  )
                else
                  _YearDropdown(
                    label: currentSelectedYear.toString(),
                    onTap: onYearTap,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(thickness: 1, color: const Color(0xFFE5E7EB)),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  metricLabel,
                  style: textTheme.bodyMedium?.copyWith(
                    color: currentTheme.colors.secondary,
                    fontWeight: currentTheme.fontWeights.wRegular,
                    fontSize: currentTheme.fontSizes.s12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.8,
              child: _RequestTrendBarChart(
                data: monthlyData,
                barColor: barColor,
                labels: labels,
                selectedYear: currentSelectedYear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestTrendBarChart extends StatefulWidget {
  final List<int> data;
  final Color barColor;
  final List<String> labels;
  final int selectedYear;

  const _RequestTrendBarChart({
    required this.data,
    required this.barColor,
    required this.labels,
    required this.selectedYear,
  });

  @override
  State<_RequestTrendBarChart> createState() => _RequestTrendBarChartState();
}

class _RequestTrendBarChartState extends State<_RequestTrendBarChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';
    final maxDataValue = widget.data.reduce((a, b) => a > b ? a : b);
    final maxValue = maxDataValue == 0 ? 2 : maxDataValue;
    final maxY = maxValue.toDouble();

    double calculateInterval(double maxY) {
      if (maxY <= 0) return 1;
      if (maxY <= 5) return 1;
      if (maxY <= 12) return 2;
      if (maxY <= 25) return 5;
      if (maxY <= 50) return 10;
      if (maxY <= 100) return 20;
      if (maxY <= 250) return 50;
      if (maxY <= 500) return 100;
      return (maxY / 5).ceilToDouble();
    }

    final yTitles = SideTitles(
      reservedSize: 32,
      showTitles: true,
      interval: calculateInterval(maxY),
      getTitlesWidget: (value, _) => Text(
        value.toInt().toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: currentTheme.fontSizes.s12,
          color: const Color(0xFF9CA3AF),
        ),
      ),
    );

    return BarChart(
      BarChartData(
        maxY: maxValue.toDouble(),
        barGroups: List.generate(12, (i) {
          final dataIndex = isRtl ? 11 - i : i;
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: widget.data[dataIndex].toDouble(),
                color: widget.barColor,
                width: 20.toAutoScaledWidth,
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
                rodStackItems: [],
              ),
            ],
          );
        }),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: isRtl ? SideTitles(showTitles: false) : yTitles,
          ),
          rightTitles: AxisTitles(
            sideTitles: isRtl ? yTitles : SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final idx = value.toInt().clamp(0, 11);
                final labelIdx = isRtl ? 11 - idx : idx;
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.labels[labelIdx],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: currentTheme.fontSizes.s12,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.white,
            tooltipBorderRadius: BorderRadius.circular(8.toAutoScaledWidth),
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = isRtl ? 11 - groupIndex : groupIndex;
              final month = widget.labels[idx];
              final value = widget.data[idx];
              return BarTooltipItem(
                '$month, ${widget.selectedYear} : $value',
                const TextStyle(
                  color: Color(0xFF282357),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _YearDropdown extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _YearDropdown({required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC1C7D0)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
