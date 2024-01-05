import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/screens/startup_screens/home.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/custom_appbar.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Founders & Key Members',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
                Expanded(
                    child: Column(
                  children: [
                    InputField(
                      label: 'Founder Name',
                      validator: validator,
                    ),
                    const InputField(label: 'CEO\'s Name'),
                    const InputField(label: 'Key Executive\`s Name'),
                  ],
                )),

                // Bottom part
                SmallButton('Submit', () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                }),
                const SizedBox(height: 15),
                const BottomText(
                  text:
                      'This information will be showcased to job seekers, helping them make informed decisions about opportunities with your company.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
