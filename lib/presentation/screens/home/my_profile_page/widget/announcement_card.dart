part of '../view.dart';

// Demo announcement data model

class Announcement {
  final String title;
  final String description;
  final String dateTime;
  final String? tag; // e.g., "High", "Medium", "Low"
  final Color? tagColor;

  Announcement({
    required this.title,
    required this.description,
    required this.dateTime,
    this.tag,
    this.tagColor,
  });
}

// Demo event/updates data
List<Announcement> events = [
  Announcement(
    title: 'Quarterly Meeting',
    description:
        'Review quarterly performance metrics, discuss upcoming initiatives, and address employee feedback.',
    dateTime: 'Posted on 12 Aug, 2025 | 07:00 AM',
    tag: 'High',
    tagColor: Color(0xFF4ECB71),
  ),
  Announcement(
    title: 'Annual Budget Review',
    description: 'Proin volutpat, sapien ut facilisis ultricies Proin',
    dateTime: 'Posted on 12 Aug, 2025 | 07:00 AM',
    tag: 'Medium',
    tagColor: Color(0xFFF5B955),
  ),
  Announcement(
    title: 'Training Workshop: Digital Security',
    description: 'Proin volutpat, sapien ut facilisis ultricies Proin',
    dateTime: 'Posted on 12 Aug, 2025 | 07:00 AM',
    tag: 'Low',
    tagColor: Color(0xFF4387EF),
  ),
];

List<Announcement> updates = [
  Announcement(
    title: 'Policy Update: Remote Work',
    description:
        'New guidelines issued about remote work for Q3. Kindly check HR portal for details.',
    dateTime: 'Posted on 10 Aug, 2025 | 01:00 PM',
    tag: 'Info',
    tagColor: Color(0xFF9BCAEC),
  ),
  Announcement(
    title: 'IT Maintenance',
    description:
        'System downtime planned for 18 Aug, between midnight and 2AM.',
    dateTime: 'Posted on 09 Aug, 2025 | 09:30 AM',
    tag: 'Alert',
    tagColor: Color(0xFFD16B5B),
  ),
];

// Main widget
class AnnouncementsCard extends StatefulWidget {
  const AnnouncementsCard({super.key});

  @override
  State<AnnouncementsCard> createState() => _AnnouncementsCardState();
}

class _AnnouncementsCardState extends State<AnnouncementsCard> {
  int tabIndex = 0; // 0=Events, 1=Updates

  List<Announcement> get currentData => tabIndex == 0 ? events : updates;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      color: currentTheme.colors.onPrimary,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 20,
                  color: Color(0xFF202235),
                ),
                SizedBox(width: 7),
                Text(
                  'Latest Announcements',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: currentTheme.fontSizes.s16,
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
                    size: 18.toAutoScaledWidth,
                    color: Color(0xFF23252D),
                  ),
                  label: Text('View All'),
                ),
              ],
            ),
            16.toVerticalSizedBox,
            // Tabs
            Row(
              children: [
                Expanded(
                  child: _AnnouncementTabButton(
                    selected: tabIndex == 0,
                    icon: Icons.calendar_today,
                    label: 'Events',
                    onTap: () => setState(() => tabIndex = 0),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _AnnouncementTabButton(
                    selected: tabIndex == 1,
                    icon: Icons.notifications,
                    label: 'Updates',
                    onTap: () => setState(() => tabIndex = 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Announcements list
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: currentData.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 18, color: Color(0xFFE8E9ED)),
              itemBuilder: (context, i) {
                final a = currentData[i];
                return _AnnouncementTile(a: a);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementTabButton extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AnnouncementTabButton({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        decoration: BoxDecoration(
          color: selected ? Colors.black : currentTheme.colors.onPrimary,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Color(0xFFD3D7E1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Color(0xFFB2B5C2),
              size: 16.toAutoScaledWidth,
            ),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Color(0xFF868991),
                fontWeight: FontWeight.w600,
                fontSize: currentTheme.fontSizes.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  final Announcement a;
  const _AnnouncementTile({required this.a});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title, Tag
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                a.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: currentTheme.fontSizes.s16,
                  color: Color(0xFF23253B),
                ),
              ),
            ),
            if (a.tag != null)
              Container(
                margin: EdgeInsets.only(left: 7, top: 1),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  color: a.tagColor?.withValues(alpha: 0.1) ?? Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  a.tag!,
                  style: TextStyle(
                    color: a.tagColor,
                    fontSize: currentTheme.fontSizes.s13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          a.description,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: currentTheme.fontSizes.s14,
            color: Color(0xFF868991),
          ),
        ),
        SizedBox(height: 6),
        Text(
          a.dateTime,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: currentTheme.fontSizes.s12,
            color: Color(0xFFB7BAC1),
          ),
        ),
      ],
    );
  }
}
