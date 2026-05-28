// Model for each comment entry
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class CommentEntryModel {
  final String userName;
  final String? roleAuthority;
  final String userInitials;
  final bool isSelf;
  final String message;
  final String? statusLabel;
  final CommentStatus? status;
  final String time;
  CommentEntryModel({
    required this.userName,
    this.roleAuthority,
    required this.userInitials,
    required this.isSelf,
    required this.message,
    this.statusLabel,
    this.status,
    required this.time,
  });
}

enum CommentStatus { pending, validating, approved }

class StatusBadge extends StatelessWidget {
  final CommentStatus status;
  final String label;

  const StatusBadge({super.key, required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;
    switch (status) {
      case CommentStatus.pending:
        bg = const Color(0xFFFDF5DF);
        fg = const Color(0xFFF4B31C);
        icon = Icons.access_time;
        break;
      case CommentStatus.validating:
        bg = const Color(0xFFE2EEFF);
        fg = const Color(0xFF1A99F2);
        icon = Icons.autorenew;
        break;
      case CommentStatus.approved:
        bg = const Color(0xFFC9F1DF);
        fg = const Color(0xFF31B480);
        icon = Icons.check_circle_outline;
        break;
    }
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg, size: 17),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: currentTheme.fontSizes.s14,
            ),
          ),
        ],
      ),
    );
  }
}

// Main comment bubble widget
class CommentEntry extends StatelessWidget {
  final CommentEntryModel data;
  const CommentEntry({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final labelStyle = const TextStyle(
      color: Color(0xFF8B92A5),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
    final valueStyle = const TextStyle(
      color: Color(0xFF3B4260),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date & Time", style: labelStyle),
                    const SizedBox(height: 4),
                    Text(data.time, style: valueStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Role / Authority", style: labelStyle),
                    const SizedBox(height: 4),
                    Text(data.roleAuthority ?? data.userName, style: valueStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text("Comments & Actions", style: labelStyle),
          const SizedBox(height: 4),
          Text(data.message, style: valueStyle),
          const SizedBox(height: 16),
          Text("Status", style: labelStyle),
          const SizedBox(height: 4),
          Text(data.statusLabel ?? 'Submitted', style: valueStyle),
        ],
      ),
    );
  }
}

// Reusable input section
class AddCommentBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onAttach;
  final VoidCallback? onSend;
  final Future<void> Function(String comment)? onApprove;
  final Future<void> Function(String comment)? onReject;
  final bool showApprovalActions;
  final String? attachedFileName;

  const AddCommentBox({
    super.key,
    required this.controller,
    this.onAttach,
    this.onSend,
    this.onApprove,
    this.onReject,
    this.showApprovalActions = true,
    this.attachedFileName,
  });

  @override
  State<AddCommentBox> createState() => _AddCommentBoxState();
}

class _AddCommentBoxState extends State<AddCommentBox> {
  bool isNeedMoreInfoExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (!isNeedMoreInfoExpanded) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isNeedMoreInfoExpanded = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF146A38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
                minimumSize: const Size(140, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Need More Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.add, color: Colors.white, size: 18),
                ],
              ),
            ),
            if (widget.showApprovalActions) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                  onPressed: widget.onApprove == null
                      ? null
                      : () {
                          _showApproveDialog(context, widget.onApprove!);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF146A38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                    minimumSize: const Size(110, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                  label: const Text(
                    "Approve",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: widget.onReject == null
                      ? null
                      : () {
                          _showRejectDialog(context, widget.onReject!);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC62828),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                    minimumSize: const Size(100, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  label: const Text(
                    "Reject",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    // Need More Info Expanded state
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Need More Info",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          const Text(
            "Remarks (Optional)",
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Add your Info",
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF146A38)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: widget.onAttach,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF9CA3AF)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(120, 44),
                ),
                icon: const Icon(Icons.attach_file, color: Colors.black87, size: 18),
                label: const Text(
                  "Attach File",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          if (widget.attachedFileName != null &&
              widget.attachedFileName!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_file, size: 16, color: Color(0xFF146A38)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.attachedFileName!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF146A38),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          const Text(
            "Note : This Option is Enabled based on the Access",
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    isNeedMoreInfoExpanded = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(100, 40),
                ),
                icon: const Icon(Icons.cancel_outlined, color: Colors.black87, size: 18),
                label: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  widget.onSend?.call();
                  setState(() {
                    isNeedMoreInfoExpanded = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF146A38),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                  minimumSize: const Size(100, 40),
                ),
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                label: const Text(
                  "Send",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showApproveDialog(
    BuildContext context,
    Future<void> Function(String comment) onApprove,
  ) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (dialogContext) {
        return _ActionDialog(
          title: "Approve Request",
          iconBg: const Color(0xFFD1FADF),
          iconColor: const Color(0xFF12B76A),
          iconData: Icons.check_circle_outline,
          message: "Are you sure you want to Approve this Request ?",
          primaryBtnText: "Approve",
          primaryBtnColor: const Color(0xFF146A38),
          onConfirm: onApprove,
        );
      },
    );
  }

  void _showRejectDialog(
    BuildContext context,
    Future<void> Function(String comment) onReject,
  ) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (dialogContext) {
        return _ActionDialog(
          title: "Reject Request",
          iconBg: const Color(0xFFFEE4E2),
          iconColor: const Color(0xFFD92D20),
          iconData: Icons.delete_outline,
          message: "Are you sure you want to Reject this Request ?",
          primaryBtnText: "Reject",
          primaryBtnColor: const Color(0xFFC62828),
          warningText: "This action cannot be undone",
          onConfirm: onReject,
        );
      },
    );
  }
}

class _ActionDialog extends StatefulWidget {
  final String title;
  final Color iconBg;
  final Color iconColor;
  final IconData iconData;
  final String message;
  final String primaryBtnText;
  final Color primaryBtnColor;
  final String? warningText;
  final Future<void> Function(String comment) onConfirm;

  const _ActionDialog({
    required this.title,
    required this.iconBg,
    required this.iconColor,
    required this.iconData,
    required this.message,
    required this.primaryBtnText,
    required this.primaryBtnColor,
    required this.onConfirm,
    this.warningText,
  });

  @override
  State<_ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<_ActionDialog> {
  late final TextEditingController _remarksController;
  late final FocusNode _remarksFocusNode;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _remarksController = TextEditingController();
    _remarksFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _remarksFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _remarksFocusNode.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _closeDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _handleConfirm() async {
    if (_isSubmitting) return;
    _isSubmitting = true;

    final comment = _remarksController.text.trim();
    final onConfirm = widget.onConfirm;
    _closeDialog();
    await Future<void>.delayed(Duration.zero);
    await onConfirm(comment);
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: _closeDialog,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, color: Colors.black54, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.iconData, color: widget.iconColor, size: 28),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Remarks",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _remarksController,
                focusNode: _remarksFocusNode,
                autofocus: true,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Add your Remark",
                  hintStyle: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFF146A38)),
                  ),
                ),
              ),
              if (widget.warningText != null) ...[
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    widget.warningText!,
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: _isSubmitting ? null : _closeDialog,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: const Size(100, 40),
                    ),
                    icon: const Icon(Icons.cancel_outlined, color: Colors.black87, size: 18),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryBtnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                      minimumSize: const Size(110, 40),
                    ),
                    icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                    label: Text(
                      widget.primaryBtnText,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Overview Section
class CommentsRoutingOverview extends StatelessWidget {
  final List<CommentEntryModel> entries;
  final TextEditingController controller = TextEditingController();

  CommentsRoutingOverview({super.key, required this.entries});

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
              controller: controller,
              showApprovalActions: false,
              onAttach: () {
                /* Attach callback */
              },
              onSend: () {
                /* Send callback */
              },
            ),
          ],
        ),
      ),
    );
  }
}
