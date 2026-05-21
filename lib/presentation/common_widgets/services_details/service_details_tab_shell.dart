import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

/// Horizontal chip tabs + optional employee panel + page body (passport, financial, etc.).
class ServiceDetailsTabShell extends StatefulWidget {
  final List<String> tabLabels;
  final List<IconData> tabIcons;
  final Widget Function(BuildContext context, int index) pageBuilder;
  final Widget? mobileMiddleWidget;

  const ServiceDetailsTabShell({
    super.key,
    required this.tabLabels,
    required this.tabIcons,
    required this.pageBuilder,
    this.mobileMiddleWidget,
  }) : assert(tabLabels.length == tabIcons.length);

  @override
  State<ServiceDetailsTabShell> createState() => _ServiceDetailsTabShellState();
}

class _ServiceDetailsTabShellState extends State<ServiceDetailsTabShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.tabLabels.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? currentTheme.colors.primary
                          : currentTheme.colors.onPrimary,
                      border: Border.all(
                        color: isSelected
                            ? currentTheme.colors.primary
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.tabIcons[index],
                          size: 16,
                          color: isSelected
                              ? currentTheme.colors.onPrimary
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.tabLabels[index],
                          style: TextStyle(
                            color: isSelected
                                ? currentTheme.colors.onPrimary
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          if (widget.mobileMiddleWidget != null) ...[
            widget.mobileMiddleWidget!,
            const SizedBox(height: 16),
          ],
          widget.pageBuilder(context, _selectedIndex),
        ],
      ),
    );
  }
}
