part of '../view.dart';

// Data model for appointment/meeting
class MeetingInfo {
  final String title;
  final String status;
  final String type;
  final String description;
  final String scheduledDate;
  final String time;
  final String attendees;
  final String organizer;
  final String contact;
  final String meetingType;
  final String files;
  final String location;
  final String postedDate;
  final String departments;

  MeetingInfo({
    required this.title,
    required this.status,
    required this.type,
    required this.description,
    required this.scheduledDate,
    required this.time,
    required this.attendees,
    required this.organizer,
    required this.contact,
    required this.meetingType,
    required this.files,
    required this.location,
    required this.postedDate,
    required this.departments,
  });
}

// Chip widget for status/type
class _Chip extends StatelessWidget {
  final String text;
  final Color? color;
  const _Chip(this.text, {this.color, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color != null ? Colors.orange.shade900 : Colors.grey.shade900,
        ),
      ),
    );
  }
}

// Action buttons bar
class _CardActions extends StatelessWidget {
  final VoidCallback? onViewDetails;
  final VoidCallback? onExternal;
  const _CardActions({this.onViewDetails, this.onExternal, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
          ),
          icon: const Icon(
            Icons.remove_red_eye,
            color: Colors.black87,
            size: 20,
          ),
          label: const Text(
            "View Details",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          onPressed: onViewDetails,
        ),
        const SizedBox(width: 9),
        Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onExternal,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.open_in_new,
                size: 22,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Info row cell
class _InfoCell extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight? valueWeight;
  final VoidCallback? onTap;

  const _InfoCell({
    this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueWeight,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (icon != null)
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(icon, size: 20, color: Colors.grey.shade800),
        ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 1),
          GestureDetector(
            onTap: onTap,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: valueWeight ?? FontWeight.w600,
                color: valueColor ?? Colors.indigo,
                decoration: valueColor != null && valueColor != Colors.black
                    ? TextDecoration.underline
                    : null,
              ),
            ),
          ),
        ],
      ),
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

// Main card widget
class MeetingInfoCard extends StatelessWidget {
  final MeetingInfo meetingInfo;
  final VoidCallback? onViewDetails;
  final VoidCallback? onExternal;

  const MeetingInfoCard({
    super.key,
    required this.meetingInfo,
    this.onViewDetails,
    this.onExternal,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 2,
      // margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  meetingInfo.title,
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.toHorizontalSizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: meetingInfo.status == "Scheduled"
                        ? Colors.orange
                        : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    meetingInfo.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: currentTheme.fontSizes.s12,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(meetingInfo.type, style: TextStyle(fontSize: 12)),
                ),
                SizedBox(width: 8),
                Icon(Icons.remove_red_eye),
              ],
            ),
            SizedBox(height: 8),
            Text(
              meetingInfo.description,
              style: TextStyle(fontSize: currentTheme.fontSizes.s16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _MeetingInfoIconText(
                  icon: Icons.today,
                  text: "${meetingInfo.scheduledDate} ${meetingInfo.time}",
                ),
                _MeetingInfoIconText(
                  icon: Icons.people,
                  text: meetingInfo.attendees,
                ),
                _MeetingInfoIconText(
                  icon: Icons.person,
                  text: meetingInfo.organizer,
                ),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _MeetingInfoIconText(
                  icon: Icons.phone,
                  text: meetingInfo.contact,
                ),
                _MeetingInfoIconText(
                  icon: Icons.category,
                  text: meetingInfo.meetingType,
                ),
                _MeetingInfoIconText(
                  icon: Icons.file_present,
                  text: meetingInfo.files,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Location: ${meetingInfo.location}",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 6),
            Text(
              "Departments: ${meetingInfo.departments}",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 6),
            Text(
              "Posted: ${meetingInfo.postedDate}",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable ListView builder for cards
class MeetingInfoList extends StatelessWidget {
  final List<MeetingInfo> meetings;
  const MeetingInfoList({super.key, required this.meetings});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: meetings.length,
      itemBuilder: (context, idx) {
        return MeetingInfoCard(meetingInfo: meetings[idx]);
      },
    );
  }
}

// Usage example, pass to TabView etc.:
// MeetingInfoList(meetings: myMeetingList)

// Helper widget for icon + text
class _MeetingInfoIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MeetingInfoIconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: currentTheme.fontSizes.s14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
