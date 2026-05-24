part of '../view.dart';

class _SecurityComments extends StatelessWidget {
  final List<CommentEntryModel> entries;

  const _SecurityComments({required this.entries});

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
            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'No comments found',
                  style: TextStyle(
                    color: currentTheme.colors.secondary.shade40,
                    fontWeight: currentTheme.fontWeights.wBold,
                  ),
                ),
              )
            else
              ...entries.map((entry) => CommentEntry(data: entry)),
          ],
        ),
      ),
    );
  }
}
