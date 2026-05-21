import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class FileInfo {
  final String name;
  final String type;
  final String uploadedDate;
  final bool downloadable;
  final bool viewable;
  final VoidCallback? onDownload;
  final VoidCallback? onView;

  FileInfo({
    required this.name,
    required this.type,
    required this.uploadedDate,
    this.downloadable = false,
    this.viewable = false,
    this.onDownload,
    this.onView,
  });
}

class FileItemCardMobile extends StatelessWidget {
  final FileInfo fileInfo;
  const FileItemCardMobile({super.key, required this.fileInfo});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: currentTheme.colors.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD3D8E1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Document Name',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF868E96),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              fileInfo.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF243145),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'File type',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF868E96),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fileInfo.type.isNotEmpty ? fileInfo.type : '--',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF243145),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Uploaded Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF868E96),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fileInfo.uploadedDate.isNotEmpty ? fileInfo.uploadedDate : '--',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF243145),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFD3D8E1), height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFFD3D8E1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: fileInfo.viewable ? fileInfo.onView : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View',
                          style: TextStyle(
                            color: fileInfo.viewable ? const Color(0xFF243145) : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: fileInfo.viewable ? Colors.black : Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fileInfo.downloadable ? const Color(0xFFC8232A) : const Color(0xFF6B6E70), 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      disabledBackgroundColor: const Color(0xFF6B6E70),
                      disabledForegroundColor: Colors.white,
                    ),
                    onPressed: fileInfo.downloadable ? fileInfo.onDownload : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Download',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.file_download_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FileListViewMobile extends StatelessWidget {
  final List<FileInfo> files;
  const FileListViewMobile({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Container(
      decoration: BoxDecoration(
        color: currentTheme.colors.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD3D8E1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.file_copy_outlined,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  "File List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFD3D8E1), height: 1),
            const SizedBox(height: 8),
            ListView.builder(
              itemCount: files.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, idx) =>
                  FileItemCardMobile(fileInfo: files[idx]),
            ),
          ],
        ),
      ),
    );
  }
}
