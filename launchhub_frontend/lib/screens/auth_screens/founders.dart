import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Founders extends StatefulWidget {
  final XFile? selectedImage;

  const Founders({super.key, required this.selectedImage});

  @override
  State<Founders> createState() => _FoundersState();
}

class _FoundersState extends State<Founders> {
  XFile? _image;
  // Assuming dynamicFieldsCount is the number of dynamic fields
  int dynamicFieldsCount = 10; // Initialize with a default value

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 280,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Founders & Key Members',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 21,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              if (widget.selectedImage != null)
                ClipOval(
                  child: Image.file(
                    File(widget.selectedImage!.path),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              if (widget.selectedImage == null)
                ProfileImagePicker(
                  onImagePicked: () async {
                    await _pickImage();
                  },
                  imageFile: _image,
                  text: 'Upload Logo',
                ),
              const SizedBox(height: 32),

              // Scrollable part for dynamic input fields
              const Expanded(
                  child: Column(
                children: [
                  InputField(label: 'Founder Name'),
                  InputField(label: 'CEO\'s Name'),
                  InputField(label: 'Key Executive\`s Name'),
                ],
              )),

              // Bottom part
              SmallButton('Next', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              }),
              const SizedBox(height: 15),
              const BottomText(),
            ],
          ),
        ),
      ),
    );
  }
}
