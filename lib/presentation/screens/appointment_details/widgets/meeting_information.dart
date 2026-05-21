part of '../view.dart';

class MeetingInformationWidget extends StatelessWidget {
  final String scheduledDate;
  final String timeRange;
  final String attendeesCount;
  final String contact;
  final String meetingType;
  final String meetingLocation;
  final String files;
  final String hodApprovalStatus; // E.g. 'Approved' or 'Pending'
  final String approverName;
  final String approverEmail;
  final String approverInitials;
  final String organizedBy;

  final VoidCallback? onJoinMeeting; // Join button callback

  const MeetingInformationWidget({
    required this.scheduledDate,
    required this.timeRange,
    required this.attendeesCount,
    required this.contact,
    required this.meetingType,
    required this.meetingLocation,
    required this.files,
    required this.hodApprovalStatus,
    required this.approverName,
    required this.approverEmail,
    required this.approverInitials,
    required this.organizedBy,
    this.onJoinMeeting,
    Key? key,
  }) : super(key: key);

  Color _approvalColor() {
    if (hodApprovalStatus.toLowerCase() == 'approved') {
      return Colors.green.shade100;
    } else {
      return Colors.orange.shade100;
    }
  }

  IconData _approvalIcon() {
    if (hodApprovalStatus.toLowerCase() == 'approved') {
      return Icons.check_circle_outline;
    } else {
      return Icons.pending_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Card(
      color: currentTheme.colors.onPrimary,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Title & Join Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meeting Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: onJoinMeeting,
                  icon: Icon(Icons.video_call_outlined),
                  label: Text('Join Meeting'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: currentTheme.colors.onPrimary,
                  ),
                ),
              ],
            ),

            Divider(height: 20, thickness: 1),

            // Info Details Grid
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                _IconText(
                  Icons.calendar_today,
                  "Scheduled Date",
                  scheduledDate,
                ),
                _IconText(Icons.access_time_filled, "Time", timeRange),
                _IconText(Icons.people_outline, "Attendees", attendeesCount),
                _IconText(Icons.phone, "Contact", contact),
                _IconText(Icons.videocam_outlined, "Meeting Type", meetingType),
                _IconText(
                  Icons.location_on_outlined,
                  "Meeting Location",
                  meetingLocation,
                ),
                _IconText(Icons.insert_drive_file_outlined, "Files", files),
                _IconText(Icons.person, "Organized By", organizedBy),
              ],
            ),

            SizedBox(height: 16),

            Text("HOD Approval Status"),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: _approvalColor(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_approvalIcon(), color: Colors.green, size: 18),
                  SizedBox(width: 6),
                  Text(
                    hodApprovalStatus,
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Text("Approver", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.pink.shade300,
                  child: Text(
                    approverInitials,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      approverName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      approverEmail,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _IconText(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
