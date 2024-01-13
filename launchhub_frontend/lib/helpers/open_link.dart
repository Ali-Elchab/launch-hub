import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dio/dio.dart';

openLink(context, String urlPath) async {
  final url = urlPath;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open  $url'),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
// downloadFile({String? url, String? name}) async {
//   FileDownloader.downloadFile(
//       url: url!,
//       name: name,
//       onProgress: (String? fileName, double? progress) {
//         print('FILE $fileName HAS PROGRESS $progress');
//       },
//       onDownloadCompleted: (String path) {
//         print('FILE DOWNLOADED TO PATH: $path');
//       },
//       onDownloadError: (String error) {
//         print('DOWNLOAD ERROR: $error');
//       });
// }

Future<void> downloadFile(String url, String fileName) async {
  Dio dio = Dio();

  try {
    // Get the directory where the downloaded files will be stored
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';

    // Use Dio to download the file
    await dio.download(url, savePath);

    // File is downloaded and saved to savePath
    print('File is downloaded to $savePath');
  } catch (e) {
    // Handle errors
    print(e.toString());
  }
}
