part of '../view.dart';

class ScrollableMonthBar extends ConsumerStatefulWidget {
  final DateTime initialDate;
  final Future<void> Function(DateTime monthDate)? onMonthChanged;

  const ScrollableMonthBar({
    super.key,
    required this.initialDate,
    this.onMonthChanged,
  });

  @override
  ConsumerState<ScrollableMonthBar> createState() => _ScrollableMonthBarState();
}

class _ScrollableMonthBarState extends ConsumerState<ScrollableMonthBar> {
  late DateTime currentMonth;
  late DateTime selectedDate;
  late ScrollController _scrollController;
  bool _isCurrentMonth = true;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    selectedDate = today;
    _isCurrentMonth =
        currentMonth.year == today.year && currentMonth.month == today.month;

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isCurrentMonth) {
        double offset = (selectedDate.day - 1) * 60.0;
        _scrollController.jumpTo(offset);
      }
    });
  }

  void _initScrollController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isCurrentMonth) {
        double offset = (widget.initialDate.day - 1) * 60.0;
        _scrollController.jumpTo(offset);
        selectedDate = widget.initialDate;
      } else {
        _scrollController.jumpTo(0);
      }
    });
  }

  void goToPrevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      selectedDate = DateTime(currentMonth.year, currentMonth.month, 1);
      final today = DateTime.now();
      _isCurrentMonth =
          currentMonth.year == today.year && currentMonth.month == today.month;
      _initScrollController();
    });
    widget.onMonthChanged?.call(currentMonth);
  }

  void goToNextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      selectedDate = DateTime(currentMonth.year, currentMonth.month, 1);
      final today = DateTime.now();
      _isCurrentMonth =
          currentMonth.year == today.year && currentMonth.month == today.month;
      _initScrollController();
    });
    widget.onMonthChanged?.call(currentMonth);
  }

  // Add data list holder
  List<AttendanceRecord>? attendanceRecords;

  // Add this helper to find the legend by label
  AttendanceLegend _getLegendForStatus(String? status) {
    final normalized = (status ?? '').trim().toLowerCase();
    if (normalized.isEmpty) {
      return legends.firstWhere((l) => l.label == 'Absent');
    }

    if (normalized == 'regularised') {
      return legends.firstWhere((l) => l.label == 'Regularized');
    }

    if (normalized == 'work_schedule' || normalized == 'work schedule') {
      return legends.firstWhere((l) => l.label == 'Work schedule');
    }

    return legends.firstWhere(
      (legend) => legend.label.toLowerCase() == normalized,
      orElse: () => legends.firstWhere((l) => l.label == 'Absent'),
    );
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth(DateTime date) {
      var firstDayThisMonth = DateTime(date.year, date.month, 1);
      var firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
      return firstDayNextMonth.difference(firstDayThisMonth).inDays;
    }

    int totalDays = daysInMonth(currentMonth);

    List<DateTime> monthDays = List.generate(
      totalDays,
      (index) => DateTime(currentMonth.year, currentMonth.month, index + 1),
    );

    String monthYearLabel = Jiffy.parseFromDateTime(
      currentMonth,
    ).format(pattern: 'MMM yyyy');
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final state = ref.watch(_vsProvider);
    attendanceRecords = state.attendanceData.attendanceRecords ?? [];
    final workSchedules = state.workSchedules;
    final holidays = state.holidays;
    final recordsByDate = <String, AttendanceRecord>{};
    for (final record in attendanceRecords ?? <AttendanceRecord>[]) {
      final date = record.attendanceDate;
      if (date != null && date.isNotEmpty) {
        recordsByDate[date] = record;
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
      decoration: BoxDecoration(
        color: currentTheme.colors.onPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with month/year and navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: goToPrevMonth,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      monthYearLabel,
                      style: TextStyle(
                        fontSize: currentTheme.fontSizes.s20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: goToNextMonth,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: monthDays.length,
              itemBuilder: (context, index) {
                DateTime day = monthDays[index];
                final dayKey =
                    '${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
                final record = recordsByDate[dayKey];
                final isHoliday = holidays.any(
                  (h) => _isDateWithinRange(day, h.fromDate, h.toDate),
                );
                final isWorkSchedule = workSchedules.any(
                  (w) => _isDateWithinRange(day, w.fromDate, w.toDate),
                );

                final isSelected =
                    selectedDate.year == day.year &&
                    selectedDate.month == day.month &&
                    selectedDate.day == day.day;

                final today = DateTime.now();
                final normalizedToday = DateTime(
                  today.year,
                  today.month,
                  today.day,
                );
                final normalizedDay = DateTime(day.year, day.month, day.day);
                final isFutureDay = normalizedDay.isAfter(normalizedToday);

                final AttendanceLegend? legend = record != null
                    ? _getLegendForStatus(record.attendanceStatus)
                    : isHoliday
                    ? _getLegendForStatus('Holiday')
                    : isWorkSchedule
                    ? _getLegendForStatus('Work schedule')
                    : isFutureDay
                    ? null
                    : _getLegendForStatus('Absent');

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 54,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff245a8e)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Jiffy.parseFromDateTime(day).format(pattern: 'E'),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff4d5c78),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: legend?.bgColor ?? Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: legend?.iconColor ?? const Color(0xff4d5c78),
                                  fontSize: currentTheme.fontSizes.s16,
                                ),
                              ),
                              if (legend != null) ...[
                                const SizedBox(width: 3),
                                Icon(
                                  legend.icon,
                                  color: legend.iconColor,
                                  size: 13.toAutoScaledWidth,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isDateWithinRange(DateTime day, String? from, String? to) {
    if (from == null || from.isEmpty) return false;
    final fromDate = DateTime.tryParse(from);
    final toDate = DateTime.tryParse(to ?? from);
    if (fromDate == null || toDate == null) return false;
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final start = DateTime(fromDate.year, fromDate.month, fromDate.day);
    final end = DateTime(toDate.year, toDate.month, toDate.day);
    return !normalizedDay.isBefore(start) && !normalizedDay.isAfter(end);
  }
}
