part of '../../screens/leave_request/view.dart';

class StatSummaryData {
  final String title;
  // final String count;
  final String description;
  final IconData icon;
  final Color iconBgColor;

  StatSummaryData({
    required this.title,
    // required this.count,
    required this.description,
    required this.icon,
    required this.iconBgColor,
  });
}

class StatSummaryRow extends StatelessWidget {
  final List<StatSummaryData> stats;
  final List<String> counts;
  final double spacing;
  final double runSpacing;

  const StatSummaryRow({
    super.key,
    required this.stats,
    required this.counts,
    this.spacing = 12,
    this.runSpacing = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Try to fit 2 cards per row with spacing, clamp for mobile/large
          final cardMaxWidth = ((constraints.maxWidth - spacing) / 2)
              .clamp(120, 180)
              .toDouble();

          return Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            alignment: WrapAlignment.start,
            textDirection: Directionality.of(context),
            children: List.generate(stats.length, (index) {
              // Use index to grab the matching count
              final data = stats[index];
              final count = (index < counts.length) ? counts[index] : '0';
              // Default to '0' or empty string if mismatched length

              return StatSummaryCard(
                data: data,
                maxWidth: cardMaxWidth,
                count: count,
              );
            }),
          );
        },
      ),
    );
  }
}

class StatSummaryCard extends StatelessWidget {
  final StatSummaryData data;
  final double maxWidth;
  final String count;

  const StatSummaryCard({
    super.key,
    required this.data,
    required this.maxWidth,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth:
            110.toAutoScaledWidth, // allow smaller cards on very small devices
        maxWidth: maxWidth,
      ),
      child: Card(
        color: currentTheme.colors.onPrimary,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.toAutoScaledWidth,
            vertical: 12.toAutoScaledHeight,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: currentTheme.fontSizes.s14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      count,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: currentTheme.fontSizes.s20,
                          ),
                    ),
                    // const SizedBox(height: 2),
                    // Text(
                    //   data.description,
                    //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    //     color: Colors.grey[400],
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: currentTheme.fontSizes.s12,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 9, top: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: data.iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(9),
                  child: Icon(
                    data.icon,
                    color: const Color(0xFF23272F),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
