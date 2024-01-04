import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  XFile? _image;
  List<String> selectedSkills = [];

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

  void toggleSkill(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 280,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Skills',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              ProfileImagePicker(
                  onImagePicked: () async {
                    await _pickImage();
                  },
                  imageFile: _image,
                  text: 'Upload Profile Picture'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  style: Theme.of(context).textTheme.labelSmall!,
                  'Highlight your strengths and abilities for others to see and recognize.',
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 9.0,
                        runSpacing: 4.0,
                        children: skills
                            .map((skill) => ChoiceTag(
                                  label: skill,
                                  isSelected: selectedSkills.contains(skill),
                                  onSelected: () => toggleSkill(skill),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SmallButton('Next', () {}),
              const SizedBox(height: 15),
              const BottomText(
                  text:
                      'Your provided details will be utilized to shape a personalized resume, presenting your unique skills and experiences to startups seeking candidates like you.'),
            ],
          ),
        ),
      ),
    );
  }
}
