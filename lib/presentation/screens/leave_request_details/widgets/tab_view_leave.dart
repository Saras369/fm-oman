part of '../view.dart';

class TabViewLeave extends StatelessWidget {
  final _ViewState state;
  final _VsController stateController;
  final Widget? mobileMiddleWidget;

  const TabViewLeave({
    super.key,
    required this.state,
    required this.stateController,
    this.mobileMiddleWidget,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'Request Details',
      'Routing History',
      'Attachments',
      'Workflow',
    ];

    const iconMapping = [
      Icons.description_outlined,
      Icons.history_outlined,
      Icons.attach_file,
      Icons.work_outline,
    ];

    return ServiceDetailsTabShell(
      tabLabels: tabs,
      tabIcons: iconMapping,
      mobileMiddleWidget: mobileMiddleWidget,
      pageBuilder: (context, index) {
        switch (index) {
          case 0:
            return LeaveRequestDetailsTab(state: state);
          case 1:
            return _LeaveCommentsList(
              entries: stateController.createChatList(),
              stateController: stateController,
            );
          case 2:
            return FileListViewMobile(
              files: stateController.createAttachmentsList(),
            );
          case 3:
            return RequestWorkflowTimeline(
              steps: stateController.createWorkflowList(),
            );
          default:
            return LeaveRequestDetailsTab(state: state);
        }
      },
    );
  }
}
