import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

openLink(context, String urlPath) async {
  final url = urlPath;
  if (!await launchUrl(Uri.parse(url))) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open  $url'),
      ),
    );
  } else {
    await launchUrl(Uri.parse(url));
  }
}

downloadFile({required BuildContext context, String? url, String? name}) async {
  await requestStoragePermission();

  FileDownloader.downloadFile(
      url: url!,
      name: name,
      onProgress: (String? fileName, double? progress) {},
      onDownloadCompleted: (String path) {
        // Decode the file path
        String decodedPath = Uri.decodeFull(path);
        print('Downloaded $decodedPath');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Download completed! Tap to open the file.'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                if (await File(decodedPath).exists()) {
                  String fileType = getFileTypeFromExtension(decodedPath);
                  try {
                    print(fileType);
                    print(decodedPath);
                    await OpenFile.open(decodedPath, type: fileType);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error opening file: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File not found: $decodedPath')),
                  );
                }
              },
            ),
          ),
        );
      },
      onDownloadError: (String error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download error: $error'),
          ),
        );
      });
}

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

String getFileTypeFromExtension(String filePath) {
  // Extract the file extension from the file path
  String extension = filePath.split('.').last.toLowerCase();

  Map<String, String> extensionToType = {
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'xls': 'application/vnd.ms-excel',
    'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    // Add more extensions and corresponding types as needed
  };

  // Return the appropriate type for the given extension, or a default type
  return extensionToType[extension] ?? 'application/octet-stream';
}
