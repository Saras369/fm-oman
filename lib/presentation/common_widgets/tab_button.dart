import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  const TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.toAutoScaledHeight,
          decoration: BoxDecoration(
            color: selected ? Colors.black : const Color(0xFFEBECF0),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.toAutoScaledWidth,
                color: selected ? Colors.white : const Color(0xFF5E6D88),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF8693A7),
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: currentTheme.fontSizes.s16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
