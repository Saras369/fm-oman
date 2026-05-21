part of '../view.dart';

class TabViewFinance extends StatelessWidget {
  final _ViewState state;
  final _VsController stateController;
  const TabViewFinance({
    super.key,
    required this.state,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    // final commentsList = [
    //   CommentEntryModel(
    //     userName: "Me",
    //     userInitials: "ME",
    //     isSelf: true,
    //     message: "Leave request submitted for the Approval",
    //     status: CommentStatus.pending,
    //     statusLabel: "Pending",
    //     time: "14 Aug 2025 | 10:20 AM",
    //   ),
    //   CommentEntryModel(
    //     userName: "Manager",
    //     userInitials: "MM",
    //     isSelf: false,
    //     message: "Reviewing request  with Assigned Team.",
    //     status: CommentStatus.pending,
    //     statusLabel: "Pending",
    //     time: "15 Aug 2025 | 12:20 AM",
    //   ),
    //   CommentEntryModel(
    //     userName: "Manager",
    //     userInitials: "MM",
    //     isSelf: false,
    //     message: "Request status changed to: Pending Validation",
    //     status: CommentStatus.validating,
    //     statusLabel: "Validating",
    //     time: "15 Aug 2025 | 16:20 PM",
    //   ),
    // ];

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return DefaultTabController(
      length: 4,
      child: Card(
        color: currentTheme.colors.onPrimary,
        // margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: currentTheme.colors.onPrimary,
                ),
                child: TabBar(
                  tabAlignment: TabAlignment.start,

                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: const Color(0xFF6B6E7E),
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  tabs: [
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 12.toAutoScaledWidth,
                      ),
                      child: Tab(
                        child: Text(
                          "Request Details",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 12.toAutoScaledWidth,
                      ),

                      child: Tab(
                        child: Text(
                          "Request History",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 12.toAutoScaledWidth,
                      ),

                      child: Tab(
                        child: Text(
                          "Attachments",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 12.toAutoScaledWidth,
                      ),

                      child: Tab(
                        child: Text(
                          "Workflow",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // If height: 900 is for demo, use Expanded/Flexible here for real app use
              SizedBox(
                height: 900,
                child: TabBarView(
                  children: [
                    _RequestDetailsAttendanceServices(state: state),
                    _AttendanceComment(
                      entries: stateController.createChatList(),
                      state: state,
                      stateController: stateController,
                    ),
                    FileListViewMobile(
                      files: stateController.createAttachmentsList(),
                    ),
                    RequestWorkflowTimeline(
                      steps: stateController.createWorkflowList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
