import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

// import 'package:dio/dio.dart';

openLink(context, String urlPath) async {
  final url = urlPath;
  if (!await launchUrl(Uri.parse(url))) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open  $url'),
      ),
    );
  } else {
    await launchUrl(Uri.parse(url));
  }
}

// ignore: non_constant_identifier_names
downloadFile(
    {required BuildContext context, // Add the BuildContext parameter
    String? url,
    String? name}) async {
  FileDownloader.downloadFile(
      url: url!,
      name: name,
      onProgress: (String? fileName, double? progress) {
        // Optionally, update the UI to show download progress
      },
      onDownloadCompleted: (String path) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download completed! Tap to open the file.'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                await OpenFile.open(path, type: 'csv/pdf');
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
