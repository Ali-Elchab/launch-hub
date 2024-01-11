import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/screens/auth_screens/skills.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/educations_list.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Set to true to resize when keyboard appears
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Education',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
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
                  children: [
                    Text(
                      'Add Education',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                    )
                  ],
                ),
                Expanded(child: EducationsList(educations: educations)),
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
    );
  }
}
