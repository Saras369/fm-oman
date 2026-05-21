import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class StatusBadgeMobile extends StatelessWidget {
  final String status;
  const StatusBadgeMobile({required this.status});

  @override
  Widget build(BuildContext context) {
    late Color bgColor;
    late Color textColor;
    late IconData icon;
    late String label;

    switch (status) {
      case 'approved':
        bgColor = const Color(0xFFC9F1DF);
        textColor = const Color(0xFF31B480);
        icon = Icons.check_circle_outline;
        label = "Approved";
        break;
      case 'completed':
        bgColor = const Color(0xFFC9F1DF);
        textColor = const Color(0xFF31B480);
        icon = Icons.check_circle_outline;
        label = "Completed";
        break;

      case 'pending':
        bgColor = const Color(0xFFFDF5DF);
        textColor = const Color(0xFFF4B31C);
        icon = Icons.access_time;
        label = "Pending";
        break;
      case 'in progress':
        bgColor = const Color(0xFFFDF5DF);
        textColor = const Color(0xFFF4B31C);
        icon = Icons.access_time;
        label = "Pending";
        break;
      case 'rejected':
        bgColor = const Color(0xFFFFE2E2);
        textColor = const Color(0xFFD13239);
        icon = Icons.cancel_outlined;
        label = "Rejected";
        break;
      default:
        bgColor = const Color(0xFFE0E0E0); // Light grey as default
        textColor = Colors.black;
        icon = Icons.help_outline;
        label = "Unknown";
        break;
    }

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 18.toAutoScaledWidth),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: currentTheme.fontSizes.s14,
            ),
          ),
        ],
      ),
    );
  }
}
