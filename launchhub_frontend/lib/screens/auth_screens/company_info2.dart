import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
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
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final socialMediaController = TextEditingController();

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 85),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/auth_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Contact Information',
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge,
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
                        text: 'Upload Logo'),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InputField(
                            label: 'Business Address',
                            validator: validator,
                            controller: addressController,
                          ),
                          InputField(
                            label: 'Phone Number',
                            validator: validator,
                            controller: phoneController,
                          ),
                          InputField(
                            label: 'Email Address',
                            validator: validator,
                            controller: emailController,
                          ),
                          InputField(
                            label: 'Website URL',
                            controller: websiteController,
                          ),
                          const SocialMediaLinksDropdown(),
                        ],
                      ),
                    ),
                  ),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      navigator(
                          context,
                          Founders(
                            selectedImage: widget.selectedImage,
                          ));
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
      ),
    );
  }
}
