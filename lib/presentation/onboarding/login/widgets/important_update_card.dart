import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

class ImportantUpdateCard extends StatelessWidget {
  final String lastUpdate;
  final List<String> infoList;

  ImportantUpdateCard({required this.lastUpdate, required this.infoList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Based on mobile size, you can wrap with SafeArea if displayed as dialog
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Important Update",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "This information may contain important notices or upcoming events.",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Last Update Date
            Text(
              "Last Update : $lastUpdate",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            // Top info text
            Text(
              "FM's Security & Privacy policy addresses FM's practices related to information collection & usage of your personal information.",
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 14),

            // Information Collection Section header
            Text(
              "Information Collection & Usage",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Scrollable area for bullet points
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.35,
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: infoList
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("• ", style: theme.textTheme.bodyMedium),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Button: Acknowledge & Close (fills width for mobile ergonomics)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Navigator.of(context).maybePop();

                  final dio = Dio();

                  (dio.httpClientAdapter as DefaultHttpClientAdapter)
                      .onHttpClientCreate = (HttpClient client) {
                    client.badCertificateCallback =
                        (X509Certificate cert, String host, int port) => true;
                    return client;
                  };

                  // Then perform your request
                  // final response = await dio.get('https://caa.altomouhit.com/v1/user-service/service/bookmarks/1');

                  final response = await dio.get(
                    'https://caa.altomouhit.com/v1/user-service/service/bookmarks/1',
                  );
                  print(response.data);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Acknowledge & Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
