part of '../view.dart';

class RequestDetailsTabContent extends StatelessWidget {
  const RequestDetailsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusInfoCard(
            assignedTo: '',
            status: '',
            requestDate: '',
            approver: '',
            infoData: {},
          ),
          const SizedBox(height: 15),
          RequestInfoCard(requestFor: '', serviceType: '', description: ''),
          const SizedBox(height: 15),
          // _TechnicalDetailsCard(),
        ],
      ),
    );
  }
}

// Technical Details Card
// class _TechnicalDetailsCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = KAppX.globalProvider
//         .read(KAppX.theme.current)
//         .themeBox;

//     return Card(
//       color: currentTheme.colors.onPrimary,
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Color(0xFFF0F0F0)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Technical Details",
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
//             ),
//             const SizedBox(height: 12),
//             _RequestInfo(label: "Extension Number", value: "XXXXXXXXXX"),
//           ],
//         ),
//       ),
//     );
//   }
// }
