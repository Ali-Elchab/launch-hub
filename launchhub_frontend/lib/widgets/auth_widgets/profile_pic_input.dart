import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final XFile? imageFile;
  final Future<void> Function()? onImagePicked;
  final Uint8List? decodedImage;
  final String text;
  const ProfileImagePicker({
    super.key,
    this.imageFile,
    this.onImagePicked,
    this.decodedImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePicked,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: decodedImage != null
            ? MemoryImage(decodedImage!)
            : imageFile != null
                ? FileImage(File(imageFile!.path))
                : const AssetImage('assets/backgrounds/grey.png')
                    as ImageProvider<Object>, // Placeholder transparent image

        child: (imageFile == null && decodedImage == null)
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
