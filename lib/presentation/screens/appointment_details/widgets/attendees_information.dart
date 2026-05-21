part of '../view.dart';

class AttendeesInformationWidget extends StatefulWidget {
  final List<String> attendees;

  const AttendeesInformationWidget({required this.attendees, Key? key})
    : super(key: key);

  @override
  _AttendeesInformationWidgetState createState() =>
      _AttendeesInformationWidgetState();
}

class _AttendeesInformationWidgetState
    extends State<AttendeesInformationWidget> {
  bool _expanded = false;
  final int previewLimit = 5;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _expanded
        ? widget.attendees
        : widget.attendees.take(previewLimit).toList();
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, size: 20, color: Colors.black87),
                SizedBox(width: 8),
                Text(
                  "Attendees Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300, minHeight: 100),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayList.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 8, color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey[700], size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          displayList[index],
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (widget.attendees.length > previewLimit)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _toggleExpanded,
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  label: Text(_expanded ? "Show Less" : "View All"),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
