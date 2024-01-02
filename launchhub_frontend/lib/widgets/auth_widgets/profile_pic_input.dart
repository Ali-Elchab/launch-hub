import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final XFile? imageFile;
  final Future<void> Function() onImagePicked;
  final String text;
  const ProfileImagePicker({
    super.key,
    required this.imageFile,
    required this.onImagePicked,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePicked,
      child: CircleAvatar(
        radius: 60, // Adjust the radius as needed
        backgroundImage:
            imageFile != null ? FileImage(File(imageFile!.path)) : null,
        child: imageFile == null
            ? Container(
                decoration: const BoxDecoration(
                  color:
                      Colors.black38, // Semi-transparent overlay when no image
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_a_photo, size: 40, color: Colors.white),
                      Text("Upload Logo",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
