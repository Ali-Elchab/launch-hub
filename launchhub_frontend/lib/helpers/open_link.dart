import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

//flutter downloader , flutter file downloader