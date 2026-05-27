part of '../view.dart';

class _LeaveCommentsList extends StatelessWidget {
  final List<CommentEntryModel> entries;
  final _VsController stateController;

  const _LeaveCommentsList({
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
            const Row(
              children: [
                Icon(Icons.history, color: Colors.black87, size: 18),
                SizedBox(width: 8),
                Text(
                  'Comments / Routing Overview',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            if (entries.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('No routing history yet')),
              )
            else
              ...entries.map((entry) => CommentEntry(data: entry)),
            AddCommentBox(
              controller: stateController.commentController,
              showApprovalActions: stateController.canApproveOrReject,
              onAttach: () {},
              onSend: stateController.addComment,
              onApprove: stateController.approveRequest,
              onReject: stateController.rejectRequest,
            ),
          ],
        ),
      ),
    );
  }
}
