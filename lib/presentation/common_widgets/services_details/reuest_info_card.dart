import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class RequestInfoCard extends StatelessWidget {
  final String requestFor;
  final String serviceType;
  final String description;
  /// Optional label/value rows shown under Request For / Service Type (e.g. subtype-specific fields).
  final List<({String label, String value})>? extraRows;
  const RequestInfoCard({
    super.key,
    required this.requestFor,
    required this.serviceType,
    required this.description,
    this.extraRows,
  });
  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Card(
      color: currentTheme.colors.onPrimary,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Color(0xFFF0F0F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Request Information",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _RequestInfo(label: "Request For", value: requestFor),
                ),
                Expanded(
                  child: _RequestInfo(
                    label: "Service Type",
                    value: serviceType,
                  ),
                ),
              ],
            ),
            if (extraRows != null && extraRows!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...extraRows!.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _RequestInfo(label: r.label, value: r.value),
                ),
              ),
            ],

            const SizedBox(height: 8),
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Color(0xFF757A90),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 38,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(description, style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestInfo extends StatelessWidget {
  final String label;
  final String value;
  const _RequestInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF757A90),
            ),
          ),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
