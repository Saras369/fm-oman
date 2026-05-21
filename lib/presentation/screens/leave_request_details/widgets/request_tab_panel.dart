part of '../view.dart';

class RequestTabsPanel extends StatelessWidget {
  const RequestTabsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final commentsList = [
      CommentEntryModel(
        userName: "Me",
        userInitials: "ME",
        isSelf: true,
        message: "Leave request submitted for the Approval",
        status: CommentStatus.pending,
        statusLabel: "Pending",
        time: "14 Aug 2025 | 10:20 AM",
      ),
      CommentEntryModel(
        userName: "Manager",
        userInitials: "MM",
        isSelf: false,
        message: "Reviewing request  with Assigned Team.",
        status: CommentStatus.pending,
        statusLabel: "Pending",
        time: "15 Aug 2025 | 12:20 AM",
      ),
      CommentEntryModel(
        userName: "Manager",
        userInitials: "MM",
        isSelf: false,
        message: "Request status changed to: Pending Validation",
        status: CommentStatus.validating,
        statusLabel: "Validating",
        time: "15 Aug 2025 | 16:20 PM",
      ),
    ];

    final fileList = [
      FileInfo(
        name: "Leave Request Stamp",
        type: "Stamp.png",
        uploadedDate: "Aug 11, 2025",
        downloadable: true,
        viewable: true,
        onDownload: () {
          /* Download logic */
        },
        onView: () {
          /* View logic */
        },
      ),
      FileInfo(
        name: "Leave Request Approval",
        type: "Request.pdf",
        uploadedDate: "Aug 12, 2025",
        downloadable: true,
        viewable: true,
        onDownload: () {
          /* Download logic */
        },
        onView: () {
          /* View logic */
        },
      ),
      FileInfo(
        name: "Error Request Pdf",
        type: "Error request.pdf",
        uploadedDate: "Aug 13, 2025",
        downloadable: true,
        viewable: true,
        onDownload: () {
          /* Download logic */
        },
        onView: () {
          /* View logic */
        },
      ),
      FileInfo(
        name: "Others",
        type: "--",
        uploadedDate: "--",
        downloadable: false,
        viewable: true,
        onDownload: null,
        onView: () {
          /* View logic (maybe disabled) */
        },
      ),
    ];

    final workflowSteps = [
      WorkflowTimelineStep(
        status: WorkflowStepStatus.submitted,
        title: "Request Submitted",
        chip: "HR Department",
        submittedBy: "Husam-Uddin",
        date: "02 sep, 2025",
      ),
      WorkflowTimelineStep(
        status: WorkflowStepStatus.approved,
        title: "Request Approved By HOS",
        approvedBy: "Al-Rehman",
        date: "03 sep, 2025",
      ),
      WorkflowTimelineStep(
        status: WorkflowStepStatus.approved,
        title: "Request Approved By Me",
        approvedBy: "HOS",
        date: "04 sep, 2025",
      ),
      WorkflowTimelineStep(
        status: WorkflowStepStatus.sent,
        title: "Email / Notification Sent",
        date: "04 sep, 2025",
      ),
    ];
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
                    RequestDetailsTabContent(),
                    CommentsRoutingOverview(entries: commentsList),
                    FileListViewMobile(files: fileList),
                    RequestWorkflowTimeline(steps: workflowSteps),
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
