part of '../view.dart';

class AppointmentHeader extends StatefulWidget {
  const AppointmentHeader({super.key});
  @override
  State<AppointmentHeader> createState() => _AppointmentHeaderState();
}

class _AppointmentHeaderState extends State<AppointmentHeader> {
  int selectedTab = 0;

  String? selectedStatus;
  String? selectedType;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color surface = Colors.white;
    final Color border = const Color(0xFFE5E7EB);
    final Color mainRed = Colors.red.shade700;
    final Color mainGreen = Colors.green.shade700;
    final Color tabGrey = Colors.grey.shade200;
    final Color textGrey = Colors.grey.shade700;

    final myRequests = [
      AppointmentRequest(
        id: '001',
        name: 'Annual Leave',
        date: 'Aug 14, 2025',
        approver: 'Abdur Rahim',
        status: RequestStatus.approved,
      ),
      AppointmentRequest(
        id: '002',
        name: 'Casual Leave Request',
        date: 'Aug 11, 2025',
        approver: 'Fazlul Karim',
        status: RequestStatus.pending,
      ),
      AppointmentRequest(
        id: '003',
        name: 'Emergency Leave',
        date: 'Aug 10, 2025',
        approver: 'Inayatullah',
        status: RequestStatus.rejected,
      ),
      AppointmentRequest(
        id: '004',
        name: 'Casual Leave Request',
        date: 'Aug 10, 2025',
        approver: 'Farhaat',
        status: RequestStatus.approved,
      ),
    ];

    List<MeetingInfo> meetings = [
      MeetingInfo(
        title: "Marketing Update",
        status: "Scheduled",
        type: "Internal",
        description: "Monthly marketing performance review.",
        scheduledDate: "2025-09-28",
        time: "10:00 AM",
        attendees: "john@example.com, jane@example.com",
        organizer: "Alice Johnson",
        contact: "+91-12345-67890",
        meetingType: "Review",
        files: "presentation.pdf, agenda.docx",
        location: "Conference Room 3B",
        postedDate: "2025-09-25",
        departments: "Marketing, Sales",
      ),
      MeetingInfo(
        title: "Vendor Demo",
        status: "Completed",
        type: "External",
        description: "Demo session from X Corp on new analytics tools.",
        scheduledDate: "2025-09-24",
        time: "02:00 PM",
        attendees: "bob@example.com, carol@example.com",
        organizer: "Mark Smith",
        contact: "+91-23456-78901",
        meetingType: "Demo",
        files: "demo_video.mp4, brochure.pdf",
        location: "Online (Meet Link)",
        postedDate: "2025-09-23",
        departments: "IT, Procurement",
      ),
    ];

    return Material(
      color: surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab row
            Row(
              children: [
                _TabButton(
                  icon: Icons.calendar_today,
                  text: "My Appointments",
                  selected: selectedTab == 0,
                  selectedColor: mainRed,
                  unselectedColor: border,
                  onTap: () => setState(() => selectedTab = 0),
                  iconColor: selectedTab == 0 ? mainRed : textGrey,
                  textColor: selectedTab == 0 ? mainRed : textGrey,
                  fill: selectedTab == 0,
                ),
                const SizedBox(width: 10),
                _TabButton(
                  icon: Icons.list_alt,
                  text: "Action Items",
                  selected: selectedTab == 1,
                  selectedColor: mainRed,
                  unselectedColor: border,
                  onTap: () => setState(() => selectedTab = 1),
                  iconColor: selectedTab == 1 ? mainRed : textGrey,
                  textColor: selectedTab == 1 ? mainRed : textGrey,
                  fill: selectedTab == 1,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Responsive Wrap row for filters
            Wrap(
              runSpacing: 9,
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Search field
                Container(
                  // constraints: const BoxConstraints(
                  //   maxWidth: 220,
                  //   minWidth: 130,
                  // ),
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabGrey,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: tabGrey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.only(left: 10, right: 8),
                        child: const Icon(
                          Icons.search,
                          size: 19,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search by Name",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Status dropdown
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.toAutoScaledWidth,
                    minWidth: 130.toAutoScaledWidth,
                  ),
                  child: KDropdownField<String>(
                    items: [
                      KDropdownItem(value: "all", child: Text("All Status")),
                      KDropdownItem(value: "upcoming", child: Text("Upcoming")),
                      KDropdownItem(
                        value: "completed",
                        child: Text("Completed"),
                      ),
                    ],
                    value: selectedStatus,
                    hintText: "Select Status",
                    onChanged: (v) => setState(() => selectedStatus = v),
                  ),
                ),
                // Type dropdown
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200.toAutoScaledWidth,
                    minWidth: 130.toAutoScaledWidth,
                  ),
                  child: KDropdownField<String>(
                    items: [
                      KDropdownItem(value: "all", child: Text("All Types")),
                      KDropdownItem(value: "meeting", child: Text("Meeting")),
                      KDropdownItem(value: "call", child: Text("Call")),
                    ],
                    value: selectedType,
                    hintText: "Select Type",
                    onChanged: (v) => setState(() => selectedType = v),
                  ),
                ),
                // New Appointment button
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    icon: const Icon(Icons.add, size: 20, color: Colors.white),
                    label: const Text(
                      "New Appointment",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Tab body below the controls
            if (selectedTab == 0)
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - 350.toAutoScaledHeight,
                child: MeetingInfoList(meetings: meetings),
              )
            else
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - 350.toAutoScaledHeight,
                child: AppointmentRequestsCardMobile(actionItems: myRequests),
              ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for the tab button
class _TabButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final bool fill;

  const _TabButton({
    required this.icon,
    required this.text,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: fill ? selectedColor.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: selected ? selectedColor : unselectedColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 19, color: iconColor),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
