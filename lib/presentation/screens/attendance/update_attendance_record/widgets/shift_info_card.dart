part of '../view.dart';

class ShiftInfoCard extends StatelessWidget {
  final DateTime date;
  final String status;
  final String shiftTimings;
  final String checkInTime;
  final String checkOutTime;
  final String totalWorkingHours;
  final String excessHours;

  const ShiftInfoCard({
    super.key,
    required this.date,
    required this.status,
    required this.shiftTimings,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalWorkingHours,
    required this.excessHours,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(0),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 11),
                Text(
                  "Shift Information",
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2B2C),
                  ),
                ),
                const SizedBox(width: 12),
                if (status.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8F3DB),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF31B480),
                        fontSize: currentTheme.fontSizes.s14,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            _ShiftInfoTable(
              shiftTimings: shiftTimings,
              checkInTime: checkInTime,
              checkOutTime: checkOutTime,
              totalWorkingHours: totalWorkingHours,
              excessHours: excessHours,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      "${_monthString(d.month)} ${d.day.toString().padLeft(2, '0')}, ${d.year}";

  String _monthString(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}

class _ShiftInfoTable extends StatelessWidget {
  final String shiftTimings;
  final String checkInTime;
  final String checkOutTime;
  final String totalWorkingHours;
  final String excessHours;
  const _ShiftInfoTable({
    required this.shiftTimings,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalWorkingHours,
    required this.excessHours,
  });

  @override
  Widget build(BuildContext context) {
    // Single row, scrolls horizontally if too wide for screen
    final rows = [
      [
        "Shift Timings",
        "Check In Time",
        "Check Out Time",
        "Total Working Hours",
        "Excess Hours",
      ],
      [shiftTimings, checkInTime, checkOutTime, totalWorkingHours, excessHours],
    ];
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(rows.length, (rowIdx) {
            return Row(
              children: List.generate(rows[rowIdx].length, (colIdx) {
                final isHeader = rowIdx == 0;
                return Container(
                  width: 112,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 4,
                  ),
                  child: Text(
                    rows[rowIdx][colIdx],
                    style: TextStyle(
                      fontWeight: isHeader ? FontWeight.w500 : FontWeight.w600,
                      fontSize: isHeader
                          ? currentTheme.fontSizes.s13
                          : currentTheme.fontSizes.s14,
                      color: isHeader
                          ? Colors.grey[600]
                          : const Color(0xFF1A2B2D),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}

class SessionDetailSection extends StatelessWidget {
  final List<SessionDetail> sessions;
  const SessionDetailSection({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(0),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.coffee,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 11),
                Text(
                  "Session Details",
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...sessions
                .map((session) => _SessionTable(session: session))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class SessionDetail {
  final String name;
  final String sessionTiming;
  final String firstIn;
  final String lastOut;
  const SessionDetail({
    required this.name,
    required this.sessionTiming,
    required this.firstIn,
    required this.lastOut,
  });
}

class _SessionTable extends StatelessWidget {
  final SessionDetail session;
  const _SessionTable({required this.session});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final rows = [
      [session.name],
      ["Session Timing", "First In", "Last Out"],
      [session.sessionTiming, session.firstIn, session.lastOut],
    ];
    return Container(
      // margin: const EdgeInsets.only(bottom: 10, top: 8),
      padding: const EdgeInsets.only(bottom: 7),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFECECEC), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rows[0][0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: currentTheme.fontSizes.s16,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: List.generate(rows[1].length, (colIdx) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    rows[1][colIdx],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: currentTheme.fontSizes.s13,
                    ),
                  ),
                ),
              );
            }),
          ),
          Row(
            children: List.generate(rows[2].length, (colIdx) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    rows[2][colIdx],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF202528),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
