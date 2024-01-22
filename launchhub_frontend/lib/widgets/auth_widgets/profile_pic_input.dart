import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/config/base_dio.dart';

class ProfileImagePicker extends StatelessWidget {
  final XFile? imageFile;
  final Future<void> Function()? onImagePicked;
  final String? image;
  final String text;
  const ProfileImagePicker({
    super.key,
    this.imageFile,
    this.onImagePicked,
    this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePicked,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60,
        onBackgroundImageError: (exception, stackTrace) {
          print(exception);
        },
        backgroundImage: image != null
            ? NetworkImage("${baseUrl}assets/images/profile_pics/$image")
            : const AssetImage('assets/logos/default-logo.png')
                as ImageProvider,
        child: (imageFile == null && image == null)
            ? Container(
                decoration: const BoxDecoration(
                  color:
                      Colors.black38, // Semi-transparent overlay when no image
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.add_a_photo,
                          size: 32, color: Colors.white),
                      const SizedBox(height: 5),
                      Text(text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
