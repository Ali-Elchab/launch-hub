import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/startup_register_provider.dart';
import 'package:launchhub_frontend/screens/startup_screens/startup_home.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Founders extends ConsumerWidget {
  Founders({super.key});

  final foundersController = TextEditingController();
  final ceoController = TextEditingController();
  final keyExecutiveController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(startupRegisterProvider);
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
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Founders & Key Members',
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 35),
                  if (provider.selectedImage != null)
                    ClipOval(
                      child: Image.file(
                        File(provider.selectedImage!.path),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (provider.selectedImage == null)
                    ProfileImagePicker(
                        onImagePicked: () async {
                          await ref
                              .read(startupRegisterProvider.notifier)
                              .pickImage();
                        },
                        imageFile: provider.selectedImage,
                        text: 'Upload Logo'),
                  const SizedBox(height: 32),

                  // Scrollable part for dynamic input fields
                  Expanded(
                      child: Column(
                    children: [
                      InputField(
                        label: 'Founder Name',
                        validator: validator,
                        controller: foundersController,
                      ),
                      InputField(
                        label: 'CEO\'s Name',
                        validator: validator,
                        controller: ceoController,
                      ),
                      InputField(
                        label: 'Key Executive`s Name',
                        validator: validator,
                        controller: keyExecutiveController,
                      ),
                    ],
                  )),

                  SmallButton('Submit', () {
                    if (_formKey.currentState!.validate()) {
                      navigator(context, const StartupHome());
                    }
                  }, showArrow: false),
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
