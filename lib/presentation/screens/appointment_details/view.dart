import 'package:auto_route/auto_route.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

part 'widgets/appointment_details.dart';
part 'widgets/meeting_information.dart';
part 'widgets/attendees_information.dart';

@RoutePage()
class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppointmentDetailsWidget(
              meetingTitle: 'Budget Review Meeting',
              status: 'Scheduled',
              meetingType: 'Meeting',
              description:
                  'Quarterly budget review and planning session for Q2 2025. We will discuss budget allocation, expense reports, and future financial projections.',
              postedDate: '12 Aug, 2025',
              postedTime: '07:00 AM',
              departments: 'All Departments',
              contact: '++XXX-XXX-XXX-XX',
              email: 'name@Companymail.com',
            ),

            MeetingInformationWidget(
              scheduledDate: '14-08-2025',
              timeRange: '10:30 AM - 12:30 PM',
              attendeesCount: '25 Members',
              contact: '+XXX-XXX-XXX-XX',
              meetingType: 'Online',
              meetingLocation: 'Embassy',
              files: 'N/A',
              hodApprovalStatus: 'Approved',
              approverName: 'Sarah Johnson',
              approverEmail: 'username@Company.com',
              approverInitials: 'SJ',
              onJoinMeeting: () {
                // Navigate to video meeting or launch meeting URL
              },
              organizedBy: 'Executive Team',
            ),
            AttendeesInformationWidget(
              attendees: [
                "Ahmed Saeed Al-Harthy",
                "Salma Khalifa Al-Mahri",
                "Yousuf Said Al-Mawali",
                "Fatima Zahir Al-Riyami",
                "Salma Khalifa Al-Mahri",
                "Nasser Abdullah Al-Hinai",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
