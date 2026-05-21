part of '../view.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final String meetingTitle;
  final String status;
  final String meetingType;
  final String description;
  final String postedDate;
  final String postedTime;
  final String departments;
  final String contact;
  final String email;

  const AppointmentDetailsWidget({
    required this.meetingTitle,
    required this.status,
    required this.meetingType,
    required this.description,
    required this.postedDate,
    required this.postedTime,
    required this.departments,
    required this.contact,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meetingTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(status),
                  backgroundColor: Colors.orange[50],
                  labelStyle: TextStyle(color: Colors.orange[900]),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text(meetingType),
                  backgroundColor: Colors.amber[50],
                  labelStyle: TextStyle(color: Colors.amber[900]),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[700]),
                SizedBox(width: 6),
                Text(
                  '$postedDate | $postedTime',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              departments,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text(contact, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    email,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
