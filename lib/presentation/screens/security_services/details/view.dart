import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/security_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class SecurityServicesDetailsScreen extends StatefulWidget {
  final int requestId;
  final String slug;
  final String title;

  const SecurityServicesDetailsScreen({
    super.key,
    required this.requestId,
    required this.slug,
    required this.title,
  });

  @override
  State<SecurityServicesDetailsScreen> createState() =>
      _SecurityServicesDetailsScreenState();
}

class _SecurityServicesDetailsScreenState
    extends State<SecurityServicesDetailsScreen> {
  final repo = SecurityServicesRepo();
  bool isLoading = true;
  Map<String, dynamic> details = {};

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final response = await repo.fetchRequestDetails(
        widget.slug,
        widget.requestId,
      );
      if (!mounted) return;
      setState(() {
        details = response ?? {};
        isLoading = false;
      });
    } on ApiException catch (apiError) {
      Fluttertoast.showToast(msg: apiError.message, timeInSecForIosWeb: 3);
      if (mounted) setState(() => isLoading = false);
    } catch (e) {
      log('error rendering security request details $e');
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => KAppX.router.pop(),
        ),
        title: Text(
          'Security Request Details',
          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s18,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.toAutoScaledWidth),
              child: Card(
                color: currentTheme.colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: currentTheme.fontSizes.s16,
                          fontWeight: currentTheme.fontWeights.wBolder,
                          color: currentTheme.colors.secondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      if (details.isEmpty)
                        Text(
                          'No details found',
                          style: TextStyle(
                            color: currentTheme.colors.secondary.shade40,
                            fontWeight: currentTheme.fontWeights.wBold,
                          ),
                        )
                      else
                        ..._detailRows(details),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  List<Widget> _detailRows(Map<String, dynamic> data) {
    final rows = <Widget>[];
    for (final entry in data.entries) {
      if (entry.value == null) continue;
      if (entry.value is Map || entry.value is List) continue;
      rows.add(
        _DetailRow(label: _humanize(entry.key), value: '${entry.value}'),
      );
    }
    return rows;
  }

  String _humanize(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: currentTheme.colors.secondary.shade40,
                fontSize: currentTheme.fontSizes.s12,
                fontWeight: currentTheme.fontWeights.wBold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: currentTheme.colors.secondary,
                fontSize: currentTheme.fontSizes.s13,
                fontWeight: currentTheme.fontWeights.wBolder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
