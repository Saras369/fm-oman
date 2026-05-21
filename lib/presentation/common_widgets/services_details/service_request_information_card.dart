import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

/// Shared "Request Information" panel used by passport, financial, and similar
/// service detail flows. Pass a flat map of label → display value.
class ServiceRequestInformationCard extends StatelessWidget {
  final Map<String, dynamic> infoData;
  final String title;
  final IconData leadingIcon;

  const ServiceRequestInformationCard({
    super.key,
    required this.infoData,
    this.title = 'Request Information',
    this.leadingIcon = Icons.filter_alt_outlined,
  });

  static String formatCellValue(dynamic value) {
    if (value == null) return 'N/A';
    final s = value is String ? value : value.toString();
    final t = s.trim();
    return t.isEmpty ? 'N/A' : t;
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    final keys = infoData.keys.toList();

    return Card(
      color: currentTheme.colors.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFECECF0), width: 1),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  leadingIcon,
                  color: const Color(0xFF23272F),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: currentTheme.fontSizes.s16,
                    color: const Color(0xFF23272F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFECECF0), height: 1, thickness: 1),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 16) / 2;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: keys.map((key) {
                    final value = formatCellValue(infoData[key]);
                    return SizedBox(
                      width: itemWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key,
                            style: TextStyle(
                              fontSize: currentTheme.fontSizes.s13,
                              color: const Color(0xFF757A90),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3B4260),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
