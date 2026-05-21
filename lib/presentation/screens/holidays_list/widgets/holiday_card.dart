part of '../view.dart';

// class Holiday {
//   final DateTime date;
//   final String name;
//   final String? note; // for things like (Season)
//   const Holiday({required this.date, required this.name, this.note});
// }

// Month name utility for brevity
String _monthName(int month) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return months[month - 1];
}

// Dummy data for demo
// final Map<String, List<Holiday>> holidaysByMonth = {
//   'January': [
//     Holiday(date: DateTime(2025, 1, 1), name: "New Year's Day"),
//     Holiday(date: DateTime(2025, 1, 27), name: "Isra & Mi'raj"),
//   ],
//   'March': [Holiday(date: DateTime(2025, 3, 31), name: "Eid al Fitr")],
//   'April': [
//     Holiday(date: DateTime(2025, 4, 1), name: "Eid al Fitr"),
//     Holiday(date: DateTime(2025, 4, 2), name: "Eid al Fitr"),
//   ],
//   'June': [
//     Holiday(date: DateTime(2025, 6, 5), name: "Eid al-Adha"),
//     Holiday(date: DateTime(2025, 6, 7), name: "Eid al-Adha"),
//     Holiday(date: DateTime(2025, 6, 8), name: "Eid al-Adha"),
//     Holiday(date: DateTime(2025, 6, 9), name: "Eid al-Adha"),
//   ],
//   'September': [
//     Holiday(date: DateTime(2025, 9, 5), name: "The Prophet's Birthday"),
//   ],
//   'November': [Holiday(date: DateTime(2025, 11, 18), name: "National Day")],
//   'December': [
//     Holiday(
//       date: DateTime(2025, 12, 21),
//       name: "December Solstice",
//       note: "(Season)",
//     ),
//   ],
// };

// The holiday row for each date
Widget holidayRow(
  Holiday holiday, {
  bool colored = false,
  bool highlight = false,
}) {
  final currentTheme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;
  final holidayDate = holiday.holidayDate != null
      ? DateTime.parse(holiday.holidayDate ?? '')
      : DateTime.now();
  return Container(
    color: highlight
        ? const Color(0xFFF5FEE7)
        : colored
        ? const Color(0xFFFCF6EE)
        : null,
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date
          SizedBox(
            width: 74,
            child: Text(
              "${holidayDate.day.toString().padLeft(2, '0')} ${_monthName(holidayDate.month).substring(0, 3)}, ${holidayDate.year}",
              style: TextStyle(
                fontSize: currentTheme.fontSizes.s13,
                color: Color(0xFF747487),
              ),
            ),
          ),
          // Colored bar
          Container(
            width: 4,
            height: 19,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: highlight
                  ? const Color(0xFF4ECB71)
                  : const Color(0xFFF5B955),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // Holiday name (with note), fully expandable
          Expanded(
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    holiday.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: currentTheme.fontSizes.s14,
                    ),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (holiday.description != null)
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        " ${holiday.description!}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: currentTheme.fontSizes.s13,
                          color: Color(0xFF2AA361),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Day, force wrap or ellipsis if space tight
          SizedBox(
            width: 78,
            child: Text(
              weekDay(holidayDate.weekday),
              textAlign: TextAlign.end,
              style: TextStyle(
                color:
                    holidayDate.weekday == DateTime.friday ||
                        holidayDate.weekday == DateTime.sunday
                    ? Colors.red[300]!
                    : const Color(0xFFB3B8BF),
                fontWeight: FontWeight.w600,
                fontSize: currentTheme.fontSizes.s13,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String weekDay(int n) {
  const short = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  return short[n - 1];
}

// Main list widget
class HolidaysListPage extends ConsumerWidget {
  // final List<Holiday>? holidays; // Pass this from your API/model

  const HolidaysListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightMonth = "December";
    final highlightName = "December Solstice";

    // Group holidays by month name (from createdAt or use holidayDate)
    final state = ref.watch(_vsProvider);
    final holidays = state.holidayModel.data ?? [];
    final Map<String, List<Holiday>> groupedHolidays = {};
    (holidays ?? []).forEach((holiday) {
      if (holiday.createdAt != null) {
        final month = _monthName(holiday.createdAt!.month);
        groupedHolidays.putIfAbsent(month, () => []).add(holiday);
      }
    });

    return Card(
      margin: const EdgeInsets.all(13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 10, 6, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.insert_invitation,
                  size: 18,
                  color: Color(0xFF202235),
                ),
                SizedBox(width: 7),
                Text(
                  'Holidays List',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ...groupedHolidays.entries.map((entry) {
              final month = entry.key;
              final holidays = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 3),
                    child: Text(
                      month,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF7A7A7A),
                      ),
                    ),
                  ),
                  ...holidays.asMap().entries.map(
                    (entryh) => holidayRow(
                      entryh.value,
                      colored:
                          entryh.key.isOdd &&
                          !(month == highlightMonth &&
                              entryh.value.title == highlightName),
                      highlight:
                          (month == highlightMonth &&
                          entryh.value.title == highlightName),
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
