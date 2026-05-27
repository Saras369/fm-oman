part of '../view.dart';

class _AttendanceComment extends StatelessWidget {
  final _AttendanceDetailsController stateController;
  final List<CommentEntryModel> entries;

  const _AttendanceComment({
    required this.entries,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: Colors.black87, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Comments / Routing Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: currentTheme.fontSizes.s16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            ...entries.map((entry) => CommentEntry(data: entry)),
            AddCommentBox(
              controller: stateController.commentController,
              showApprovalActions: stateController.canApproveOrReject,
              attachedFileName: stateController.pendingFileName,
              onAttach: stateController.pickAndUploadAttachment,
              onSend: stateController.addCommentInAttendanceRequest,
              onApprove: stateController.approveRequest,
              onReject: stateController.rejectRequest,
            ),
          ],
        ),
      ),
    );
  }
}
