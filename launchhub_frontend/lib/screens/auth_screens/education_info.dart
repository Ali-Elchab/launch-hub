import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/screens/auth_screens/experience_Info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_certificate.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_education.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/educations_list.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:image_picker/image_picker.dart';

class EducationInfo extends StatefulWidget {
  final XFile? selectedImage;

  const EducationInfo({super.key, this.selectedImage});

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Education> educations = [
    Education(
        id: '1',
        degree: 'degree',
        organization: 'organization',
        startDate: 'startDate',
        endDate: 'endDate',
        description: 'description',
        location: ' location',
        jobSeekerId: 2),
  ];
  List<Certification> certifications = [
    Certification(
        id: '1',
        name: 'web dev',
        certificate: 'certificate',
        organization: 'organization',
        startDate: 'startDate',
        endDate: 'endDate',
        description: 'description',
        location: ' location',
        jobSeekerId: 2)
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

  void _addEducation(Education education) {
    setState(() {
      educations.add(education);
    });
  }

  void _addCertification(Certification certification) {
    setState(() {
      certifications.add(certification);
    });
  }

  void _removeEducation(Education education) {
    final educationIndex = educations.indexOf(education);
    setState(() {
      educations.remove(education);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Education deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              educations.insert(educationIndex, education);
            });
          },
        ),
      ),
    );
  }

  void _removeCertificate(Certification certification) {
    final certificateIndex = certifications.indexOf(certification);
    setState(() {
      certifications.remove(certification);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Certification deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              certifications.insert(certificateIndex, certification);
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
                      'Education',
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
                        'Education',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      IconButton(
                          onPressed: () {
                            showModal(
                              AddEducation(addEducation: _addEducation),
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
                    educations: educations,
                    removeEducation: _removeEducation,
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
                              AddCertificate(addCertificate: _addCertification),
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
                    certifications: certifications,
                    removeCertification: _removeCertificate,
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
