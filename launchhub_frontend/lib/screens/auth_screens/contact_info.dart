import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/education_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class ContactInfo extends ConsumerWidget {
  ContactInfo({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
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
    final provider = ref.watch(jobSeekerRegisterProvider);
    final providerNotifier = ref.read(jobSeekerRegisterProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
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
                  ClipOval(
                    child: provider.selectedImage != null
                        ? Image.file(File(provider.selectedImage!.path),
                            width: 120, height: 120, fit: BoxFit.cover)
                        : Image.asset('assets/logos/default-profile.png',
                            width: 120, height: 120, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LocationPicker(
                            onCountryChanged: providerNotifier.setCountry,
                            onStateChanged: providerNotifier.setStateForState,
                            country: provider.country,
                            state: provider.state,
                          ),
                          InputField(
                              label: 'Phone Number', validator: validator),
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
                      providerNotifier.updateContactInfo(
                          phoneController.text,
                          linkedinController.text,
                          facebookController.text,
                          instagramController.text,
                          githubController.text);
                      navigator(context, EducationInfo());
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
                          'Your provided details will be utilized to shape a personalized resume, presenting your unique skills and experiences to startups seeking candidates like you.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
