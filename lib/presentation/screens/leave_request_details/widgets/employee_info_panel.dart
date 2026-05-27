part of '../view.dart';

class EmployeeInfoPanel extends StatelessWidget {
  final String requestId;
  final bool isLeaveRequest;
  final String contactNumber;
  final String? leaveType;
  final String? employeeId;
  final String? jobTitle;
  final String? email;
  final String? departmentName;
  final String? statusLabel;

  const EmployeeInfoPanel({
    super.key,
    required this.requestId,
    required this.isLeaveRequest,
    required this.contactNumber,
    this.leaveType,
    this.employeeId,
    this.jobTitle,
    this.email,
    this.departmentName,
    this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    final user = KAppX.globalProvider.read(userProvider);

    Widget infoRow(String label, IconData icon, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s13,
              color: const Color(0xFF757A90),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, color: const Color(0xFF23272F), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B4260),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFECECF0), width: 1),
      ),
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          leading: const Icon(
            Icons.people_alt_outlined,
            color: Color(0xFF23272F),
            size: 22,
          ),
          title: Text(
            'Employee Information',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: currentTheme.fontSizes.s16,
              color: const Color(0xFF23272F),
            ),
          ),
          children: [
            const Divider(color: Color(0xFFECECF0), height: 1, thickness: 1),
            const SizedBox(height: 16),
            infoRow('Request ID', Icons.badge_outlined, requestId),
            infoRow(
              'Employee ID',
              Icons.person_outline,
              employeeId ?? user?.employeeId ?? '',
            ),
            infoRow(
              'Job Title / Designation',
              Icons.work_outline,
              jobTitle ?? user?.designationName ?? '',
            ),
            infoRow(
              'Email Address',
              Icons.email_outlined,
              email ?? user?.email ?? '',
            ),
            infoRow(
              'Department',
              Icons.business_outlined,
              departmentName ?? user?.departmentName ?? '',
            ),
            infoRow('Contact Number', Icons.phone_outlined, contactNumber),
            if (isLeaveRequest && (leaveType?.isNotEmpty ?? false))
              infoRow('Leave Type', Icons.flight_takeoff_outlined, leaveType!),
            if (statusLabel?.isNotEmpty == true)
              infoRow('Status', Icons.info_outline, statusLabel!),
          ],
        ),
      ),
    );
  }
}
