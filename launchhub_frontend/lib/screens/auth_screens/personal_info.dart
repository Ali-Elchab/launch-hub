import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/contact_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class PersonalInfo extends ConsumerStatefulWidget {
  const PersonalInfo({super.key});

  @override
  ConsumerState<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends ConsumerState<PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    ref.read(jobSeekerRegisterProvider.notifier).getIndustries();
    super.initState();
  }

  Future getNiches() async {
    await ref.read(jobSeekerRegisterProvider.notifier).getNiches();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
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
    final provider = ref.watch(jobSeekerRegisterProvider);
    final providerNotifier = ref.read(jobSeekerRegisterProvider.notifier);
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
                      'Personal Information',
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 35),
                  ProfileImagePicker(
                      onImagePicked: () async {
                        await providerNotifier.pickImage();
                      },
                      imageFile: provider.selectedImage,
                      text: 'Upload Profile Picture'),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          InputField(
                              label: 'First Name',
                              validator: validator,
                              controller: firstNameController),
                          InputField(
                              label: 'Last Name',
                              validator: validator,
                              controller: lastNameController),
                          InputField(
                            label: 'Date of Birth',
                            readOnly: true,
                            icon: const Icon(Icons.calendar_today),
                            controller: provider.date,
                            onTap: () => providerNotifier.selectDate(context),
                            validator: validator,
                          ),
                          InputField(
                              label: 'Phone Number',
                              validator: validator,
                              controller: phoneController),
                          InputField(
                              label: 'Professional Biography',
                              isDescription: true,
                              controller: bioController,
                              validator: validator),
                          GenericDropdown<Industry>(
                            label: 'Select Industry',
                            options: provider.industries,
                            selectedOption: provider.selectedIndustry,
                            optionLabel: (industry) => industry!.name,
                            onChanged: (newValue) async {
                              providerNotifier.setSelectedIndustry(newValue!);
                              await getNiches();
                            },
                          ),
                          GenericDropdown<Niche>(
                            label: 'Select Specialization',
                            options: provider.niches,
                            selectedOption: provider.selectedNiche,
                            optionLabel: (niche) => niche!.name,
                            onChanged: (newValue) {
                              providerNotifier.setSelectedNiche(newValue!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate() &&
                        provider.selectedNiche != null &&
                        provider.selectedIndustry != null) {
                      providerNotifier.updatePersonalInfo(
                          firstNameController.text,
                          lastNameController.text,
                          phoneController.text,
                          bioController.text);
                      navigator(
                        context,
                        ContactInfo(),
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
