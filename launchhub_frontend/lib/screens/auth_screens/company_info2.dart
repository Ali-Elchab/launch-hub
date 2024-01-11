import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/founders.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:image_picker/image_picker.dart';

class CompanyInfo2 extends StatefulWidget {
  final XFile? selectedImage;

  const CompanyInfo2({super.key, required this.selectedImage});

  @override
  State<CompanyInfo2> createState() => _CompanyInfo2State();
}

class _CompanyInfo2State extends State<CompanyInfo2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _image;
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
      resizeToAvoidBottomInset:
          true, // Set to true to resize when keyboard appears
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              // Use Column without Expanded
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Contact Information',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                if (widget.selectedImage != null)
                  ClipOval(
                    child: Image.file(
                      File(widget.selectedImage!.path),
                      width: 120, // Diameter of the circle
                      height: 120, // Diameter of the circle
                      fit: BoxFit
                          .cover, // This ensures the image covers the circle crop
                    ),
                  ),
                if (widget.selectedImage == null)
                  ProfileImagePicker(
                      onImagePicked: () async {
                        await _pickImage();
                      },
                      imageFile: _image,
                      text: 'Upload Logo'),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputField(
                            label: 'Business Address', validator: validator),
                        InputField(label: 'Phone Number', validator: validator),
                        InputField(
                            label: 'Email Address', validator: validator),
                        const InputField(label: 'Website URL'),
                        const SocialMediaLinksDropdown(),
                      ],
                    ),
                  ),
                ),
                SmallButton('Next', () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Founders(
                                  selectedImage: widget.selectedImage,
                                )));
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
