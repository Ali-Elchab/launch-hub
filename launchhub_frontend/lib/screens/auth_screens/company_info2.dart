import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/startup_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/founders.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class CompanyInfo2 extends ConsumerWidget {
  CompanyInfo2({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final linkedinController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final githubController = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(startupRegisterProvider);
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
            width: MediaQuery.of(context).size.width * 0.73,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LocationPicker(
                            onCountryChanged: ref
                                .read(startupRegisterProvider.notifier)
                                .setCountry,
                            onStateChanged: ref
                                .read(startupRegisterProvider.notifier)
                                .setStateForState,
                            country: provider.country,
                            state: provider.state,
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
                          SocialMediaLinksDropdown(
                            linkedinController: linkedinController,
                            facebookController: facebookController,
                            instagramController: instagramController,
                            githubController: githubController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate() &&
                        provider.address.trim().isNotEmpty) {
                      ref
                          .read(startupRegisterProvider.notifier)
                          .updateContactInfo(
                              emailController.text,
                              phoneController.text,
                              websiteController.text,
                              linkedinController.text,
                              facebookController.text,
                              instagramController.text,
                              githubController.text);
                      navigator(context, Founders());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
                      );
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
