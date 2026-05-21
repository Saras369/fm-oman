part of '../view.dart';

class TabViewPassport extends StatelessWidget {
  final _ViewState state;
  final _VsController stateController;
  final Widget? mobileMiddleWidget;

  const TabViewPassport({
    super.key,
    required this.state,
    required this.stateController,
    this.mobileMiddleWidget,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'Request Details',
      'Routing History',
      'Attachments',
      'Workflows',
    ];

    final iconMapping = <IconData>[
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
            return PassportRequestDetailsTab(state: state);
          case 1:
            return _PassportComment(
              entries: stateController.createChatList(),
              state: state,
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
            return PassportRequestDetailsTab(state: state);
        }
      },
    );
  }
}
