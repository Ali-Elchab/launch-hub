import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_seeker_home.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Hobbies extends StatefulWidget {
  const Hobbies({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HobbiesState createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  XFile? _image;
  List<String> selectedHobbies = [];

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

  void togglehobby(String hobby) {
    setState(() {
      if (selectedHobbies.contains(hobby)) {
        selectedHobbies.remove(hobby);
      } else {
        selectedHobbies.add(hobby);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hobbies',
                    textAlign: TextAlign.left,
                    style: textTheme.titleLarge,
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
                    style: textTheme.labelSmall!,
                    'Showcase your passions and interests to connect and share with like-minded individuals.',
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
                          children: mockHobbies
                              .map((hobby) => ChoiceTag(
                                    label: hobby.name,
                                    isSelected:
                                        selectedHobbies.contains(hobby.name),
                                    onSelected: () => togglehobby(hobby.name),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SmallButton('Submit', () {
                  navigator(context, const JobSeekerHome());
                }, showArrow: false),
                const SizedBox(height: 15),
                const BottomText(
                    text:
                        'Your provided details will be utilized to shape a personalized resume, presenting your unique hobbys and experiences to startups seeking candidates like you.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
