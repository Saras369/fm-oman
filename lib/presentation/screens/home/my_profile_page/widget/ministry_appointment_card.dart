part of '../view.dart';

class Appointment {
  final String period; // Morning/Noon/Evening
  final String time;
  final String title;
  final String subtitle;
  final String sessionTime;
  final Color barColor;
  final Color bgColor;

  Appointment({
    required this.period,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.sessionTime,
    required this.barColor,
    required this.bgColor,
  });
}

// Demo data for a day
final List<Appointment> appointments = [
  Appointment(
    period: 'Morning',
    time: '12:00 PM',
    title: 'AM Routine',
    subtitle: 'No Conferencing',
    sessionTime: '08:00 - 09:00 AM',
    barColor: Color(0xFFE5B15C),
    bgColor: Color(0xFFFEFAF1),
  ),
  Appointment(
    period: 'Noon',
    time: '12:00 PM',
    title: 'AM Routine',
    subtitle: 'No Conferencing',
    sessionTime: '08:00 - 09:00 AM',
    barColor: Color(0xFF5CC17B),
    bgColor: Color(0xFFF5FCF8),
  ),
  Appointment(
    period: 'Evening',
    time: '04:30 PM',
    title: 'AM Routine',
    subtitle: 'No Conferencing',
    sessionTime: '08:00 - 09:00 AM',
    barColor: Color(0xFF5CC17B),
    bgColor: Color(0xFFF5FCF8),
  ),
];

class MinistryAppointmentsCard extends StatefulWidget {
  const MinistryAppointmentsCard({super.key});
  @override
  State<MinistryAppointmentsCard> createState() =>
      _MinistryAppointmentsCardState();
}

class _MinistryAppointmentsCardState extends State<MinistryAppointmentsCard> {
  DateTime selectedDate = DateTime(2025, 8, 28);

  void _goToNext() =>
      setState(() => selectedDate = selectedDate.add(Duration(days: 1)));
  void _goToPrevious() =>
      setState(() => selectedDate = selectedDate.subtract(Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Group appointments by period (Morning/Noon/Evening)
    final periods = ['Morning', 'Noon', 'Evening'];
    Map<String, Appointment> grouped = {
      for (var p in periods)
        p: appointments.firstWhere(
          (a) => a.period == p,
          orElse: () => null as Appointment,
        ),
    };
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.menu, size: 23, color: Color(0xFF182230)),
                SizedBox(width: 8),
                Text(
                  'Ministry Appointments',
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF23253B),
                  ),
                ),
                Spacer(),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFD3D7E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    foregroundColor: Colors.black87,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: currentTheme.fontSizes.s12,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 14.toAutoScaledWidth,
                    color: Color(0xFF23252D),
                  ),
                  label: Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 14),
            // Date Row
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 21.toAutoScaledWidth,
                  color: Color(0xFF23253B),
                ),
                SizedBox(width: 7),
                Text(
                  selectedDate.formattedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: currentTheme.fontSizes.s14,
                    color: Color(0xFF23253B),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4EBD57),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 20.toAutoScaledWidth,
                        ),
                        onPressed: _goToPrevious,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          selectedDate.formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: currentTheme.fontSizes.s12,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),

                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 20.toAutoScaledWidth,
                        ),
                        onPressed: _goToNext,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            // Appointments by period
            ...periods.map((period) {
              final appointment = grouped[period];
              if (appointment == null) return SizedBox();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    period,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: currentTheme.fontSizes.s16,
                      color: Color(0xFF23253B),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    appointment.time,
                    style: TextStyle(
                      color: Color(0xFF23253B),
                      fontWeight: FontWeight.w500,
                      fontSize: currentTheme.fontSizes.s12,
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: appointment.bgColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 50,
                          decoration: BoxDecoration(
                            color: appointment.barColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appointment.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: currentTheme.fontSizes.s14,
                                    color: Color(0xFF23253B),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  appointment.subtitle,
                                  style: TextStyle(
                                    fontSize: currentTheme.fontSizes.s12,
                                    color: Color(0xFFB8BEBC),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.brightness_1,
                              size: 7,
                              color: Color(0xFF23253B),
                            ),
                            SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 11),
                              child: Text(
                                appointment.sessionTime,
                                style: TextStyle(
                                  color: Color(0xFF23253B),
                                  fontSize: currentTheme.fontSizes.s12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
