import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/experience_Info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_certificate.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_education.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/educations_list.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class EducationInfo extends ConsumerWidget {
  EducationInfo({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/auth_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 80),
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Education',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                          ),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Education',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      IconButton(
                          onPressed: () {
                            showModal(
                              const AddEducation(),
                              context,
                              color: Colors.white,
                              enableDrag: true,
                              isDismissible: true,
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                          )),
                    ],
                  ),
                  Expanded(
                      child: EducationsList(
                    educations: provider.educations,
                    removeEducation: providerNotifier.removeEducation,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Certifications',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      IconButton(
                          onPressed: () {
                            showModal(
                              const AddCertificate(),
                              context,
                              color: Colors.white,
                              enableDrag: true,
                              isDismissible: true,
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                          )),
                    ],
                  ),
                  Expanded(
                      child: EducationsList(
                    certifications: provider.certifications,
                    removeCertification: providerNotifier.removeCertificate,
                  )),
                  const SizedBox(height: 20),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExperienceInfo()));
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
