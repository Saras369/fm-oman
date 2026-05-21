import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceLegend {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  const AttendanceLegend(this.label, this.icon, this.bgColor, this.iconColor);
}

// Legend configuration, in correct order
const List<AttendanceLegend> legends = [
  AttendanceLegend(
    'Present',
    Icons.local_parking,
    Color(0xFFF0F8F4),
    Color(0xFF4FA671),
  ),
  AttendanceLegend(
    'Absent',
    Icons.change_history_sharp,
    Color(0xFFFEEAEA),
    Color(0xFFD37569),
  ),
  AttendanceLegend('Off', Icons.circle, Color(0xFFF7F7F7), Color(0xFF262727)),
  AttendanceLegend('Leave', Icons.block, Color(0xFFF8F9FC), Color(0xFF2E3B4E)),
  AttendanceLegend(
    'On Duty',
    Icons.change_history,
    Color(0xFFFFF9EA),
    Color(0xFFE8B924),
  ),
  AttendanceLegend(
    'Holiday',
    Icons.home_outlined,
    Color(0xFFF0F8F6),
    Color(0xFF7CC285),
  ),
  AttendanceLegend(
    'Alert for Deduction',
    Icons.warning_amber_outlined,
    Color(0xFFFFF9F2),
    Color(0xFFE6B166),
  ),
  AttendanceLegend(
    'Status Unknown',
    Icons.help_outline,
    Color(0xFFFFEDEA),
    Color(0xFFD16B5B),
  ),
  AttendanceLegend(
    'Overtime',
    Icons.access_time,
    Color(0xFFF7F6FF),
    Color(0xFF7A6FED),
  ),
  AttendanceLegend(
    'Regularized',
    Icons.change_history_outlined,
    Color(0xFFF7FAFF),
    Color(0xFF6E89CF),
  ),
];

// Map highlighted date to legend index/instance
final Map<DateTime, int> specialDays = {
  DateTime(2025, 9, 28): 9, // Regularized icon
  DateTime(2025, 9, 5): 1, // Absent icon
  // Add more dates as needed
};

String _monthName(int n) {
  const names = [
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
  return (n >= 1 && n <= 12) ? names[n - 1] : '';
}

// Legend Tile
class LegendTile extends StatelessWidget {
  final AttendanceLegend legend;
  const LegendTile({super.key, required this.legend});
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: legend.bgColor,
            borderRadius: BorderRadius.circular(7),
          ),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: 7),
          child: Icon(legend.icon, color: legend.iconColor, size: 17),
        ),
        Flexible(
          fit: FlexFit.loose, // Allow text to take only necessary width
          child: Text(
            legend.label,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s14,
              color: Color(0xFF303236),
            ),
          ),
        ),
      ],
    );
  }
}

// Legend Grid
class LegendsPanel extends StatelessWidget {
  const LegendsPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: currentTheme.colors.onPrimary,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.legendsView,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: currentTheme.fontSizes.s18,
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                children: List.generate(
                  legends.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12),
                    child: LegendTile(legend: legends[index]),
                  ),
                ),
              ),

              // LayoutBuilder(
              //   builder: (context, constraints) {
              //     return SizedBox(
              //       height: 60,
              //       width: constraints.maxWidth,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: legends.length,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.only(right: 12),
              //             child: LegendTile(legend: legends[index]),
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendMarker {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  LegendMarker(this.icon, this.bgColor, this.iconColor);
}

// Example legend days map for special markers/colors
final Map<DateTime, LegendMarker> legendDays = {
  DateTime(2025, 9, 26): LegendMarker(
    Icons.change_history_outlined,
    Color(0xFFF7FAFF),
    Color(0xFF6E89CF),
  ),
  DateTime(2025, 9, 28): LegendMarker(
    Icons.change_history_sharp,
    Color(0xFFFEEAEA),
    Color(0xFFD37569),
  ),
};
