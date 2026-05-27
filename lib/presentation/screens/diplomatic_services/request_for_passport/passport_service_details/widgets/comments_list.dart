part of '../view.dart';

class _PassportComment extends StatelessWidget {
  final _ViewState state;
  final _VsController stateController;
  final List<CommentEntryModel> entries;

  const _PassportComment({
    required this.entries,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

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
                Icon(Icons.history, color: Colors.black87, size: 18),
                SizedBox(width: 8),
                Text(
                  "Comments / Routing Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: currentTheme.fontSizes.s16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            // Comments List
            ...entries.map((entry) => CommentEntry(data: entry)),
            
            // In the implementation plan, user confirmed "comments are read-only for now, or just mirror whatever Financial Services does".
            // Since we don't have an endpoint for passport comments, we will render the AddCommentBox 
            // but the add logic inside the controller simply clears the field.
            AddCommentBox(
              controller: stateController.commentController,
              showApprovalActions: false,
              onAttach: () {
                /* Attach callback */
              },
              onSend: () {
                stateController.addCommentInPassportRequest();
              },
            ),
          ],
        ),
      ),
    );
  }
}
