part of '../view.dart';

class LeaveBalanceData {
  final String title;
  final int used;
  final int total;
  final Color color;

  const LeaveBalanceData({
    required this.title,
    required this.used,
    required this.total,
    required this.color,
  });

  int get remaining => total - used;
}

class LeaveBalancesCard extends StatelessWidget {
  final List<LeaveBalanceData> balances;
  final int? year;
  const LeaveBalancesCard({
    super.key,
    required this.balances,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    final int currentYear = year ?? DateTime.now().year;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            _buildHeader(context, currentYear),
            const SizedBox(height: 12),
            Divider(thickness: 1, color: Colors.grey[300]),
            ...balances
                .map(
                  (data) => Column(
                    children: [
                      LeaveBalanceTile(data: data),
                      if (data != balances.last)
                        Divider(
                          thickness: 1,
                          color: Colors.grey[200],
                          height: 28,
                        ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int currentYear) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8E7F6),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(9),
          child: const Icon(
            Icons.table_rows_rounded,
            color: Color(0xFF6C71A1),
            size: 25,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "Leave Balances",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        _YearDropdown(label: currentYear.toString()),
      ],
    );
  }
}

class LeaveBalanceTile extends StatelessWidget {
  final LeaveBalanceData data;
  const LeaveBalanceTile({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final percent = data.total == 0 ? 0.0 : data.used / data.total;
    final theme = Theme.of(context);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and numbers row
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                "${data.used.toString().padLeft(2, '0')} / ${data.total.toString().padLeft(2, '0')}",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF5A627A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 7,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation(data.color),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data.used} Used",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.blueGrey[200],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${data.remaining} Remaining",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.blueGrey[200],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
