part of '../view.dart';

class _TabViewSecurity extends StatelessWidget {
  final _SecurityDetailsViewState state;
  final _SecurityDetailsController stateController;
  final Widget? mobileMiddleWidget;

  const _TabViewSecurity({
    required this.state,
    required this.stateController,
    this.mobileMiddleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsTabShell(
      tabLabels: const [
        'Request Details',
        'Routing History',
        'Attachments',
        'Workflows',
      ],
      tabIcons: const [
        Icons.description_outlined,
        Icons.history_outlined,
        Icons.attach_file,
        Icons.work_outline,
      ],
      mobileMiddleWidget: mobileMiddleWidget,
      pageBuilder: (context, index) {
        switch (index) {
          case 0:
            return _SecurityRequestDetails(state: state);
          case 1:
            return _SecurityComments(entries: stateController.createChatList());
          case 2:
            return FileListViewMobile(
              files: stateController.createAttachmentsList(),
            );
          case 3:
            return RequestWorkflowTimeline(
              steps: stateController.createWorkflowList(),
            );
          default:
            return _SecurityRequestDetails(state: state);
        }
      },
    );
  }
}
