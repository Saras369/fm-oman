import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class RequestActionsMenu extends StatelessWidget {
  final List<RequestAction> requestActions;
  final ValueChanged<RequestAction>? onTapAction;

  const RequestActionsMenu({
    super.key,
    required this.requestActions,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.add, size: 24, color: Colors.black54),
          ),
          10.toVerticalSizedBox,
          ...requestActions.map(
            (action) => Padding(
              padding: EdgeInsets.only(bottom: 10.toAutoScaledHeight),
              key: UniqueKey(),
              child: RequestActionCard(
                action: action,
                onTap: () => onTapAction?.call(action),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestActionCard extends StatelessWidget {
  final RequestAction action;
  final VoidCallback? onTap;

  const RequestActionCard({super.key, required this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Material(
      color: action.bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? action.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            children: [
              Icon(Icons.add, color: action.iconColor, size: 16),
              const SizedBox(width: 16),
              Text(
                action.label,
                style: TextStyle(
                  color: action.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: currentTheme.fontSizes.s12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestAction {
  final String label;
  final Color bgColor;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;

  RequestAction({
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.textColor,
    this.onTap,
  });
}
