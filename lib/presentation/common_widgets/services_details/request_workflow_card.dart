import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

enum WorkflowStepStatus {
  submitted,
  approved,
  pending,
  validating,
  sent,
  inactive,
}

class WorkflowTimelineStep {
  final WorkflowStepStatus status;
  final String title;
  final String? chip;
  final String? submittedBy;
  final String? date;
  final String? approvedBy;
  final bool isCurrent;

  WorkflowTimelineStep({
    required this.status,
    required this.title,
    this.chip,
    this.submittedBy,
    this.date,
    this.approvedBy,
    this.isCurrent = false,
  });
}

class RequestWorkflowTimeline extends StatelessWidget {
  final List<WorkflowTimelineStep> steps;
  final String heading;

  const RequestWorkflowTimeline({
    super.key,
    required this.steps,
    this.heading = "Request Workflow",
  });

  Color _indicatorColor(WorkflowStepStatus s) {
    switch (s) {
      case WorkflowStepStatus.submitted:
        return const Color(0xFF232B74);
      case WorkflowStepStatus.approved:
        return const Color(0xFF31B480);
      case WorkflowStepStatus.pending:
        return const Color(0xFFFFA713);
      case WorkflowStepStatus.validating:
        return const Color(0xFF2196F3);
      case WorkflowStepStatus.sent:
        return const Color(0xFF969CA9);
      case WorkflowStepStatus.inactive:
        return const Color(0xFFBFC7C9);
    }
  }

  Widget _indicatorWidget(
    WorkflowStepStatus status,
    bool completed,
    int index,
  ) {
    const double size = 28;
    IconData? icon;
    String? text;
    Color color;
    Widget? customInner;

    switch (status) {
      case WorkflowStepStatus.submitted:
        icon = Icons.playlist_add_check;
        color = const Color(0xFF232B74);
        break;
      case WorkflowStepStatus.approved:
      case WorkflowStepStatus.validating:
        icon = Icons.check;
        color = const Color(0xFF45A14A); // Green check
        break;
      case WorkflowStepStatus.pending:
        color = const Color(0xFFD68B0A); // Orange
        customInner = Container(
          width: size * 0.45,
          height: size * 0.45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              width: size * 0.2,
              height: size * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
        );
        break;
      case WorkflowStepStatus.sent:
      case WorkflowStepStatus.inactive:
      default:
        text = (index + 1).toString();
        color = const Color(0xFF9096A0); // Grey
        break;
    }

    return IndicatorCircle(
      size: size,
      color: color,
      icon: icon,
      text: text,
      customInner: customInner,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Color(0xFFF0F0F0)),
      ),

      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_tree,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Text(
                  heading,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: currentTheme.fontSizes.s16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFD3D8E1), height: 1),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: steps.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                final curr = steps[i];
                final showConnector = i < steps.length - 1;
                final completed = true; // Not strictly used for styling now as status handles it

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline indicator + connector
                      Column(
                        children: [
                          _indicatorWidget(curr.status, completed, i),
                          if (showConnector)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: const Color(0xFFD6D8DD),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Step content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                curr.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: currentTheme.fontSizes.s14,
                                  color: (curr.status == WorkflowStepStatus.inactive || curr.status == WorkflowStepStatus.sent)
                                      ? Colors.grey[500]
                                      : Colors.black87,
                                ),
                              ),
                              if (curr.chip != null) ...[
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F6FE),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Text(
                                    curr.chip!,
                                    style: TextStyle(
                                      color: const Color(0xFF484D81),
                                      fontWeight: FontWeight.w500,
                                      fontSize: currentTheme.fontSizes.s12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                              if (curr.submittedBy != null) ...[
                                const SizedBox(height: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: const Color(0xFF9096A0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: currentTheme.fontSizes.s13,
                                    ),
                                    children: [
                                      const TextSpan(text: "Submitted by: "),
                                      TextSpan(
                                        text: curr.submittedBy!,
                                        style: const TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              if (curr.date != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  curr.date!,
                                  style: TextStyle(
                                    color: const Color(0xFF243145),
                                    fontSize: currentTheme.fontSizes.s12,
                                  ),
                                ),
                              ],
                              if (curr.approvedBy != null) ...[
                                const SizedBox(height: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: const Color(0xFF9096A0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: currentTheme.fontSizes.s13,
                                    ),
                                    children: [
                                      const TextSpan(text: "Approved by : "),
                                      TextSpan(
                                        text: curr.approvedBy!,
                                        style: const TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IndicatorCircle extends StatelessWidget {
  final double size;
  final Color color;
  final IconData? icon;
  final String? text;
  final Widget? customInner;

  const IndicatorCircle({
    super.key,
    required this.size,
    required this.color,
    this.icon,
    this.text,
    this.customInner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 10,
      height: size + 10,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: customInner ??
                (icon != null
                    ? Icon(icon, color: Colors.white, size: size * 0.55)
                    : (text != null
                        ? Text(text!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13))
                        : const SizedBox.shrink())),
          ),
        ),
      ),
    );
  }
}
