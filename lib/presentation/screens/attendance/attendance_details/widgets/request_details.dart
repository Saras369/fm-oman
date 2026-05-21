part of '../view.dart';

class _RequestDetailsAttendanceServices extends StatelessWidget {
  final _ViewState state;
  const _RequestDetailsAttendanceServices({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final reqDetails = state.requestDetails;
    final isData = reqDetails.isNotEmpty;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusInfoCard(
            assignedTo: 'Salary Section',
            status: isData ? reqDetails[0].requestStatus ?? '' : '',
            requestDate: isData
                ? DateTime.parse(
                    (reqDetails[0].requestDate) ?? '',
                  ).formattedDate
                : '',
            approver: '',
            infoData: {},
          ),
          const SizedBox(height: 15),
          RequestInfoCard(
            requestFor: '',
            serviceType: 'Financial Services',
            description: isData ? reqDetails[0].remarks ?? '' : '',
          ),
          const SizedBox(height: 15),
          // _TechnicalDetailsCard(),
        ],
      ),
    );
  }
}
