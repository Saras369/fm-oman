part of '../view.dart';

class _AttendanceComment extends StatelessWidget {
  final _ViewState state;
  final _VsController stateController;
  final List<CommentEntryModel> entries;
  // final TextEditingController controller = TextEditingController();

  _AttendanceComment({
    super.key,
    required this.entries,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      // margin: const EdgeInsets.all(10),
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
            AddCommentBox(
              controller: stateController.commentController,
              onAttach: () {
                /* Attach callback */
              },
              onSend: () {
                /* Send callback */
                stateController.addCommentInFinRequest();
              },
              approve: () {},
              reject: () {},
            ),
          ],
        ),
      ),
    );
  }
}
