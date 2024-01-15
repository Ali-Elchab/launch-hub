// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/skills.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_experience.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/experience_list.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:path/path.dart' as path;

class ExperienceInfo extends ConsumerWidget {
  ExperienceInfo({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      'Experience',
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
                        'Work Experience',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      IconButton(
                          onPressed: () {
                            showModal(
                              const AddExperience(),
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
                      child: ExperienceList(
                    experiences: provider.experiences,
                    removeExperience: providerNotifier.removeExperience,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: InputField(
                      label: 'Upload Resume Here',
                      readOnly: true,
                      controller: TextEditingController(
                          text: path.basename(provider.resumeFile?.path ?? '')),
                      icon: const Icon(Icons.upload_file),
                      onTap: () => providerNotifier.pickFile(),
                    ),
                  ),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      navigator(context, const Skills());
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
