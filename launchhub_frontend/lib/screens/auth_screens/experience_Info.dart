import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/screens/auth_screens/skills.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_experience.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/experience_list.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:image_picker/image_picker.dart';

class ExperienceInfo extends StatefulWidget {
  final XFile? selectedImage;

  const ExperienceInfo({super.key, this.selectedImage});

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Experience> experiences = [
    Experience(
        id: '1',
        position: 'degree',
        company: 'organization',
        startDate: 'startDate',
        industry: 'industry',
        type: 'fulltime',
        endDate: 'endDate',
        description: 'description',
        location: ' location',
        jobSeekerId: 2),
  ];

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

  void _addExperience(Experience experience) {
    setState(() {
      experiences.add(experience);
    });
  }

  void _removeExperience(Experience experience) {
    final experienceIndex = experiences.indexOf(experience);
    setState(() {
      experiences.remove(experience);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Experience deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              experiences.insert(experienceIndex, experience);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        text: 'Upload Profile Picture'),
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
                              AddExperience(addExperience: _addExperience),
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
                    experiences: experiences,
                    removeExperience: _removeExperience,
                  )),
                  const SizedBox(height: 20),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Skills()));
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
